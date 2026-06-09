package com.jucheonsu.port.domain.block.dto.request;

import jakarta.validation.constraints.NotNull;

import java.util.Map;

public record BlockUpdateRequest(
        @NotNull Map<String, Object> content
) {
}
