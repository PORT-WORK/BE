package com.jucheonsu.port.domain.auth.service;

import com.jucheonsu.port.domain.auth.dto.request.LocalLoginRequest;
import com.jucheonsu.port.domain.auth.dto.request.TokenRefreshRequest;
import com.jucheonsu.port.domain.auth.dto.response.LoginResponse;
import com.jucheonsu.port.domain.auth.dto.response.TokenResponse;
import jakarta.servlet.http.HttpServletResponse;

public interface AuthService {
    LoginResponse login(LocalLoginRequest request, HttpServletResponse response);
    TokenResponse refresh(TokenRefreshRequest request, HttpServletResponse response);
    void logout(String refreshToken, HttpServletResponse response);
}
