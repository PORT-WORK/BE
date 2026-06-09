package com.jucheonsu.port.domain.portfolio.service;

import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioCreateRequest;
import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioUpdateRequest;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface PortfolioService {
    Page<PortfolioSummaryResponse> searchPublicPortfolios(String jobRole, String skills, Pageable pageable);
    List<PortfolioSummaryResponse> getMyPortfolios(Long userId);
    PortfolioResponse create(Long userId, PortfolioCreateRequest request);
    PortfolioResponse getDetail(Long portfolioId);
    PortfolioResponse update(Long userId, Long portfolioId, PortfolioUpdateRequest request);
    void delete(Long userId, Long portfolioId);
}
