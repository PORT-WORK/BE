package com.jucheonsu.port.domain.integration.dto.response;

import com.jucheonsu.port.domain.common.enums.ProviderType;

import java.util.List;
import java.util.Map;

public record IntegrationPreviewResponse(
        ProviderType provider,
        String title,
        String subtitle,
        String url,
        String description,
        String imageUrl,
        List<String> tags,
        Map<String, Object> raw
) {
}
