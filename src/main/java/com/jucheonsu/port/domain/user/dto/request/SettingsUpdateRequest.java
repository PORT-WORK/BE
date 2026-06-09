package com.jucheonsu.port.domain.user.dto.request;

import com.jucheonsu.port.domain.common.enums.LanguageType;

public record SettingsUpdateRequest(
        LanguageType language,
        Boolean notiEmail,
        Boolean notiPush,
        Boolean notiMessage
) {
}
