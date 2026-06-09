package com.jucheonsu.port.domain.document.dto.request;

import jakarta.validation.constraints.NotNull;

public record DocumentOrderRequest(
        @NotNull Long documentId,
        @NotNull Integer orderIndex
) {
}
