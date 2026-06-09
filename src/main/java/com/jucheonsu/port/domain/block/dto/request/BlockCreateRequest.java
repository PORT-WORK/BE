package com.jucheonsu.port.domain.block.dto.request;

import com.jucheonsu.port.domain.common.enums.BlockType;
import jakarta.validation.constraints.NotNull;

import java.util.Map;

public record BlockCreateRequest(
        @NotNull BlockType blockType,
        @NotNull Map<String, Object> content,
        Integer orderIndex,
        Long parentId
) {
}
