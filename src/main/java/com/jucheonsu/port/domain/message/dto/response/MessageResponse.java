package com.jucheonsu.port.domain.message.dto.response;

import java.time.LocalDateTime;

public record MessageResponse(
        Long id,
        Long senderId,
        Long receiverId,
        String content,
        Boolean isRead,
        LocalDateTime createdAt,
        LocalDateTime readAt
) {
}
