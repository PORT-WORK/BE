package com.jucheonsu.port.domain.user.entity;

import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "educations")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Education extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, length = 100)
    private String schoolName;

    @Column(nullable = false, length = 100)
    private String major;

    private Integer startYear;

    private Integer endYear;

    private Boolean isAttending;

    public void update(String schoolName, String major, Integer startYear, Integer endYear, Boolean isAttending) {
        this.schoolName = schoolName;
        this.major = major;
        this.startYear = startYear;
        this.endYear = endYear;
        this.isAttending = isAttending;
    }
}
