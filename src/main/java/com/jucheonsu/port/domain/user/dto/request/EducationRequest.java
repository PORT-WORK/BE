package com.jucheonsu.port.domain.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record EducationRequest(
        @NotBlank @Size(max = 100) String schoolName,
        @NotBlank @Size(max = 100) String major,
        Integer startYear,
        Integer endYear,
        Boolean isAttending
) {
}
