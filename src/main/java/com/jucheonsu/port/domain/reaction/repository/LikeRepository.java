package com.jucheonsu.port.domain.reaction.repository;

import com.jucheonsu.port.domain.reaction.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LikeRepository extends JpaRepository<Like, Long> {

    boolean existsByUserIdAndPortfolioId(Long userId, Long portfolioId);

    Optional<Like> findByUserIdAndPortfolioId(Long userId, Long portfolioId);
}
