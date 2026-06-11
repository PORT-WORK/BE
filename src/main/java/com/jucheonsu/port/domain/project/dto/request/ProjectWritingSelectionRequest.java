package com.jucheonsu.port.domain.project.dto.request;

import jakarta.validation.constraints.NotNull;

import java.util.List;

public record ProjectWritingSelectionRequest(
        @NotNull Long portfolioId,
        List<Long> projectIds,
        List<Long> documentIds
) {
}
