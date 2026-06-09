package com.jucheonsu.port.domain.user.dto.response;

import com.jucheonsu.port.domain.common.enums.PlatformType;

public record UserLinkResponse(
        Long id,
        PlatformType platform,
        String url
) {
}
