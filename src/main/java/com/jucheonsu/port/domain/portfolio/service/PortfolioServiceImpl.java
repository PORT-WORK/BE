package com.jucheonsu.port.domain.portfolio.service;

import com.jucheonsu.port.domain.portfolio.converter.PortfolioConverter;
import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioCreateRequest;
import com.jucheonsu.port.domain.portfolio.dto.request.PortfolioUpdateRequest;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.domain.portfolio.repository.PortfolioRepository;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PortfolioServiceImpl implements PortfolioService {
    private final PortfolioRepository portfolioRepository;
    private final UserRepository userRepository;

    @Override
    public Page<PortfolioSummaryResponse> searchPublicPortfolios(String jobRole, String skills, Pageable pageable) {
        return portfolioRepository.searchPublicPortfolios(jobRole, skills, pageable).map(PortfolioConverter::toSummaryResponse);
    }

    @Override
    public List<PortfolioSummaryResponse> getMyPortfolios(Long userId) {
        return portfolioRepository.findMyPortfolios(userId).stream().map(PortfolioConverter::toSummaryResponse).toList();
    }

    @Override
    public List<PortfolioSummaryResponse> getUserPortfolios(Long userId) {
        return portfolioRepository.findPublicPortfoliosByUserId(userId).stream().map(PortfolioConverter::toSummaryResponse).toList();
    }

    @Override
    @Transactional
    public PortfolioResponse create(Long userId, PortfolioCreateRequest request) {
        User user = userRepository.findByIdAndDeletedAtIsNull(userId).orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
        Portfolio portfolio = Portfolio.builder().user(user).title(request.title()).jobRole(request.jobRole()).templateId(request.templateId()).isPublic(Boolean.TRUE.equals(request.isPublic())).build();
        return PortfolioConverter.toResponse(portfolioRepository.save(portfolio));
    }

    @Override
    @Transactional
    public PortfolioResponse getDetail(Long portfolioId) {
        Portfolio portfolio = portfolioRepository.findByIdAndDeletedAtIsNull(portfolioId).orElseThrow(() -> new CustomException(ErrorCode.PORTFOLIO_NOT_FOUND));
        portfolio.increaseViewCount();
        return PortfolioConverter.toResponse(portfolio);
    }

    @Override
    @Transactional
    public PortfolioResponse update(Long userId, Long portfolioId, PortfolioUpdateRequest request) {
        Portfolio portfolio = portfolioRepository.findByIdAndUserIdAndDeletedAtIsNull(portfolioId, userId).orElseThrow(() -> new CustomException(ErrorCode.PORTFOLIO_NOT_FOUND));
        portfolio.update(request.title(), request.summary(), request.isPublic(), request.customDomain());
        return PortfolioConverter.toResponse(portfolio);
    }

    @Override
    @Transactional
    public void delete(Long userId, Long portfolioId) {
        Portfolio portfolio = portfolioRepository.findByIdAndUserIdAndDeletedAtIsNull(portfolioId, userId).orElseThrow(() -> new CustomException(ErrorCode.PORTFOLIO_NOT_FOUND));
        portfolio.delete();
    }

    @Override
    @Transactional
    public void updatePptxUrl(Long portfolioId, String pptxUrl) {
        Portfolio portfolio = portfolioRepository.findByIdAndDeletedAtIsNull(portfolioId)
                .orElseThrow(() -> new CustomException(ErrorCode.PORTFOLIO_NOT_FOUND));
        portfolio.updatePptxUrl(pptxUrl);
    }
}
