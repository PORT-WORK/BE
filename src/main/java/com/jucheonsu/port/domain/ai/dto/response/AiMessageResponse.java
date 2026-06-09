package com.jucheonsu.port.domain.ai.dto.response;

import com.jucheonsu.port.domain.common.enums.ChatRoleType;

import java.time.LocalDateTime;

public record AiMessageResponse(
        Long id,
        ChatRoleType role,
        String message,
        LocalDateTime createdAt
) {
}
