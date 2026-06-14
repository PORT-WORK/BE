package com.jucheonsu.port.domain.portfolio.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.domain.portfolio.repository.PortfolioRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import com.jucheonsu.port.infra.cloudinary.CloudinaryUploader;
import com.jucheonsu.port.infra.openai.OpenAiClient;
import com.jucheonsu.port.infra.ppt.PptExportService;
import com.jucheonsu.port.infra.ppt.PptSlideBuilder;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
@RequiredArgsConstructor
public class PortfolioPptxServiceImpl implements PortfolioPptxService {

    private final PortfolioRepository portfolioRepository;
    private final OpenAiClient openAiClient;
    private final PptSlideBuilder pptSlideBuilder;
    private final PptExportService pptExportService;
    private final CloudinaryUploader cloudinaryUploader;
    private final ObjectMapper objectMapper;

    @Override
    @Transactional
    public byte[] renderAndStore(Long portfolioId, String sourceText, String fileName) {
        String layoutJson = buildLayoutJson(portfolioId, sourceText);
        return renderLayoutAndStore(portfolioId, layoutJson, fileName);
    }

    @Override
    @Transactional
    public byte[] renderLayoutAndStore(Long portfolioId, String layoutJson, String fileName) {
        Portfolio portfolio = portfolioRepository.findByIdAndDeletedAtIsNull(portfolioId)
                .orElseThrow(() -> new CustomException(ErrorCode.PORTFOLIO_NOT_FOUND));
        byte[] bytes = pptExportService.exportPortfolio(portfolioId, layoutJson);
        String actualFileName = StringUtils.hasText(fileName) ? fileName : "portfolio-" + portfolioId + ".pptx";
        String url = cloudinaryUploader.upload(bytes, actualFileName, "pptx").url();
        portfolio.updatePptxUrl(url);
        return bytes;
    }

    @Override
    public String buildLayoutJson(Long portfolioId, String sourceText) {
        String aiJson = null;
        try {
            aiJson = openAiClient.generatePptLayout(sourceText);
            if (StringUtils.hasText(aiJson)) {
                objectMapper.readTree(aiJson);
                return aiJson;
            }
        } catch (Exception ignored) {
        }
        return pptSlideBuilder.buildPresentationJson(portfolioId, sourceText);
    }
}
