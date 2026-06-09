package com.jucheonsu.port.domain.project.dto.response;

import java.time.LocalDate;

public record ProjectResponse(
        Long id,
        Long portfolioId,
        String name,
        String role,
        String summary,
        String thumbnailUrl,
        String skills,
        Boolean isSynced,
        LocalDate startDate,
        LocalDate endDate,
        Integer orderIndex
) {
}
