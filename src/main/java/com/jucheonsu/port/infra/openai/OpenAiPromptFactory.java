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
}
