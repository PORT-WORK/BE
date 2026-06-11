package com.jucheonsu.port.domain.user.controller;

import com.jucheonsu.port.domain.user.dto.request.SettingsUpdateRequest;
import com.jucheonsu.port.domain.user.dto.request.UserUpdateRequest;
import com.jucheonsu.port.domain.user.dto.response.PublicUserResponse;
import com.jucheonsu.port.domain.user.dto.response.SettingsResponse;
import com.jucheonsu.port.domain.user.dto.response.UserResponse;
import com.jucheonsu.port.domain.user.service.UserService;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/me")
    public ApiResponse<UserResponse> getMe(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(userService.getMe(userId));
    }

    @PutMapping("/me")
    public ApiResponse<UserResponse> updateMe(
            @AuthenticationPrincipal PrincipalDetails principal,
            @Valid @RequestBody UserUpdateRequest request
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(userService.updateMe(userId, request));
    }

    @DeleteMapping("/me")
    public ApiResponse<Void> deleteMe(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        userService.deleteMe(userId);
        return ApiResponse.ok();
    }

    @GetMapping("/{userId}")
    public ApiResponse<PublicUserResponse> getPublicUser(@PathVariable Long userId) {
        return ApiResponse.ok(userService.getPublicUser(userId));
    }

    @GetMapping("/me/settings")
    public ApiResponse<SettingsResponse> getSettings(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(userService.getSettings(userId));
    }

    @PutMapping("/me/settings")
    public ApiResponse<SettingsResponse> updateSettings(
            @AuthenticationPrincipal PrincipalDetails principal,
            @RequestBody SettingsUpdateRequest request
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(userService.updateSettings(userId, request));
    }
}
