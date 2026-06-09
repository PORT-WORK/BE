package com.jucheonsu.port.domain.ai.converter;

import com.jucheonsu.port.domain.ai.dto.response.AiMessageResponse;
import com.jucheonsu.port.domain.ai.entity.AiChatMessage;

public final class AiChatMessageConverter {

    private AiChatMessageConverter() {
    }

    public static AiMessageResponse toResponse(AiChatMessage message) {
        return new AiMessageResponse(
                message.getId(),
                message.getRole(),
                message.getMessage(),
                message.getCreatedAt()
        );
    }
}
