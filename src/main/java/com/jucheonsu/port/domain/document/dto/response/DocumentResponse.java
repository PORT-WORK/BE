package com.jucheonsu.port.domain.document.dto.response;

import com.jucheonsu.port.domain.common.enums.CategoryType;

public record DocumentResponse(
        Long id,
        Long projectId,
        CategoryType category,
        String icon,
        String title,
        Integer readTimeMinutes,
        Integer orderIndex
) {
}
