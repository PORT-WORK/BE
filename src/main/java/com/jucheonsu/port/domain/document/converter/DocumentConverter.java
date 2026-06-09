package com.jucheonsu.port.domain.document.converter;

import com.jucheonsu.port.domain.document.dto.response.DocumentResponse;
import com.jucheonsu.port.domain.document.entity.ProjectDocument;

public final class DocumentConverter {

    private DocumentConverter() {
    }

    public static DocumentResponse toResponse(ProjectDocument document) {
        return new DocumentResponse(
                document.getId(),
                document.getProject().getId(),
                document.getCategory(),
                document.getIcon(),
                document.getTitle(),
                document.getReadTimeMinutes(),
                document.getOrderIndex()
        );
    }
}
