package com.jucheonsu.port.domain.user.entity;

import com.jucheonsu.port.domain.common.enums.TierType;
import com.jucheonsu.port.domain.common.enums.LanguageType;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class User extends BaseEntity {

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(length = 5000)
    private String profileImageUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    @Builder.Default
    private TierType tier = TierType.FREE;

    @Column(length = 100)
    private String location;

    private Integer experienceYears;

    @Column(length = 200)
    private String bio;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    @Builder.Default
    private LanguageType language = LanguageType.ko;

    @Column(nullable = false)
    @Builder.Default
    private Integer aiUsageCount = 0;

    @Column(nullable = false)
    @Builder.Default
    private Boolean isEmailPublic = false;

    @Column(nullable = false)
    @Builder.Default
    private Boolean notiEmail = true;

    @Column(nullable = false)
    @Builder.Default
    private Boolean notiPush = false;

    @Column(nullable = false)
    @Builder.Default
    private Boolean notiMessage = true;

    private LocalDateTime deletedAt;

    public void updateProfile(String name, String profileImageUrl, String bio, String location, Integer experienceYears, Boolean isEmailPublic) {
        this.name = name;
        this.profileImageUrl = profileImageUrl;
        this.bio = bio;
        this.location = location;
        this.experienceYears = experienceYears;
        this.isEmailPublic = isEmailPublic;
    }

    public void updateSettings(LanguageType language, Boolean notiEmail, Boolean notiPush, Boolean notiMessage) {
        this.language = language;
        this.notiEmail = notiEmail;
        this.notiPush = notiPush;
        this.notiMessage = notiMessage;
    }

    public void increaseAiUsageCount() {
        this.aiUsageCount++;
    }

    public void delete() {
        this.deletedAt = LocalDateTime.now();
    }
}
