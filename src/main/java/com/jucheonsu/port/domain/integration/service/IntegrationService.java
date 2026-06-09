package com.jucheonsu.port.domain.integration.service;

import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationPreviewResponse;
import com.jucheonsu.port.domain.user.dto.response.OAuthConnectionResponse;

import java.util.List;

public interface IntegrationService {
    String getAuthorizationUrl(ProviderType provider);
    OAuthConnectionResponse connect(Long userId, ProviderType provider, String code, String workspaceUrl);
    void disconnect(Long userId, ProviderType provider);
    List<OAuthConnectionResponse> getConnections(Long userId);
    IntegrationPreviewResponse preview(Long userId, ProviderType provider, String resourceId);
    Object createEmbedBlock(Long userId, Long documentId, ProviderType provider, String resourceId);
}
