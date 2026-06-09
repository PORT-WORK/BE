package com.jucheonsu.port.domain.notification.service;

import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import com.jucheonsu.port.domain.notification.enums.NotificationType;

import java.util.List;

public interface NotificationService {
    List<NotificationResponse> getNotifications(Long userId);
    List<NotificationResponse> getUnreadNotifications(Long userId);
    NotificationResponse markAsRead(Long userId, Long notificationId);
    long countUnread(Long userId);
    NotificationResponse create(Long userId, NotificationType type, String title, String content, String linkUrl);
    void delete(Long userId, Long notificationId);
}
