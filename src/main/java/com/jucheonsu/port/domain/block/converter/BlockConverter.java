package com.jucheonsu.port.domain.block.converter;

import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.block.entity.Block;

public final class BlockConverter {

    private BlockConverter() {
    }

    public static BlockResponse toResponse(Block block) {
        return new BlockResponse(
                block.getId(),
                block.getDocument().getId(),
                block.getParent() == null ? null : block.getParent().getId(),
                block.getBlockType(),
                block.getContent(),
                block.getOrderIndex()
        );
    }
}
