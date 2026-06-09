package com.jucheonsu.port.domain.message.controller;

import com.jucheonsu.port.domain.message.dto.request.MessageCreateRequest;
import com.jucheonsu.port.domain.message.dto.response.MessageResponse;
import com.jucheonsu.port.domain.message.service.MessageService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;

    @GetMapping("/inbox")
    public ApiResponse<List<MessageResponse>> getInbox(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(messageService.getInbox(userId));
    }

    @GetMapping("/sent")
    public ApiResponse<List<MessageResponse>> getSent(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(messageService.getSent(userId));
    }

    @PostMapping
    public ApiResponse<MessageResponse> send(
            @RequestHeader("X-USER-ID") Long userId,
            @Valid @RequestBody MessageCreateRequest request
    ) {
        return ApiResponse.ok(messageService.send(userId, request));
    }

    @PutMapping("/{messageId}/read")
    public ApiResponse<MessageResponse> markAsRead(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable Long messageId
    ) {
        return ApiResponse.ok(messageService.markAsRead(userId, messageId));
    }
}
