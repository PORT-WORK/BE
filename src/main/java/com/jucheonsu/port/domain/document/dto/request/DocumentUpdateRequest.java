package com.jucheonsu.port.domain.document.dto.request;

import com.jucheonsu.port.domain.common.enums.CategoryType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record DocumentUpdateRequest(
        @NotNull CategoryType category,
        @NotBlank @Size(max = 200) String title,
        @Size(max = 10) String icon
) {
}
