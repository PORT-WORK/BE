package com.jucheonsu.port.domain.analytics.entity;

import com.jucheonsu.port.domain.common.enums.SourceType;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "analytics_referrers")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class AnalyticsReferrer extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "stat_id", nullable = false)
    private Analytics analytics;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private SourceType source;

    @Column(nullable = false)
    @Builder.Default
    private Integer visitCount = 0;

    public void increaseVisitCount() {
        this.visitCount++;
    }
}
