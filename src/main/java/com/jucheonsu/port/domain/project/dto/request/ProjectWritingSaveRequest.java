package com.jucheonsu.port.domain.project.dto.request;

import java.util.Map;

public record ProjectWritingSaveRequest(
        Integer progress,
        Map<String, String> sectionDrafts,
        Map<String, String> sectionStatuses
) {
}
