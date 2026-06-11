package com.jucheonsu.port.domain.project.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jucheonsu.port.domain.block.converter.BlockConverter;
import com.jucheonsu.port.domain.block.repository.BlockRepository;
import com.jucheonsu.port.domain.document.repository.ProjectDocumentRepository;
import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSaveRequest;
import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSelectionRequest;
import com.jucheonsu.port.domain.project.dto.response.ProjectWritingSessionResponse;
import com.jucheonsu.port.domain.project.entity.Project;
import com.jucheonsu.port.domain.project.entity.ProjectWritingSession;
import com.jucheonsu.port.domain.project.enums.ProjectWritingStatus;
import com.jucheonsu.port.domain.project.repository.ProjectRepository;
import com.jucheonsu.port.domain.project.repository.ProjectWritingSessionRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import com.jucheonsu.port.infra.openai.OpenAiClient;
import com.jucheonsu.port.infra.ppt.PptExportService;
import com.jucheonsu.port.infra.ppt.PptSlideBuilder;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProjectWritingServiceImpl implements ProjectWritingService {

    private final ProjectRepository projectRepository;
    private final ProjectDocumentRepository projectDocumentRepository;
    private final ProjectWritingSessionRepository sessionRepository;
    private final BlockRepository blockRepository;
    private final OpenAiClient openAiClient;
    private final PptSlideBuilder pptSlideBuilder;
    private final PptExportService pptExportService;
    private final ObjectMapper objectMapper;

    @Override
    @Transactional
    public ProjectWritingSessionResponse getSession(Long projectId) {
        return toResponse(getOrCreateSession(getProject(projectId)));
    }

    @Override
    @Transactional
    public ProjectWritingSessionResponse selectSources(Long projectId, ProjectWritingSelectionRequest request) {
        Project project = getProject(projectId);
        if (!project.getPortfolio().getId().equals(request.portfolioId())) {
            throw new CustomException(ErrorCode.ACCESS_DENIED);
        }

        ProjectWritingSession session = getOrCreateSession(project);
        Map<String, Object> snapshot = buildSnapshot(project.getPortfolio(), request.projectIds(), request.documentIds());
        session.markSelected(
                project.getRole(),
                writeJson(Map.of(
                        "portfolioId", request.portfolioId(),
                        "projectIds", normalizeIds(request.projectIds()),
                        "documentIds", normalizeIds(request.documentIds())
                )),
                writeJson(snapshot)
        );
        return toResponse(session);
    }

    @Override
    @Transactional
    public ProjectWritingSessionResponse saveDraft(Long projectId, ProjectWritingSaveRequest request) {
        ProjectWritingSession session = getOrCreateSession(getProject(projectId));
        session.saveDraft(
                request.progress(),
                writeJson(request.sectionDrafts() == null ? Map.of() : request.sectionDrafts()),
                writeJson(request.sectionStatuses() == null ? Map.of() : request.sectionStatuses())
        );
        return toResponse(session);
    }

    @Override
    @Transactional
    public ProjectWritingSessionResponse createDocument(Long projectId) {
        ProjectWritingSession session = getOrCreateSession(getProject(projectId));
        Map<String, String> sectionDrafts = readStringMap(session.getSectionDraftJson());
        String documentText = buildDocumentText(sectionDrafts, session.getSourceSnapshotJson());
        session.markDocumentCreated(documentText, completeRatio(sectionDrafts, session.getSectionStatusJson()));
        return toResponse(session);
    }

    @Override
    @Transactional
    public ProjectWritingSessionResponse reviewDocument(Long projectId) {
        ProjectWritingSession session = getOrCreateSession(getProject(projectId));
        String source = StringUtils.hasText(session.getDocumentText())
                ? session.getDocumentText()
                : buildDocumentText(readStringMap(session.getSectionDraftJson()), session.getSourceSnapshotJson());
        String reviewed = openAiClient.generateReview(source);
        if (!StringUtils.hasText(reviewed)) {
            reviewed = source;
        }
        session.markReviewed(reviewed);
        return toResponse(session);
    }

    @Override
    @Transactional
    public ProjectWritingSessionResponse createPresentation(Long projectId) {
        ProjectWritingSession session = getOrCreateSession(getProject(projectId));
        String source = StringUtils.hasText(session.getReviewedDocument())
                ? session.getReviewedDocument()
                : session.getDocumentText();
        if (!StringUtils.hasText(source)) {
            source = buildDocumentText(readStringMap(session.getSectionDraftJson()), session.getSourceSnapshotJson());
        }
        String presentationJson = pptSlideBuilder.buildPresentationJson(session.getProject().getPortfolio().getId(), source);
        session.markPptCreated(presentationJson);
        return toResponse(session);
    }

    @Override
    @Transactional
    public byte[] exportPptx(Long projectId) {
        ProjectWritingSession session = getOrCreateSession(getProject(projectId));
        String source = StringUtils.hasText(session.getPresentationJson())
                ? session.getPresentationJson()
                : pptSlideBuilder.buildPresentationJson(
                session.getProject().getPortfolio().getId(),
                firstNonBlank(
                        session.getReviewedDocument(),
                        session.getDocumentText(),
                        buildDocumentText(readStringMap(session.getSectionDraftJson()), session.getSourceSnapshotJson())
                )
        );
        session.markPptCreated(source);
        return pptExportService.exportPortfolio(session.getProject().getPortfolio().getId(), source);
    }

    private Project getProject(Long projectId) {
        return projectRepository.findById(projectId)
                .orElseThrow(() -> new CustomException(ErrorCode.PROJECT_NOT_FOUND));
    }

    private ProjectWritingSession getOrCreateSession(Project project) {
        return sessionRepository.findByProjectId(project.getId())
                .orElseGet(() -> sessionRepository.save(ProjectWritingSession.builder()
                        .project(project)
                        .role(project.getRole())
                        .status(ProjectWritingStatus.NOT_STARTED)
                        .progress(0)
                        .build()));
    }

    private Map<String, Object> buildSnapshot(Portfolio portfolio, List<Long> projectIds, List<Long> documentIds) {
        List<Project> projects = projectRepository.findAllByPortfolioIdOrderByOrderIndex(portfolio.getId());
        List<Long> targetProjectIds = normalizeIds(projectIds);
        List<Long> targetDocumentIds = normalizeIds(documentIds);
        List<Map<String, Object>> projectSnapshots = new ArrayList<>();

        for (Project project : projects) {
            if (!targetProjectIds.isEmpty() && !targetProjectIds.contains(project.getId())) {
                continue;
            }

            List<Map<String, Object>> documentSnapshots = projectDocumentRepository.findAllByProjectIdOrderByOrderIndexAsc(project.getId()).stream()
                    .filter(document -> targetDocumentIds.isEmpty() || targetDocumentIds.contains(document.getId()))
                    .map(document -> {
                        Map<String, Object> doc = new LinkedHashMap<>();
                        doc.put("id", document.getId());
                        doc.put("title", document.getTitle());
                        doc.put("category", document.getCategory());
                        doc.put("icon", document.getIcon());
                        doc.put("blocks", blockRepository.findAllByDocumentIdOrderByOrderIndexAsc(document.getId()).stream()
                                .map(BlockConverter::toResponse)
                                .toList());
                        return doc;
                    })
                    .toList();

            Map<String, Object> projectSnapshot = new LinkedHashMap<>();
            projectSnapshot.put("id", project.getId());
            projectSnapshot.put("name", project.getName());
            projectSnapshot.put("role", project.getRole());
            projectSnapshot.put("summary", project.getSummary());
            projectSnapshot.put("documents", documentSnapshots);
            projectSnapshots.add(projectSnapshot);
        }

        Map<String, Object> snapshot = new LinkedHashMap<>();
        snapshot.put("portfolioId", portfolio.getId());
        snapshot.put("portfolioTitle", portfolio.getTitle());
        snapshot.put("projects", projectSnapshots);
        return snapshot;
    }

    private String buildDocumentText(Map<String, String> sectionDrafts, String sourceSnapshotJson) {
        StringBuilder builder = new StringBuilder();
        if (!sectionDrafts.isEmpty()) {
            sectionDrafts.forEach((section, text) -> {
                if (!StringUtils.hasText(text)) {
                    return;
                }
                builder.append("## ").append(section).append('\n').append(text.trim()).append("\n\n");
            });
        }
        if (!StringUtils.hasText(builder)) {
            builder.append("## SOURCES\n").append(firstNonBlank(sourceSnapshotJson, "(EMPTY)"));
        }
        return builder.toString().trim();
    }

    private Integer completeRatio(Map<String, String> sectionDrafts, String sectionStatusJson) {
        Map<String, String> statuses = readStringMap(sectionStatusJson);
        if (!statuses.isEmpty()) {
            long completed = statuses.values().stream().filter(value -> "COMPLETED".equalsIgnoreCase(value)).count();
            return (int) Math.min(100, Math.round((completed * 100.0) / Math.max(1, statuses.size())));
        }
        if (sectionDrafts.isEmpty()) {
            return 0;
        }
        long filled = sectionDrafts.values().stream().filter(StringUtils::hasText).count();
        return (int) Math.min(100, Math.round((filled * 100.0) / sectionDrafts.size()));
    }

    private List<Long> normalizeIds(List<Long> ids) {
        return ids == null ? List.of() : ids.stream().filter(id -> id != null && id > 0).distinct().toList();
    }

    private Map<String, String> readStringMap(String json) {
        if (!StringUtils.hasText(json)) {
            return Map.of();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<LinkedHashMap<String, String>>() {
            });
        } catch (Exception ignored) {
            return Map.of();
        }
    }

    private Map<String, Object> readObjectMap(String json) {
        if (!StringUtils.hasText(json)) {
            return Map.of();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<LinkedHashMap<String, Object>>() {
            });
        } catch (Exception ignored) {
            return Map.of();
        }
    }

    private List<Long> readLongList(String json, String key) {
        Map<String, Object> map = readObjectMap(json);
        Object value = map.get(key);
        if (value instanceof List<?> list) {
            return list.stream()
                    .map(item -> {
                        if (item instanceof Number number) {
                            return number.longValue();
                        }
                        try {
                            return Long.parseLong(String.valueOf(item));
                        } catch (Exception ignored) {
                            return null;
                        }
                    })
                    .filter(id -> id != null && id > 0)
                    .toList();
        }
        return List.of();
    }

    private String writeJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (Exception e) {
            throw new IllegalStateException("Failed to serialize JSON.", e);
        }
    }

    private ProjectWritingSessionResponse toResponse(ProjectWritingSession session) {
        return new ProjectWritingSessionResponse(
                session.getProject().getId(),
                session.getProject().getPortfolio().getId(),
                session.getProject().getName(),
                session.getRole(),
                session.getStatus().name(),
                session.getProgress(),
                readStringMap(session.getSectionDraftJson()),
                readStringMap(session.getSectionStatusJson()),
                readObjectMap(session.getSourceSnapshotJson()),
                readLongList(session.getSelectedSourcesJson(), "projectIds"),
                readLongList(session.getSelectedSourcesJson(), "documentIds"),
                session.getDocumentText(),
                session.getReviewedDocument(),
                session.getPresentationJson(),
                session.getLastError(),
                session.getLastSavedAt()
        );
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (StringUtils.hasText(value)) {
                return value;
            }
        }
        return "";
    }
}
