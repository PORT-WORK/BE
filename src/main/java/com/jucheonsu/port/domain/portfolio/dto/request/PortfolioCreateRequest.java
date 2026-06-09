package com.jucheonsu.port.domain.portfolio.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record PortfolioCreateRequest(
        @NotBlank @Size(max = 200) String title,
        @Size(max = 100) String jobRole,
        @NotBlank @Size(max = 50) String templateId,
        Boolean isPublic
) {
}
