package com.jucheonsu.port.domain.portfolio.controller;

import com.jucheonsu.port.domain.portfolio.dto.request.PptExportRequest;
import com.jucheonsu.port.infra.openai.OpenAiClient;
import com.jucheonsu.port.infra.ppt.PptExportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.util.StringUtils;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api/portfolios/{portfolioId}/export")
@RequiredArgsConstructor
public class PortfolioExportController {

    private final PptExportService pptExportService;
    private final OpenAiClient openAiClient;

    @GetMapping("/pptx")
    public ResponseEntity<byte[]> exportPptx(
            @PathVariable Long portfolioId,
            @RequestParam(required = false) String sourceText
    ) {
        String layoutJson = StringUtils.hasText(sourceText)
                ? openAiClient.generatePptLayout(sourceText)
                : "{}";
        byte[] bytes = pptExportService.exportPortfolio(portfolioId, layoutJson);

        ContentDisposition disposition = ContentDisposition.attachment()
                .filename("portfolio-" + portfolioId + ".pptx", StandardCharsets.UTF_8)
                .build();

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, disposition.toString())
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.presentationml.presentation"))
                .body(bytes);
    }

    @PostMapping("/pptx")
    public ResponseEntity<byte[]> exportPptxFromBody(
            @PathVariable Long portfolioId,
            @RequestBody(required = false) PptExportRequest request
    ) {
        String sourceText = request == null ? null : request.sourceText();
        String layoutJson = StringUtils.hasText(sourceText)
                ? openAiClient.generatePptLayout(sourceText)
                : "{}";
        byte[] bytes = pptExportService.exportPortfolio(portfolioId, layoutJson);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
                        .filename("portfolio-" + portfolioId + ".pptx", StandardCharsets.UTF_8)
                        .build().toString())
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.presentationml.presentation"))
                .body(bytes);
    }
}
