package com.jucheonsu.port.domain.project.dto.request;

import jakarta.validation.constraints.NotNull;

public record ProjectOrderRequest(
        @NotNull Long projectId,
        @NotNull Integer orderIndex
) {
}
