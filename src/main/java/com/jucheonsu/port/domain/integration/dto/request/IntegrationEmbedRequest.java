package com.jucheonsu.port.domain.integration.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record IntegrationEmbedRequest(
        @NotNull Long documentId,
        @NotBlank String resourceId
) {
}
