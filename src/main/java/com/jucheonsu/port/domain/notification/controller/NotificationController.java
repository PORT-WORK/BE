package com.jucheonsu.port.domain.notification.controller;

import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import com.jucheonsu.port.domain.notification.service.NotificationService;
import com.jucheonsu.port.global.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    public ApiResponse<List<NotificationResponse>> getNotifications(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(notificationService.getNotifications(userId));
    }

    @GetMapping("/unread")
    public ApiResponse<List<NotificationResponse>> getUnreadNotifications(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(notificationService.getUnreadNotifications(userId));
    }

    @GetMapping("/unread-count")
    public ApiResponse<Long> getUnreadCount(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(notificationService.countUnread(userId));
    }

    @PutMapping("/{notificationId}/read")
    public ApiResponse<NotificationResponse> markAsRead(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable Long notificationId
    ) {
        return ApiResponse.ok(notificationService.markAsRead(userId, notificationId));
    }

    @DeleteMapping("/{notificationId}")
    public ApiResponse<Void> delete(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable Long notificationId
    ) {
        notificationService.delete(userId, notificationId);
        return ApiResponse.ok();
    }
}
