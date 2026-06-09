package com.jucheonsu.port.domain.integration.dto.request;

import jakarta.validation.constraints.NotBlank;

public record IntegrationConnectRequest(
        @NotBlank String code,
        String workspaceUrl
) {
}
