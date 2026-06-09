package com.jucheonsu.port.domain.notification.converter;

import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import com.jucheonsu.port.domain.notification.entity.Notification;

public final class NotificationConverter {

    private NotificationConverter() {
    }

    public static NotificationResponse toResponse(Notification notification) {
        return new NotificationResponse(
                notification.getId(),
                notification.getType(),
                notification.getTitle(),
                notification.getContent(),
                notification.getLinkUrl(),
                notification.getIsRead(),
                notification.getCreatedAt(),
                notification.getReadAt()
        );
    }
}
