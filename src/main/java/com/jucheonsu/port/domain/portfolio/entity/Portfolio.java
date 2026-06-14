package com.jucheonsu.port.domain.portfolio.entity;

import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "portfolios")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Portfolio extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(length = 100)
    private String jobRole;

    @Column(length = 500)
    private String thumbnailUrl;

    @Column(length = 200)
    private String summary;

    @Column(length = 50)
    private String skills;

    @Column(nullable = false, length = 50)
    private String templateId;

    @Column(length = 2000)
    private String pptxUrl;

    @Column(length = 255)
    private String customDomain;

    @Column(nullable = false)
    @Builder.Default
    private Boolean isPublic = false;

    @Column(nullable = false)
    @Builder.Default
    private Integer viewCount = 0;

    @Column(nullable = false)
    @Builder.Default
    private Integer likeCount = 0;

    @Column(nullable = false)
    @Builder.Default
    private Integer bookmarkCount = 0;

    private LocalDateTime deletedAt;

    public void update(String title, String summary, Boolean isPublic, String customDomain) {
        this.title = title;
        this.summary = summary;
        this.isPublic = isPublic;
        this.customDomain = customDomain;
    }

    public void updatePptxUrl(String pptxUrl) {
        this.pptxUrl = pptxUrl;
    }

    public void increaseLikeCount() {
        this.likeCount++;
    }

    public void decreaseLikeCount() {
        this.likeCount = Math.max(0, this.likeCount - 1);
    }

    public void increaseBookmarkCount() {
        this.bookmarkCount++;
    }

    public void decreaseBookmarkCount() {
        this.bookmarkCount = Math.max(0, this.bookmarkCount - 1);
    }

    public void increaseViewCount() {
        this.viewCount++;
    }

    public void delete() {
        this.deletedAt = LocalDateTime.now();
    }
}
