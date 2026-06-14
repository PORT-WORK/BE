package com.jucheonsu.port.domain.portfolio.service;

public interface PortfolioPptxService {
    String buildLayoutJson(Long portfolioId, String sourceText);

    byte[] renderAndStore(Long portfolioId, String sourceText, String fileName);

    byte[] renderLayoutAndStore(Long portfolioId, String layoutJson, String fileName);
}
