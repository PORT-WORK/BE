package com.jucheonsu.port.domain.message.service;

import com.jucheonsu.port.domain.message.dto.request.MessageCreateRequest;
import com.jucheonsu.port.domain.message.dto.request.MessageUpdateRequest;
import com.jucheonsu.port.domain.message.dto.response.MessageResponse;

import java.util.List;

public interface MessageService {
    List<MessageResponse> getInbox(Long userId);
    List<MessageResponse> getSent(Long userId);
    MessageResponse send(Long senderId, MessageCreateRequest request);
    MessageResponse markAsRead(Long userId, Long messageId);
    MessageResponse update(Long userId, Long messageId, MessageUpdateRequest request);
    void delete(Long userId, Long messageId);
}
