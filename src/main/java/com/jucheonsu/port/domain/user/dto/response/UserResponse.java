package com.jucheonsu.port.domain.user.dto.response;

import com.jucheonsu.port.domain.common.enums.LanguageType;
import com.jucheonsu.port.domain.common.enums.TierType;

public record UserResponse(
        Long id,
        String email,
        String name,
        String profileImageUrl,
        TierType tier,
        String location,
        Integer experienceYears,
        String bio,
        LanguageType language,
        Boolean isEmailPublic
) {
}
