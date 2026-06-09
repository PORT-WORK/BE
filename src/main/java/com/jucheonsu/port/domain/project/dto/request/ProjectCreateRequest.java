package com.jucheonsu.port.domain.project.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;

public record ProjectCreateRequest(
        @NotBlank @Size(max = 200) String name,
        @Size(max = 100) String role,
        String summary,
        LocalDate startDate,
        LocalDate endDate,
        String skills
) {
}
