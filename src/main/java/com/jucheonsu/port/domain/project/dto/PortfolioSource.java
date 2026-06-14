package com.jucheonsu.port.domain.project.dto;

import java.util.List;

public record PortfolioSource(
        String provider,
        String title,
        String description,
        List<String> technologies,
        List<String> features,
        List<String> troubleshooting,
        List<String> links
) {
}
