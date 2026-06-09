package com.jucheonsu.port.domain.block.service;

import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockOrderRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockUpdateRequest;
import com.jucheonsu.port.domain.block.dto.response.BlockResponse;

import java.util.List;

public interface BlockService {
    BlockResponse create(Long documentId, BlockCreateRequest request);
    BlockResponse update(Long documentId, Long blockId, BlockUpdateRequest request);
    List<BlockResponse> getBlocks(Long documentId);
    void updateOrder(Long documentId, List<BlockOrderRequest> requests);
}
