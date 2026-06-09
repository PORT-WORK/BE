package com.jucheonsu.port.domain.auth.dto.response;

import com.jucheonsu.port.domain.user.dto.response.UserResponse;

public record LoginResponse(
        String accessToken,
        UserResponse user
) {
}
