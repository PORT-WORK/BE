package com.jucheonsu.port.domain.document.service;

import com.jucheonsu.port.domain.document.converter.DocumentConverter;
import com.jucheonsu.port.domain.document.dto.response.DocumentResponse;
import com.jucheonsu.port.domain.document.repository.ProjectDocumentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DocumentServiceImpl implements DocumentService {

    private final ProjectDocumentRepository documentRepository;

    public List<DocumentResponse> getDocuments(Long projectId) {
        return documentRepository.findAllByProjectIdOrderByOrderIndexAsc(projectId).stream()
                .map(DocumentConverter::toResponse)
                .toList();
    }
}
