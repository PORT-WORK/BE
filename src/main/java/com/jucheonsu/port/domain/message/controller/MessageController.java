package com.jucheonsu.port.domain.message.controller;

import com.jucheonsu.port.domain.message.dto.request.MessageCreateRequest;
import com.jucheonsu.port.domain.message.dto.request.MessageUpdateRequest;
import com.jucheonsu.port.domain.message.dto.response.MessageResponse;
import com.jucheonsu.port.domain.message.service.MessageService;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;

    @GetMapping("/inbox")
    public ApiResponse<List<MessageResponse>> getInbox(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(messageService.getInbox(userId));
    }

    @GetMapping("/sent")
    public ApiResponse<List<MessageResponse>> getSent(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(messageService.getSent(userId));
    }

    @PostMapping
    public ApiResponse<MessageResponse> send(
            @AuthenticationPrincipal PrincipalDetails principal,
            @Valid @RequestBody MessageCreateRequest request
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(messageService.send(userId, request));
    }

    @PutMapping("/{messageId}/read")
    public ApiResponse<MessageResponse> markAsRead(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable Long messageId
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(messageService.markAsRead(userId, messageId));
    }

    @PutMapping("/{messageId}")
    public ApiResponse<MessageResponse> update(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable Long messageId,
            @Valid @RequestBody MessageUpdateRequest request
    ) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(messageService.update(userId, messageId, request));
    }

    @DeleteMapping("/{messageId}")
    public ApiResponse<Void> delete(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable Long messageId
    ) {
        Long userId = principal.getUserId();
        messageService.delete(userId, messageId);
        return ApiResponse.ok();
    }
}
