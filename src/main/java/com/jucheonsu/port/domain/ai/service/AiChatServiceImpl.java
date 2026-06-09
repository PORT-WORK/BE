package com.jucheonsu.port.domain.ai.service;

import com.jucheonsu.port.domain.ai.converter.AiChatMessageConverter;
import com.jucheonsu.port.domain.ai.dto.request.AiChatRequest;
import com.jucheonsu.port.domain.ai.dto.response.AiMessageResponse;
import com.jucheonsu.port.domain.ai.entity.AiChatMessage;
import com.jucheonsu.port.domain.ai.entity.AiWorkspace;
import com.jucheonsu.port.domain.ai.repository.AiChatMessageRepository;
import com.jucheonsu.port.domain.ai.repository.AiWorkspaceRepository;
import com.jucheonsu.port.domain.common.enums.ChatRoleType;
import com.jucheonsu.port.infra.openai.OpenAiClient;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AiChatServiceImpl implements AiChatService {

    private final AiWorkspaceRepository workspaceRepository;
    private final AiChatMessageRepository messageRepository;
    private final AiUsageLimitService aiUsageLimitService;
    private final OpenAiClient openAiClient;
    private final ExecutorService executorService = Executors.newVirtualThreadPerTaskExecutor();

    public List<AiMessageResponse> getMessages(Long workspaceId) {
        return messageRepository.findAllByWorkspaceIdOrderByCreatedAtAsc(workspaceId).stream()
                .map(AiChatMessageConverter::toResponse)
                .toList();
    }

    @Transactional
    public SseEmitter chat(Long workspaceId, AiChatRequest request) {
        AiWorkspace workspace = workspaceRepository.findById(workspaceId)
                .orElseThrow(() -> new CustomException(ErrorCode.WORKSPACE_NOT_FOUND));

        Long userId = workspace.getPortfolio().getUser().getId();
        aiUsageLimitService.increase(userId);

        messageRepository.save(AiChatMessage.builder()
                .workspace(workspace)
                .role(ChatRoleType.USER)
                .message(request.message())
                .idempotencyKey(UUID.randomUUID().toString())
                .build());

        SseEmitter emitter = new SseEmitter(120_000L);

        executorService.submit(() -> {
            StringBuilder full = new StringBuilder();
            try {
                String reply = openAiClient.generateChatReply(request.message());
                for (String chunk : reply.split(" ")) {
                    full.append(chunk).append(" ");
                    emitter.send(SseEmitter.event().name("chunk").data(chunk + " "));
                    Thread.sleep(35);
                }

                messageRepository.save(AiChatMessage.builder()
                        .workspace(workspace)
                        .role(ChatRoleType.ASSISTANT)
                        .message(full.toString().trim())
                        .idempotencyKey(UUID.randomUUID().toString())
                        .build());

                emitter.send(SseEmitter.event().name("done").data("[DONE]"));
                emitter.complete();
            } catch (IOException | InterruptedException e) {
                emitter.completeWithError(e);
                Thread.currentThread().interrupt();
            }
        });

        return emitter;
    }
}
