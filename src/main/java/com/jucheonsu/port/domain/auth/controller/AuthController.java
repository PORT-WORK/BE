package com.jucheonsu.port.domain.auth.controller;

import com.jucheonsu.port.domain.auth.dto.request.TokenRefreshRequest;
import com.jucheonsu.port.domain.auth.dto.response.TokenResponse;
import com.jucheonsu.port.domain.auth.service.AuthService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService service;

    @PostMapping("/refresh")
    public ApiResponse<TokenResponse> refresh(@Valid @RequestBody TokenRefreshRequest request, HttpServletResponse response) {
        return ApiResponse.ok(service.refresh(request, response));
    }

    @DeleteMapping("/logout")
    public ApiResponse<Void> logout(@RequestBody TokenRefreshRequest request, HttpServletResponse response) {
        service.logout(request.refreshToken(), response);
        return ApiResponse.ok();
    }
}
