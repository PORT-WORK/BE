package com.jucheonsu.port.infra.openai;

import org.springframework.stereotype.Component;

@Component
public class OpenAiPromptFactory {

    public String createPortfolioPptPrompt(String sourceText) {
        return """
                You are a portfolio PPT designer.
                Convert the user's experience into strict JSON for a 16:9 PPT deck.
                Use one of these themes: MODERN, MINIMAL, BOLD.
                Return JSON only, no markdown and no extra text.

                Input:
                %s
                """.formatted(sourceText);
    }

    public String createReviewPrompt(String documentText) {
        return """
                You are PORT's document reviewer.
                Polish the text for clarity, consistency, and flow.
                Do not invent facts, metrics, or achievements.
                Return only the revised document text.

                Input:
                %s
                """.formatted(documentText);
    }
}
