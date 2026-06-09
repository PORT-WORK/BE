package com.jucheonsu.port.domain.notification.dto.response;

import com.jucheonsu.port.domain.notification.enums.NotificationType;

import java.time.LocalDateTime;

public record NotificationResponse(
        Long id,
        NotificationType type,
        String title,
        String content,
        String linkUrl,
        Boolean isRead,
        LocalDateTime createdAt,
        LocalDateTime readAt
) {
}
