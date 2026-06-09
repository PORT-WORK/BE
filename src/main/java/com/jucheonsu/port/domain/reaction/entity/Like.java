package com.jucheonsu.port.domain.reaction.entity;

import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(
        name = "likes",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "portfolio_id"})
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Like extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "portfolio_id", nullable = false)
    private Portfolio portfolio;
}
