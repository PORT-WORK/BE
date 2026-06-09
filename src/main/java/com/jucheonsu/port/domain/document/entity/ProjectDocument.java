package com.jucheonsu.port.domain.document.entity;

import com.jucheonsu.port.domain.common.enums.CategoryType;
import com.jucheonsu.port.domain.project.entity.Project;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "project_documents")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class ProjectDocument extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id", nullable = false)
    private Project project;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private CategoryType category;

    @Column(length = 10)
    private String icon;

    @Column(nullable = false, length = 200)
    private String title;

    private Integer readTimeMinutes;

    private Integer orderIndex;

    public void update(CategoryType category, String title, String icon) {
        this.category = category;
        this.title = title;
        this.icon = icon;
    }

    public void updateOrder(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }
}
