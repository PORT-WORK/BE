package com.jucheonsu.port.domain.project.entity;

import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Getter
@Entity
@Table(name = "projects")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Project extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "portfolio_id", nullable = false)
    private Portfolio portfolio;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(length = 100)
    private String role;

    @Column(columnDefinition = "TEXT")
    private String summary;

    @Column(length = 500)
    private String thumbnailUrl;

    @Column(length = 50)
    private String skills;

    @Column(nullable = false)
    @Builder.Default
    private Boolean isSynced = false;

    private LocalDate startDate;

    private LocalDate endDate;

    private Integer orderIndex;

    public void update(String name, String role, String summary, LocalDate startDate, LocalDate endDate, String skills) {
        this.name = name;
        this.role = role;
        this.summary = summary;
        this.startDate = startDate;
        this.endDate = endDate;
        this.skills = skills;
    }

    public void updateOrder(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }
}
