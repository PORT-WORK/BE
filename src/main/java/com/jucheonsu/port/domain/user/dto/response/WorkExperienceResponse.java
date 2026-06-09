package com.jucheonsu.port.domain.user.dto.response;

import java.time.LocalDate;

public record WorkExperienceResponse(
        Long id,
        String companyName,
        String role,
        String description,
        LocalDate startDate,
        LocalDate endDate,
        Boolean isCurrent
) {
}
