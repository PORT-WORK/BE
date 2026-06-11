package com.jucheonsu.port.domain.project.dto.response;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public record ProjectWritingSessionResponse(
        Long projectId,
        Long portfolioId,
        String projectName,
        String role,
        String status,
        Integer progress,
        Map<String, String> sectionDrafts,
        Map<String, String> sectionStatuses,
        Map<String, Object> sourceSnapshot,
        List<Long> selectedProjectIds,
        List<Long> selectedDocumentIds,
        String documentText,
        String reviewedDocument,
        String presentationJson,
        String lastError,
        LocalDateTime lastSavedAt
) {
}
