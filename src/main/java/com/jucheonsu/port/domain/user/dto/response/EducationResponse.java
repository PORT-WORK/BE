package com.jucheonsu.port.domain.user.dto.response;

public record EducationResponse(
        Long id,
        String schoolName,
        String major,
        Integer startYear,
        Integer endYear,
        Boolean isAttending
) {
}
