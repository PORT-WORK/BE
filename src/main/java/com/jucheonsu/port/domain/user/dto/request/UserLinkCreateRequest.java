package com.jucheonsu.port.domain.user.dto.request;

import com.jucheonsu.port.domain.common.enums.PlatformType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record UserLinkCreateRequest(
        @NotNull PlatformType platform,
        @NotBlank @Size(max = 500) String url
) {
}
