package com.jucheonsu.port.domain.block.service;

import com.jucheonsu.port.domain.block.converter.BlockConverter;
import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockOrderRequest;
import com.jucheonsu.port.domain.block.dto.request.BlockUpdateRequest;
import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.block.entity.Block;
import com.jucheonsu.port.domain.block.repository.BlockRepository;
import com.jucheonsu.port.domain.common.enums.BlockType;
import com.jucheonsu.port.domain.document.entity.ProjectDocument;
import com.jucheonsu.port.domain.document.repository.ProjectDocumentRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BlockServiceImpl implements BlockService {

    private final BlockRepository blockRepository;
    private final ProjectDocumentRepository documentRepository;

    @Transactional
    public BlockResponse create(Long documentId, BlockCreateRequest request) {
        ProjectDocument document = documentRepository.findById(documentId)
                .orElseThrow(() -> new CustomException(ErrorCode.DOCUMENT_NOT_FOUND));

        Block parent = null;
        if (request.parentId() != null) {
            parent = blockRepository.findByIdAndDocumentId(request.parentId(), documentId)
                    .orElseThrow(() -> new CustomException(ErrorCode.BLOCK_NOT_FOUND));
        }

        Block block = Block.builder()
                .document(document)
                .parent(parent)
                .blockType(request.blockType())
                .content(request.content())
                .orderIndex(request.orderIndex())
                .build();

        return BlockConverter.toResponse(blockRepository.save(block));
    }

    @Transactional
    public BlockResponse update(Long documentId, Long blockId, BlockUpdateRequest request) {
        Block block = blockRepository.findByIdAndDocumentId(blockId, documentId)
                .orElseThrow(() -> new CustomException(ErrorCode.BLOCK_NOT_FOUND));
        block.updateContent(request.content());
        return BlockConverter.toResponse(block);
    }

    public List<BlockResponse> getBlocks(Long documentId) {
        return blockRepository.findTreeByDocumentId(documentId).stream()
                .map(BlockConverter::toResponse)
                .toList();
    }

    @Transactional
    public void updateOrder(Long documentId, List<BlockOrderRequest> requests) {
        for (BlockOrderRequest request : requests) {
            Block block = blockRepository.findByIdAndDocumentId(request.blockId(), documentId)
                    .orElseThrow(() -> new CustomException(ErrorCode.BLOCK_NOT_FOUND));
            Block parent = request.parentId() == null ? null : blockRepository.findByIdAndDocumentId(request.parentId(), documentId)
                    .orElseThrow(() -> new CustomException(ErrorCode.BLOCK_NOT_FOUND));
            block.updateOrder(request.orderIndex(), parent);
        }
    }
}
