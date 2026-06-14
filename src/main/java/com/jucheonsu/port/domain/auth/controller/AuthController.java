package com.jucheonsu.port.domain.auth.controller;

import com.jucheonsu.port.domain.auth.dto.request.LocalLoginRequest;
import com.jucheonsu.port.domain.auth.dto.request.TokenRefreshRequest;
import com.jucheonsu.port.domain.auth.dto.response.LoginResponse;
import com.jucheonsu.port.domain.auth.dto.response.TokenResponse;
import com.jucheonsu.port.domain.auth.service.AuthService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService service;

    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(
            @Valid @RequestBody LocalLoginRequest request,
            HttpServletResponse response
    ) {
        return ApiResponse.ok(service.login(request, response));
    }

    @PostMapping("/refresh")
    public ApiResponse<TokenResponse> refresh(
            @RequestBody(required = false) TokenRefreshRequest request,
            @CookieValue(value = "REFRESH_TOKEN", required = false) String refreshTokenCookie,
            HttpServletResponse response
    ) {
        String refreshToken = request != null ? request.refreshToken() : refreshTokenCookie;
        return ApiResponse.ok(service.refresh(new TokenRefreshRequest(refreshToken), response));
    }

    @DeleteMapping("/logout")
    public ApiResponse<Void> logout(
            @RequestBody(required = false) TokenRefreshRequest request,
            @CookieValue(value = "REFRESH_TOKEN", required = false) String refreshTokenCookie,
            HttpServletResponse response
    ) {
        service.logout(request != null ? request.refreshToken() : refreshTokenCookie, response);
        return ApiResponse.ok();
    }
}
