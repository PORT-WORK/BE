package com.jucheonsu.port.domain.notification.service;

import com.jucheonsu.port.domain.notification.converter.NotificationConverter;
import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import com.jucheonsu.port.domain.notification.entity.Notification;
import com.jucheonsu.port.domain.notification.enums.NotificationType;
import com.jucheonsu.port.domain.notification.repository.NotificationRepository;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class NotificationServiceImpl implements NotificationService {

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    public List<NotificationResponse> getNotifications(Long userId) {
        return notificationRepository.findAllByUserIdOrderByCreatedAtDesc(userId).stream()
                .map(NotificationConverter::toResponse)
                .toList();
    }

    public List<NotificationResponse> getUnreadNotifications(Long userId) {
        return notificationRepository.findAllByUserIdAndIsReadFalseOrderByCreatedAtDesc(userId).stream()
                .map(NotificationConverter::toResponse)
                .toList();
    }

    public long countUnread(Long userId) {
        return notificationRepository.countByUserIdAndIsReadFalse(userId);
    }

    @Transactional
    public NotificationResponse markAsRead(Long userId, Long notificationId) {
        Notification notification = notificationRepository.findByIdAndUserId(notificationId, userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOTIFICATION_NOT_FOUND));
        notification.read();
        return NotificationConverter.toResponse(notification);
    }

    @Transactional
    public NotificationResponse create(Long userId, NotificationType type, String title, String content, String linkUrl) {
        User user = userRepository.findByIdAndDeletedAtIsNull(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Notification notification = notificationRepository.save(Notification.builder()
                .user(user)
                .type(type)
                .title(title)
                .content(content)
                .linkUrl(linkUrl)
                .build());

        return NotificationConverter.toResponse(notification);
    }

    @Transactional
    public void delete(Long userId, Long notificationId) {
        Notification notification = notificationRepository.findByIdAndUserId(notificationId, userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOTIFICATION_NOT_FOUND));
        notificationRepository.delete(notification);
    }
}
