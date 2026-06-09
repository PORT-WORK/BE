package com.jucheonsu.port.domain.portfolio.converter;

import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import com.jucheonsu.port.domain.portfolio.entity.Portfolio;

public final class PortfolioConverter {

    private PortfolioConverter() {
    }

    public static PortfolioSummaryResponse toSummaryResponse(Portfolio portfolio) {
        return new PortfolioSummaryResponse(
                portfolio.getId(),
                portfolio.getTitle(),
                portfolio.getJobRole(),
                portfolio.getThumbnailUrl(),
                portfolio.getSummary(),
                portfolio.getSkills(),
                portfolio.getIsPublic(),
                portfolio.getViewCount(),
                portfolio.getLikeCount(),
                portfolio.getBookmarkCount()
        );
    }

    public static PortfolioResponse toResponse(Portfolio portfolio) {
        return new PortfolioResponse(
                portfolio.getId(),
                portfolio.getUser().getId(),
                portfolio.getTitle(),
                portfolio.getJobRole(),
                portfolio.getThumbnailUrl(),
                portfolio.getSummary(),
                portfolio.getSkills(),
                portfolio.getTemplateId(),
                portfolio.getCustomDomain(),
                portfolio.getIsPublic(),
                portfolio.getViewCount(),
                portfolio.getLikeCount(),
                portfolio.getBookmarkCount()
        );
    }
}
