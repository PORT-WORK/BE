package com.jucheonsu.port.domain.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;

public record WorkExperienceRequest(
        @NotBlank @Size(max = 100) String companyName,
        @NotBlank @Size(max = 100) String role,
        String description,
        @NotNull LocalDate startDate,
        LocalDate endDate,
        Boolean isCurrent
) {
}
