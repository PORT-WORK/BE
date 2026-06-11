package com.jucheonsu.port.infra.openai;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.util.List;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class OpenAiClient {

    private final OpenAiPromptFactory promptFactory;
    private final RestClient restClient = RestClient.create();

    @Value("${spring.ai.openai.api-key:}")
    private String apiKey;

    @Value("${spring.ai.openai.chat.options.model:gpt-4o-mini}")
    private String model;

    public String generatePptLayout(String sourceText) {
        return complete(promptFactory.createPortfolioPptPrompt(sourceText));
    }

    public String generateReview(String documentText) {
        if (apiKey == null || apiKey.isBlank() || apiKey.contains("placeholder")) {
            return documentText;
        }
        return complete(promptFactory.createReviewPrompt(documentText));
    }

    public String generateChatReply(String userMessage) {
        String prompt = """
                You are PORT AI, a helpful portfolio assistant.
                Answer in Korean unless the user asks otherwise.
                Keep answers concise, practical, and structured.

                User message:
                %s
                """.formatted(userMessage);
        return complete(prompt);
    }

    @SuppressWarnings("unchecked")
    private String complete(String prompt) {
        if (apiKey == null || apiKey.isBlank() || apiKey.contains("placeholder")) {
            return prompt;
        }

        Map<String, Object> body = restClient.post()
                .uri("https://api.openai.com/v1/chat/completions")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + apiKey)
                .body(Map.of(
                        "model", model,
                        "temperature", 0.3,
                        "messages", List.of(
                                Map.of("role", "system", "content", "You are PORT AI."),
                                Map.of("role", "user", "content", prompt)
                        )
                ))
                .retrieve()
                .body(Map.class);

        if (body == null) {
            return prompt;
        }

        Object choices = body.get("choices");
        if (choices instanceof List<?> list && !list.isEmpty() && list.get(0) instanceof Map<?, ?> choice) {
            Object message = choice.get("message");
            if (message instanceof Map<?, ?> messageMap) {
                Object content = messageMap.get("content");
                if (content != null) {
                    return content.toString();
                }
            }
        }

        return prompt;
    }
}
