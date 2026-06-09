package com.jucheonsu.port.domain.message.converter;

import com.jucheonsu.port.domain.message.dto.response.MessageResponse;
import com.jucheonsu.port.domain.message.entity.Message;

public final class MessageConverter {

    private MessageConverter() {
    }

    public static MessageResponse toResponse(Message message) {
        return new MessageResponse(
                message.getId(),
                message.getSender().getId(),
                message.getReceiver().getId(),
                message.getContent(),
                message.getIsRead(),
                message.getCreatedAt(),
                message.getReadAt()
        );
    }
}
