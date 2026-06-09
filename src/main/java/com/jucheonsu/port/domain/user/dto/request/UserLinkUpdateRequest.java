package com.jucheonsu.port.domain.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserLinkUpdateRequest(
        @NotBlank @Size(max = 500) String url
) {
}
