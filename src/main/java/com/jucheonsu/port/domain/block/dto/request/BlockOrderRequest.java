package com.jucheonsu.port.domain.block.dto.request;

import jakarta.validation.constraints.NotNull;

public record BlockOrderRequest(
        @NotNull Long blockId,
        @NotNull Integer orderIndex,
        Long parentId
) {
}
