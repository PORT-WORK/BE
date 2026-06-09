package com.jucheonsu.port.domain.user.entity;

import com.jucheonsu.port.domain.common.enums.PlatformType;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "user_links")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class UserLink extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private PlatformType platform;

    @Column(nullable = false, length = 500)
    private String url;

    public void updateUrl(String url) {
        this.url = url;
    }
}
