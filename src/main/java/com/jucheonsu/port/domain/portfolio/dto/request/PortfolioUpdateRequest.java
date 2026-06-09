package com.jucheonsu.port.domain.portfolio.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record PortfolioUpdateRequest(
        @NotBlank @Size(max = 200) String title,
        @Size(max = 200) String summary,
        Boolean isPublic,
        @Size(max = 255) String customDomain
) {
}
