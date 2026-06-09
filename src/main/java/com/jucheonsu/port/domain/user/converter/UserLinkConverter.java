package com.jucheonsu.port.domain.user.converter;

import com.jucheonsu.port.domain.user.dto.response.UserLinkResponse;
import com.jucheonsu.port.domain.user.entity.UserLink;

public final class UserLinkConverter {

    private UserLinkConverter() {
    }

    public static UserLinkResponse toResponse(UserLink link) {
        return new UserLinkResponse(link.getId(), link.getPlatform(), link.getUrl());
    }
}
