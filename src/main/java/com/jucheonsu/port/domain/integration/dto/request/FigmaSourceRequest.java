package com.jucheonsu.port.domain.integration.dto.request;

public record FigmaSourceRequest(
        String fileUrl,
        String workspaceUrl
) {
    public String sourceUrl() {
        return fileUrl != null && !fileUrl.isBlank() ? fileUrl : workspaceUrl;
    }
}
