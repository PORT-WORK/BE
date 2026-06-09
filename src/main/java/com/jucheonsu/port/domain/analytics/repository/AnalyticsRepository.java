package com.jucheonsu.port.domain.analytics.repository;

import com.jucheonsu.port.domain.analytics.entity.Analytics;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface AnalyticsRepository extends JpaRepository<Analytics, Long> {
    List<Analytics> findAllByPortfolioIdOrderByStatDateDesc(Long portfolioId);
    Optional<Analytics> findByPortfolioIdAndStatDate(Long portfolioId, LocalDate statDate);
    @Query("select coalesce(sum(a.viewCount), 0) from Analytics a where a.portfolio.id = :portfolioId and a.statDate between :startDate and :endDate")
    long sumViewCount(Long portfolioId, LocalDate startDate, LocalDate endDate);
}
