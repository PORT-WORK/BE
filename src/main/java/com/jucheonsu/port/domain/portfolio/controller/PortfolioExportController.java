package com.jucheonsu.port.domain.portfolio.controller;

import com.jucheonsu.port.domain.portfolio.dto.request.PptExportRequest;
import com.jucheonsu.port.domain.portfolio.service.PortfolioPptxService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api/portfolios/{portfolioId}/export")
@RequiredArgsConstructor
public class PortfolioExportController {

    private final PortfolioPptxService portfolioPptxService;

    @GetMapping({"/pptx", "/pdf"})
    public ResponseEntity<byte[]> exportPptx(
            @PathVariable Long portfolioId,
            @RequestParam(required = false) String sourceText
    ) {
        byte[] bytes = portfolioPptxService.renderAndStore(portfolioId, sourceText, "portfolio-" + portfolioId + ".pdf");

        ContentDisposition disposition = ContentDisposition.attachment()
                .filename("portfolio-" + portfolioId + ".pdf", StandardCharsets.UTF_8)
                .build();

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, disposition.toString())
                .contentType(MediaType.APPLICATION_PDF)
                .body(bytes);
    }

    @PostMapping({"/pptx", "/pdf"})
    public ResponseEntity<byte[]> exportPptxFromBody(
            @PathVariable Long portfolioId,
            @RequestBody(required = false) PptExportRequest request
    ) {
        String sourceText = request == null ? null : request.sourceText();
        byte[] bytes = portfolioPptxService.renderAndStore(portfolioId, sourceText, "portfolio-" + portfolioId + ".pdf");

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
                        .filename("portfolio-" + portfolioId + ".pdf", StandardCharsets.UTF_8)
                        .build().toString())
                .contentType(MediaType.APPLICATION_PDF)
                .body(bytes);
    }
}
