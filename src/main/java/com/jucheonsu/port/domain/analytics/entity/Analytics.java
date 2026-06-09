package com.jucheonsu.port.domain.analytics.entity;

import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Getter
@Entity
@Table(
        name = "analytics",
        uniqueConstraints = @UniqueConstraint(columnNames = {"portfolio_id", "stat_date"})
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Analytics extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "portfolio_id", nullable = false)
    private Portfolio portfolio;

    @Column(nullable = false)
    private LocalDate statDate;

    @Column(nullable = false)
    @Builder.Default
    private Integer viewCount = 0;

    @Column(nullable = false)
    @Builder.Default
    private Integer visitorCount = 0;

    @Column(nullable = false)
    @Builder.Default
    private Integer recruiterCount = 0;

    public void increaseViewCount() {
        this.viewCount++;
    }
}
