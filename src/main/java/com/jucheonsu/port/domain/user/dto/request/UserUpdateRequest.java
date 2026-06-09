package com.jucheonsu.port.domain.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserUpdateRequest(
        @NotBlank @Size(max = 50) String name,
        @Size(max = 200) String bio,
        @Size(max = 100) String location,
        Integer experienceYears,
        Boolean isEmailPublic
) {
}
