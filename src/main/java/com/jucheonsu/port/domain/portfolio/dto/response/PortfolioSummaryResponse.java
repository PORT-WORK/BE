package com.jucheonsu.port.domain.portfolio.dto.response;

public record PortfolioSummaryResponse(
        Long id,
        String title,
        String jobRole,
        String thumbnailUrl,
        String summary,
        String skills,
        Boolean isPublic,
        Integer viewCount,
        Integer likeCount,
        Integer bookmarkCount
) {
}
