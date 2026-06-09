package com.jucheonsu.port.domain.integration.controller;

import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.domain.integration.dto.request.IntegrationConnectRequest;
import com.jucheonsu.port.domain.integration.dto.request.IntegrationEmbedRequest;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationPreviewResponse;
import com.jucheonsu.port.domain.integration.service.IntegrationService;
import com.jucheonsu.port.domain.user.dto.response.OAuthConnectionResponse;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/integrations")
@RequiredArgsConstructor
public class IntegrationController {

    private final IntegrationService integrationService;

    @GetMapping
    public ApiResponse<List<OAuthConnectionResponse>> getConnections(@RequestHeader("X-USER-ID") Long userId) {
        return ApiResponse.ok(integrationService.getConnections(userId));
    }

    @GetMapping("/{provider}/authorize-url")
    public ApiResponse<String> getAuthorizeUrl(@PathVariable ProviderType provider) {
        return ApiResponse.ok(integrationService.getAuthorizationUrl(provider));
    }

    @PostMapping("/{provider}/callback")
    public ApiResponse<OAuthConnectionResponse> connect(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable ProviderType provider,
            @Valid @RequestBody IntegrationConnectRequest request
    ) {
        return ApiResponse.ok(integrationService.connect(userId, provider, request.code(), request.workspaceUrl()));
    }

    @DeleteMapping("/{provider}")
    public ApiResponse<Void> disconnect(@RequestHeader("X-USER-ID") Long userId, @PathVariable ProviderType provider) {
        integrationService.disconnect(userId, provider);
        return ApiResponse.ok();
    }

    @GetMapping("/{provider}/preview")
    public ApiResponse<IntegrationPreviewResponse> preview(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable ProviderType provider,
            @RequestParam(required = false) String resourceId
    ) {
        return ApiResponse.ok(integrationService.preview(userId, provider, resourceId));
    }

    @PostMapping("/{provider}/embed")
    public ApiResponse<Object> createEmbedBlock(
            @RequestHeader("X-USER-ID") Long userId,
            @PathVariable ProviderType provider,
            @Valid @RequestBody IntegrationEmbedRequest request
    ) {
        return ApiResponse.ok(integrationService.createEmbedBlock(userId, request.documentId(), provider, request.resourceId()));
    }
}
