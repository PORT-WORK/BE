package com.jucheonsu.port.domain.ai.service;

import com.jucheonsu.port.domain.ai.dto.request.AiChatRequest;
import com.jucheonsu.port.domain.ai.dto.response.AiMessageResponse;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

public interface AiChatService {
    List<AiMessageResponse> getMessages(Long workspaceId);
    SseEmitter chat(Long workspaceId, AiChatRequest request);
}
