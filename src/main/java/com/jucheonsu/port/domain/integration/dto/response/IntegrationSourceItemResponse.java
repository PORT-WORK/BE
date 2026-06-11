package com.jucheonsu.port.domain.integration.dto.response;

import com.jucheonsu.port.domain.common.enums.ProviderType;

import java.util.List;
import java.util.Map;

public record IntegrationSourceItemResponse(
        ProviderType provider,
        String resourceId,
        String kind,
        String title,
        String subtitle,
        String summary,
        String url,
        String imageUrl,
        List<String> tags,
        Map<String, Object> raw
) {
}
