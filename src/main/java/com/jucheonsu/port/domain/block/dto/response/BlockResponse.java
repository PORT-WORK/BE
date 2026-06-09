package com.jucheonsu.port.domain.block.dto.response;

import com.jucheonsu.port.domain.common.enums.BlockType;

import java.util.Map;

public record BlockResponse(
        Long id,
        Long documentId,
        Long parentId,
        BlockType blockType,
        Map<String, Object> content,
        Integer orderIndex
) {
}
