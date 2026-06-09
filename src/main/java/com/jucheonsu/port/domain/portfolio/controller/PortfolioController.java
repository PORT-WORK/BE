package com.jucheonsu.port.domain.portfolio.controller;

import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioCreateRequest;
import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioUpdateRequest;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import com.jucheonsu.port.domain.portfolio.service.PortfolioService;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.response.PageResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/portfolios")
@RequiredArgsConstructor
public class PortfolioController {
    private final PortfolioService portfolioService;
    @GetMapping public ApiResponse<PageResponse<PortfolioSummaryResponse>> searchPublicPortfolios(@RequestParam(required = false) String jobRole, @RequestParam(required = false) String skills, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {return ApiResponse.ok(PageResponse.from(portfolioService.searchPublicPortfolios(jobRole, skills, PageRequest.of(page, size))));}
    @GetMapping("/me") public ApiResponse<List<PortfolioSummaryResponse>> getMyPortfolios(@RequestHeader("X-USER-ID") Long userId) {return ApiResponse.ok(portfolioService.getMyPortfolios(userId));}
    @PostMapping public ApiResponse<PortfolioResponse> create(@RequestHeader("X-USER-ID") Long userId, @Valid @RequestBody PortfolioCreateRequest request) {return ApiResponse.ok(portfolioService.create(userId, request));}
    @GetMapping("/{portfolioId}") public ApiResponse<PortfolioResponse> getDetail(@PathVariable Long portfolioId) {return ApiResponse.ok(portfolioService.getDetail(portfolioId));}
    @PutMapping("/{portfolioId}") public ApiResponse<PortfolioResponse> update(@RequestHeader("X-USER-ID") Long userId, @PathVariable Long portfolioId, @Valid @RequestBody PortfolioUpdateRequest request) {return ApiResponse.ok(portfolioService.update(userId, portfolioId, request));}
    @DeleteMapping("/{portfolioId}") public ApiResponse<Void> delete(@RequestHeader("X-USER-ID") Long userId, @PathVariable Long portfolioId) {portfolioService.delete(userId, portfolioId);return ApiResponse.ok();}
}
