package com.jucheonsu.port.domain.auth.service;

import com.jucheonsu.port.domain.auth.dto.request.TokenRefreshRequest;
import com.jucheonsu.port.domain.auth.dto.response.TokenResponse;
import jakarta.servlet.http.HttpServletResponse;

public interface AuthService {
    TokenResponse refresh(TokenRefreshRequest request, HttpServletResponse response);
    void logout(String refreshToken, HttpServletResponse response);
}
