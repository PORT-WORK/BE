package com.jucheonsu.port.domain.user.service;

import com.jucheonsu.port.domain.user.dto.request.SettingsUpdateRequest;
import com.jucheonsu.port.domain.user.dto.request.UserUpdateRequest;
import com.jucheonsu.port.domain.user.dto.response.PublicUserResponse;
import com.jucheonsu.port.domain.user.dto.response.SettingsResponse;
import com.jucheonsu.port.domain.user.dto.response.UserResponse;

public interface UserService {

    UserResponse getMe(Long userId);

    PublicUserResponse getPublicUser(Long userId);

    UserResponse updateMe(Long userId, UserUpdateRequest request);

    void deleteMe(Long userId);

    SettingsResponse getSettings(Long userId);

    SettingsResponse updateSettings(Long userId, SettingsUpdateRequest request);
}
