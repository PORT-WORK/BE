package com.jucheonsu.port.domain.notification.controller;

import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import com.jucheonsu.port.domain.notification.service.NotificationService;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    public ApiResponse<List<NotificationResponse>> getNotifications(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(notificationService.getNotifications(userId));
    }

    @GetMapping("/unread")
    public ApiResponse<List<NotificationResponse>> getUnreadNotifications(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(notificationService.getUnreadNotifications(userId));
    }

    @GetMapping("/unread-count")
    public ApiResponse<Long> getUnreadCount(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(notificationService.countUnread(userId));
    }

    @PutMapping("/{notificationId}/read")
    public ApiResponse<NotificationResponse> markAsRead(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable Long notificationId
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(notificationService.markAsRead(userId, notificationId));
    }

    @DeleteMapping("/{notificationId}")
    public ApiResponse<Void> delete(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable Long notificationId
    ) {
        Long userId = principal.getUserId();
        notificationService.delete(userId, notificationId);
        return ApiResponse.ok();
    }
}
