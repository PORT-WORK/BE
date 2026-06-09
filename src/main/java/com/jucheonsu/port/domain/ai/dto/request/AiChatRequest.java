package com.jucheonsu.port.domain.ai.dto.request;

import jakarta.validation.constraints.NotBlank;

public record AiChatRequest(
        @NotBlank String message
) {
}
