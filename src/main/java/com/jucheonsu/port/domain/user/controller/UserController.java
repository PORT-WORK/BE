package com.jucheonsu.port.domain.user.controller;

import com.jucheonsu.port.domain.user.dto.request.SettingsUpdateRequest;
import com.jucheonsu.port.domain.user.dto.request.UserUpdateRequest;
import com.jucheonsu.port.domain.user.dto.response.PublicUserResponse;
import com.jucheonsu.port.domain.user.dto.response.SettingsResponse;
import com.jucheonsu.port.domain.user.dto.response.UserResponse;
import com.jucheonsu.port.domain.user.service.UserService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/me")
    public ApiResponse<UserResponse> getMe(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(userService.getMe(userId));
    }

    @PutMapping("/me")
    public ApiResponse<UserResponse> updateMe(
            @RequestHeader("X-USER-ID") Long userId,
            @Valid @RequestBody UserUpdateRequest request
    ) {
        return ApiResponse.ok(userService.updateMe(userId, request));
    }

    @DeleteMapping("/me")
    public ApiResponse<Void> deleteMe(@RequestHeader("X-USER-ID") Long userId) {
        userService.deleteMe(userId);
        return ApiResponse.ok();
    }

    @GetMapping("/{userId}")
    public ApiResponse<PublicUserResponse> getPublicUser(@PathVariable Long userId) {
        return ApiResponse.ok(userService.getPublicUser(userId));
    }

    @GetMapping("/me/settings")
    public ApiResponse<SettingsResponse> getSettings(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(userService.getSettings(userId));
    }

    @PutMapping("/me/settings")
    public ApiResponse<SettingsResponse> updateSettings(
            @RequestHeader("X-USER-ID") Long userId,
            @RequestBody SettingsUpdateRequest request
    ) {
        return ApiResponse.ok(userService.updateSettings(userId, request));
    }
}
