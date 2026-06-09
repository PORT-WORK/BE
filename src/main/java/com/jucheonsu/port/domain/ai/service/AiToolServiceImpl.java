package com.jucheonsu.port.domain.ai.service;

import com.jucheonsu.port.domain.ai.dto.response.PortfolioDataResponse;
import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.service.BlockService;
import com.jucheonsu.port.domain.common.enums.BlockType;
import com.jucheonsu.port.domain.document.service.DocumentService;
import com.jucheonsu.port.domain.portfolio.service.PortfolioService;
import com.jucheonsu.port.domain.project.service.ProjectService;
import com.jucheonsu.port.infra.ppt.PptExportService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AiToolServiceImpl implements AiToolService {

    private final PortfolioService portfolioService;
    private final ProjectService projectService;
    private final DocumentService documentService;
    private final BlockService blockService;
    private final PptExportService pptExportService;
    private final AiUsageLimitService aiUsageLimitService;

    public PortfolioDataResponse getPortfolioData(Long portfolioId) {
        var portfolio = portfolioService.getDetail(portfolioId);
        var projects = projectService.getProjects(portfolioId).stream()
                .map(project -> new PortfolioDataResponse.ProjectData(
                        project,
                        documentService.getDocuments(project.id()).stream()
                                .map(document -> new PortfolioDataResponse.DocumentData(
                                        document,
                                        blockService.getBlocks(document.id())
                                ))
                                .toList()
                ))
                .toList();
        return new PortfolioDataResponse(portfolio, projects);
    }

    public Object createBlock(Long projectDocumentId, String blockType, Map<String, Object> content) {
        return blockService.create(projectDocumentId, new BlockCreateRequest(BlockType.valueOf(blockType), content, null, null));
    }

    public void updateBlockOrder(Long documentId, List<Map<String, Object>> blockOrders) {
        // Tool Calling 입력 스키마가 확정되면 BlockOrderRequest로 변환한다.
    }

    public byte[] buildPptxSlide(Long portfolioId, String layoutJson) {
        return pptExportService.exportPortfolio(portfolioId, layoutJson);
    }

    public String exportToPdf(Long portfolioId) {
        return "/api/portfolios/" + portfolioId + "/export/pdf";
    }

    public List<String> getUserSkills(Long userId) {
        return List.of();
    }

    public boolean checkAiUsageLimit(Long userId) {
        return aiUsageLimitService.canUse(userId);
    }

    public String generatePptLayoutJson(Long portfolioId, String sourceText) {
        String escapedSourceText = sourceText
                .replace("\\", "\\\\")
                .replace("\"", "\\\"");
        return """
                {
                  "portfolioId": %d,
                  "theme": "MODERN",
                  "slides": [
                    {"type": "COVER", "title": "Portfolio", "content": "%s"},
                    {"type": "PROJECT", "title": "Project Highlights", "content": "핵심 프로젝트 경험을 요약합니다."},
                    {"type": "THANKS", "title": "Thank You", "content": "감사합니다."}
                  ]
                }
                """.formatted(portfolioId, escapedSourceText);
    }
}
