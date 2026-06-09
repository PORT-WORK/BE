package com.jucheonsu.port.domain.ai.controller;

import com.jucheonsu.port.domain.ai.dto.request.AiChatRequest;
import com.jucheonsu.port.domain.ai.dto.response.AiMessageResponse;
import com.jucheonsu.port.domain.ai.service.AiChatService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AiController {

    private final AiChatService aiChatService;

    @GetMapping("/workspaces/{workspaceId}/messages")
    public ApiResponse<List<AiMessageResponse>> getMessages(@PathVariable Long workspaceId) {
        return ApiResponse.ok(aiChatService.getMessages(workspaceId));
    }

    @PostMapping("/workspaces/{workspaceId}/chat")
    public SseEmitter chat(@PathVariable Long workspaceId, @Valid @RequestBody AiChatRequest request) {
        return aiChatService.chat(workspaceId, request);
    }
}
