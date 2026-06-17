package com.jucheonsu.port.domain.portfolio.dto.response;

import java.util.List;

public record PortfolioResponse(
        Long id,
        Long userId,
        String title,
        String jobRole,
        String thumbnailUrl,
        String summary,
        List<String> skills,
        String templateId,
        String pdfUrl,
        String pptxUrl,
        String customDomain,
        Boolean isPublic,
        Integer viewCount,
        Integer likeCount,
        Integer bookmarkCount
) {
}
