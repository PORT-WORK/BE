package com.jucheonsu.port.domain.document.service;

import com.jucheonsu.port.domain.document.dto.response.DocumentResponse;

import java.util.List;

public interface DocumentService {
    List<DocumentResponse> getDocuments(Long projectId);
}
