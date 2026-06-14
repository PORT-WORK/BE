package com.jucheonsu.port.domain.portfolio.dto.response;

import java.util.List;

public record PortfolioSummaryResponse(
        Long id,
        Long userId,
        String title,
        String jobRole,
        String thumbnailUrl,
        String summary,
        List<String> skills,
        String pptxUrl,
        Boolean isPublic,
        Integer viewCount,
        Integer likeCount,
        Integer bookmarkCount
) {
}
