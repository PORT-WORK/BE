package com.jucheonsu.port.domain.message.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record MessageCreateRequest(
        @NotNull Long receiverId,
        @NotBlank String content
) {
}
