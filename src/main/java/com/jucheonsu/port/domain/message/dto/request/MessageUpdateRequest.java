package com.jucheonsu.port.domain.message.dto.request;

import jakarta.validation.constraints.NotBlank;

public record MessageUpdateRequest(
        @NotBlank String content
) {
}
