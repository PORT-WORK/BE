package com.jucheonsu.port.domain.ai.service;

import com.jucheonsu.port.domain.ai.dto.response.PortfolioDataResponse;

import java.util.List;
import java.util.Map;

public interface AiToolService {
    PortfolioDataResponse getPortfolioData(Long portfolioId);
    Object createBlock(Long projectDocumentId, String blockType, Map<String, Object> content);
    void updateBlockOrder(Long documentId, List<Map<String, Object>> blockOrders);
    byte[] buildPptxSlide(Long portfolioId, String layoutJson);
    String exportToPdf(Long portfolioId);
    List<String> getUserSkills(Long userId);
    boolean checkAiUsageLimit(Long userId);
    String generatePptLayoutJson(Long portfolioId, String sourceText);
}
