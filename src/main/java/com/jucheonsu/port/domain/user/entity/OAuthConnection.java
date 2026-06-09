package com.jucheonsu.port.domain.user.entity;

import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(
        name = "oauth_connections",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "provider"})
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class OAuthConnection extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private ProviderType provider;

    @Column(nullable = false, length = 1000)
    private String accessToken;

    @Column(length = 1000)
    private String refreshToken;

    @Column(length = 255)
    private String workspaceUrl;

    private LocalDateTime expiresAt;

    public void update(String accessToken, String refreshToken, String workspaceUrl, LocalDateTime expiresAt) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.workspaceUrl = workspaceUrl;
        this.expiresAt = expiresAt;
    }
}
