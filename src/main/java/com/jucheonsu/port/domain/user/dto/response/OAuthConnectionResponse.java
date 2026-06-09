package com.jucheonsu.port.domain.user.dto.response;

import com.jucheonsu.port.domain.common.enums.ProviderType;

import java.time.LocalDateTime;

public record OAuthConnectionResponse(
        Long id,
        ProviderType provider,
        String workspaceUrl,
        LocalDateTime expiresAt
) {
}
