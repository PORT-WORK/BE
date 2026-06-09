package com.jucheonsu.port.domain.user.dto.response;

public record PublicUserResponse(
        Long id,
        String name,
        String profileImageUrl,
        String location,
        Integer experienceYears,
        String bio,
        String email
) {
}
