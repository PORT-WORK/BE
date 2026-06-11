package com.jucheonsu.port.domain.portfolio.controller;

import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioCreateRequest;
import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioUpdateRequest;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import com.jucheonsu.port.domain.portfolio.service.PortfolioService;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.response.PageResponse;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/portfolios")
@RequiredArgsConstructor
public class PortfolioController {
    private final PortfolioService portfolioService;
    @GetMapping public ApiResponse<PageResponse<PortfolioSummaryResponse>> searchPublicPortfolios(@RequestParam(required = false) String jobRole, @RequestParam(required = false) String skills, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "12") int size) {return ApiResponse.ok(PageResponse.from(portfolioService.searchPublicPortfolios(jobRole, skills, PageRequest.of(page, size))));}
    @GetMapping("/me") public ApiResponse<List<PortfolioSummaryResponse>> getMyPortfolios(@AuthenticationPrincipal PrincipalDetails principal) {return ApiResponse.ok(portfolioService.getMyPortfolios(principal.getUserId()));}
    @PostMapping public ApiResponse<PortfolioResponse> create(@AuthenticationPrincipal PrincipalDetails principal, @Valid @RequestBody PortfolioCreateRequest request) {return ApiResponse.ok(portfolioService.create(principal.getUserId(), request));}
    @GetMapping("/{portfolioId}") public ApiResponse<PortfolioResponse> getDetail(@PathVariable Long portfolioId) {return ApiResponse.ok(portfolioService.getDetail(portfolioId));}
    @PutMapping("/{portfolioId}") public ApiResponse<PortfolioResponse> update(@AuthenticationPrincipal PrincipalDetails principal, @PathVariable Long portfolioId, @Valid @RequestBody PortfolioUpdateRequest request) {return ApiResponse.ok(portfolioService.update(principal.getUserId(), portfolioId, request));}
    @DeleteMapping("/{portfolioId}") public ApiResponse<Void> delete(@AuthenticationPrincipal PrincipalDetails principal, @PathVariable Long portfolioId) {portfolioService.delete(principal.getUserId(), portfolioId);return ApiResponse.ok();}
}
