package com.jucheonsu.port.domain.portfolio.dto.response;

public record PortfolioResponse(
        Long id,
        Long userId,
        String title,
        String jobRole,
        String thumbnailUrl,
        String summary,
        String skills,
        String templateId,
        String customDomain,
        Boolean isPublic,
        Integer viewCount,
        Integer likeCount,
        Integer bookmarkCount
) {
}
