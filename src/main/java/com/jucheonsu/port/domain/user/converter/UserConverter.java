package com.jucheonsu.port.domain.user.converter;

import com.jucheonsu.port.domain.user.dto.response.PublicUserResponse;
import com.jucheonsu.port.domain.user.dto.response.SettingsResponse;
import com.jucheonsu.port.domain.user.dto.response.UserResponse;
import com.jucheonsu.port.domain.user.entity.User;

public final class UserConverter {

    private UserConverter() {
    }

    public static UserResponse toResponse(User user) {
        return new UserResponse(
                user.getId(),
                user.getEmail(),
                user.getName(),
                user.getProfileImageUrl(),
                user.getTier(),
                user.getLocation(),
                user.getExperienceYears(),
                user.getBio(),
                user.getLanguage(),
                user.getIsEmailPublic()
        );
    }

    public static PublicUserResponse toPublicResponse(User user) {
        return new PublicUserResponse(
                user.getId(),
                user.getName(),
                user.getProfileImageUrl(),
                user.getLocation(),
                user.getExperienceYears(),
                user.getBio(),
                Boolean.TRUE.equals(user.getIsEmailPublic()) ? user.getEmail() : null
        );
    }

    public static SettingsResponse toSettingsResponse(User user) {
        return new SettingsResponse(
                user.getLanguage(),
                user.getNotiEmail(),
                user.getNotiPush(),
                user.getNotiMessage()
        );
    }
}
