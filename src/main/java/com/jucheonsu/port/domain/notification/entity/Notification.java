package com.jucheonsu.port.domain.notification.entity;

import com.jucheonsu.port.domain.notification.enums.NotificationType;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "notifications")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Notification extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private NotificationType type;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    @Column(length = 500)
    private String linkUrl;

    @Column(nullable = false)
    @Builder.Default
    private Boolean isRead = false;

    private LocalDateTime readAt;

    public void read() {
        this.isRead = true;
        this.readAt = LocalDateTime.now();
    }
}
