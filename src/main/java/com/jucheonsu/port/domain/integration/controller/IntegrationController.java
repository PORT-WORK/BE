package com.jucheonsu.port.domain.integration.controller;

import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.domain.integration.dto.request.IntegrationConnectRequest;
import com.jucheonsu.port.domain.integration.dto.request.IntegrationEmbedRequest;
import com.jucheonsu.port.domain.integration.dto.request.FigmaSourceRequest;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationPreviewResponse;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationSourceItemResponse;
import com.jucheonsu.port.domain.integration.service.IntegrationService;
import com.jucheonsu.port.domain.user.dto.response.OAuthConnectionResponse;
import com.jucheonsu.port.global.response.ApiResponse;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/integrations")
@RequiredArgsConstructor
public class IntegrationController {

    private final IntegrationService integrationService;

    @GetMapping
    public ApiResponse<List<OAuthConnectionResponse>> getConnections(@AuthenticationPrincipal PrincipalDetails principal) {
        Long userId = principal.getUserId();
        return ApiResponse.ok(integrationService.getConnections(userId));
    }

    @GetMapping("/{provider}/authorize-url")
    public ApiResponse<String> getAuthorizeUrl(@PathVariable ProviderType provider) {
        return ApiResponse.ok(integrationService.getAuthorizationUrl(provider));
    }

    @PostMapping("/{provider}/callback")
    public ApiResponse<OAuthConnectionResponse> connect(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable ProviderType provider,
            @Valid @RequestBody IntegrationConnectRequest request
    ) {
        return ApiResponse.ok(integrationService.connect(principal.getUserId(), provider, request.code(), request.workspaceUrl()));
    }

    @DeleteMapping("/{provider}")
    public ApiResponse<Void> disconnect(@AuthenticationPrincipal PrincipalDetails principal, @PathVariable ProviderType provider) {
        integrationService.disconnect(principal.getUserId(), provider);
        return ApiResponse.ok();
    }

    @GetMapping("/{provider}/preview")
    public ApiResponse<IntegrationPreviewResponse> preview(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable ProviderType provider,
            @RequestParam(required = false) String resourceId
    ) {
        return ApiResponse.ok(integrationService.preview(principal.getUserId(), provider, resourceId));
    }

    @GetMapping("/{provider}/sources")
    public ApiResponse<List<IntegrationSourceItemResponse>> sources(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable ProviderType provider
    ) {
        return ApiResponse.ok(integrationService.listSources(principal.getUserId(), provider));
    }

    @PostMapping("/{provider}/sources")
    public ApiResponse<List<IntegrationSourceItemResponse>> addSource(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable ProviderType provider,
            @RequestBody FigmaSourceRequest request
    ) {
        return ApiResponse.ok(integrationService.addSource(principal.getUserId(), provider, request.sourceUrl()));
    }

    @PostMapping("/{provider}/embed")
    public ApiResponse<Object> createEmbedBlock(
            @AuthenticationPrincipal PrincipalDetails principal,
            @PathVariable ProviderType provider,
            @Valid @RequestBody IntegrationEmbedRequest request
    ) {
        return ApiResponse.ok(integrationService.createEmbedBlock(principal.getUserId(), request.documentId(), provider, request.resourceId()));
    }
}
