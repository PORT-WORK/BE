package com.jucheonsu.port.domain.analytics.repository;

import com.jucheonsu.port.domain.analytics.entity.AnalyticsReferrer;
import com.jucheonsu.port.domain.common.enums.SourceType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AnalyticsReferrerRepository extends JpaRepository<AnalyticsReferrer, Long> {

    List<AnalyticsReferrer> findAllByAnalyticsId(Long analyticsId);

    Optional<AnalyticsReferrer> findByAnalyticsIdAndSource(Long analyticsId, SourceType source);
}
