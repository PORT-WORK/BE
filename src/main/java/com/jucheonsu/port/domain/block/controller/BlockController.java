package com.jucheonsu.port.domain.block.controller;

import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockOrderRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockUpdateRequest;
import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.block.service.BlockService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/documents/{documentId}/blocks")
@RequiredArgsConstructor
public class BlockController {

    private final BlockService blockService;

    @GetMapping
    public ApiResponse<List<BlockResponse>> getBlocks(@PathVariable Long documentId) {
        return ApiResponse.ok(blockService.getBlocks(documentId));
    }

    @PostMapping
    public ApiResponse<BlockResponse> create(
            @PathVariable Long documentId,
            @Valid @RequestBody BlockCreateRequest request
    ) {
        return ApiResponse.ok(blockService.create(documentId, request));
    }

    @PutMapping("/{blockId}")
    public ApiResponse<BlockResponse> update(
            @PathVariable Long documentId,
            @PathVariable Long blockId,
            @Valid @RequestBody BlockUpdateRequest request
    ) {
        return ApiResponse.ok(blockService.update(documentId, blockId, request));
    }

    @PutMapping("/order")
    public ApiResponse<Void> updateOrder(
            @PathVariable Long documentId,
            @RequestBody List<BlockOrderRequest> requests
    ) {
        blockService.updateOrder(documentId, requests);
        return ApiResponse.ok();
    }
}
