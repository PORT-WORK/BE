package com.jucheonsu.port.domain.user.dto.response;

import com.jucheonsu.port.domain.common.enums.LanguageType;

public record SettingsResponse(
        LanguageType language,
        Boolean notiEmail,
        Boolean notiPush,
        Boolean notiMessage
) {
}
