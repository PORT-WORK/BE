package com.jucheonsu.port.domain.reaction.repository;

import com.jucheonsu.port.domain.reaction.entity.Bookmark;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    boolean existsByUserIdAndPortfolioId(Long userId, Long portfolioId);

    Optional<Bookmark> findByUserIdAndPortfolioId(Long userId, Long portfolioId);
}
