package com.jucheonsu.port.domain.integration.service;

import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.block.service.BlockService;
import com.jucheonsu.port.domain.common.enums.BlockType;
import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationPreviewResponse;
import com.jucheonsu.port.domain.notification.enums.NotificationType;
import com.jucheonsu.port.domain.user.dto.response.OAuthConnectionResponse;
import com.jucheonsu.port.domain.user.entity.OAuthConnection;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.OAuthConnectionRepository;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClient;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class IntegrationServiceImpl implements IntegrationService {

    private final OAuthConnectionRepository connectionRepository;
    private final UserRepository userRepository;
    private final BlockService blockService;
    private final RestClient restClient = RestClient.create();

    @Value("${app.integrations.github-client-id}")
    private String githubClientId;
    @Value("${app.integrations.github-client-secret}")
    private String githubClientSecret;
    @Value("${app.integrations.github-redirect-uri}")
    private String githubRedirectUri;

    @Value("${app.integrations.notion-client-id}")
    private String notionClientId;
    @Value("${app.integrations.notion-client-secret}")
    private String notionClientSecret;
    @Value("${app.integrations.notion-redirect-uri}")
    private String notionRedirectUri;

    @Value("${app.integrations.figma-client-id}")
    private String figmaClientId;
    @Value("${app.integrations.figma-client-secret}")
    private String figmaClientSecret;
    @Value("${app.integrations.figma-redirect-uri}")
    private String figmaRedirectUri;

    public String getAuthorizationUrl(ProviderType provider) {
        return switch (provider) {
            case GITHUB -> buildAuthorizeUrl("https://github.com/login/oauth/authorize", githubClientId, githubRedirectUri, "read:user repo user:email");
            case NOTION -> buildAuthorizeUrl("https://api.notion.com/v1/oauth/authorize", notionClientId, notionRedirectUri, "read:content insert:content");
            case FIGMA -> buildAuthorizeUrl("https://www.figma.com/oauth", figmaClientId, figmaRedirectUri, "file_read");
            default -> throw new CustomException(ErrorCode.INVALID_REQUEST);
        };
    }

    @Transactional
    public OAuthConnectionResponse connect(Long userId, ProviderType provider, String code, String workspaceUrl) {
        User user = userRepository.findByIdAndDeletedAtIsNull(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        TokenBundle tokens = exchangeToken(provider, code);
        OAuthConnection connection = connectionRepository.findByUserIdAndProvider(userId, provider)
                .orElseGet(() -> connectionRepository.save(OAuthConnection.builder()
                        .user(user)
                        .provider(provider)
                        .accessToken(tokens.accessToken())
                        .refreshToken(tokens.refreshToken())
                        .workspaceUrl(workspaceUrl != null ? workspaceUrl : tokens.workspaceUrl())
                        .expiresAt(tokens.expiresAt())
                        .build()));

        connection.update(
                tokens.accessToken(),
                tokens.refreshToken(),
                workspaceUrl != null ? workspaceUrl : tokens.workspaceUrl(),
                tokens.expiresAt()
        );
        OAuthConnection saved = connectionRepository.save(connection);
        return new OAuthConnectionResponse(saved.getId(), saved.getProvider(), saved.getWorkspaceUrl(), saved.getExpiresAt());
    }

    @Transactional
    public void disconnect(Long userId, ProviderType provider) {
        connectionRepository.deleteByUserIdAndProvider(userId, provider);
    }

    public List<OAuthConnectionResponse> getConnections(Long userId) {
        return connectionRepository.findAllByUserId(userId).stream()
                .map(connection -> new OAuthConnectionResponse(
                        connection.getId(),
                        connection.getProvider(),
                        connection.getWorkspaceUrl(),
                        connection.getExpiresAt()
                ))
                .toList();
    }

    public IntegrationPreviewResponse preview(Long userId, ProviderType provider, String resourceId) {
        OAuthConnection connection = connectionRepository.findByUserIdAndProvider(userId, provider)
                .orElseThrow(() -> new CustomException(ErrorCode.OAUTH_CONNECTION_NOT_FOUND));

        return switch (provider) {
            case GITHUB -> previewGithub(connection);
            case NOTION -> previewNotion(connection, resourceId);
            case FIGMA -> previewFigma(connection);
            default -> throw new CustomException(ErrorCode.INVALID_REQUEST);
        };
    }

    @Transactional
    public Object createEmbedBlock(Long userId, Long documentId, ProviderType provider, String resourceId) {
        IntegrationPreviewResponse preview = preview(userId, provider, resourceId);
        Map<String, Object> content = new LinkedHashMap<>();
        content.put("provider", preview.provider().name());
        content.put("title", preview.title());
        content.put("subtitle", preview.subtitle());
        content.put("url", preview.url());
        content.put("description", preview.description());
        content.put("imageUrl", preview.imageUrl());
        content.put("tags", preview.tags());
        content.put("raw", preview.raw());

        BlockResponse block = blockService.create(documentId, new BlockCreateRequest(BlockType.EMBED, content, null, null));
        return block;
    }

    private String buildAuthorizeUrl(String authorizeBaseUrl, String clientId, String redirectUri, String scope) {
        if (clientId == null || clientId.isBlank() || clientId.contains("placeholder")) {
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }
        return UriComponentsBuilder.fromUriString(authorizeBaseUrl)
                .queryParam("client_id", clientId)
                .queryParam("redirect_uri", redirectUri)
                .queryParam("response_type", "code")
                .queryParam("scope", scope)
                .queryParam("state", UUID.randomUUID())
                .build(true)
                .toUriString();
    }

    private TokenBundle exchangeToken(ProviderType provider, String code) {
        return switch (provider) {
            case GITHUB -> exchangeGithub(code);
            case NOTION -> exchangeNotion(code);
            case FIGMA -> exchangeFigma(code);
            default -> throw new CustomException(ErrorCode.INVALID_REQUEST);
        };
    }

    private TokenBundle exchangeGithub(String code) {
        Map<String, Object> body = restClient.post()
                .uri("https://github.com/login/oauth/access_token")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .body(Map.of(
                        "client_id", githubClientId,
                        "client_secret", githubClientSecret,
                        "code", code,
                        "redirect_uri", githubRedirectUri
                ))
                .retrieve()
                .body(Map.class);

        String accessToken = Objects.toString(body.get("access_token"), null);
        String refreshToken = Objects.toString(body.get("refresh_token"), null);
        return new TokenBundle(accessToken, refreshToken, null, null);
    }

    private TokenBundle exchangeNotion(String code) {
        Map<String, Object> body = restClient.post()
                .uri("https://api.notion.com/v1/oauth/token")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", basicAuth(notionClientId, notionClientSecret))
                .header("Notion-Version", "2022-06-28")
                .body(Map.of(
                        "grant_type", "authorization_code",
                        "code", code,
                        "redirect_uri", notionRedirectUri
                ))
                .retrieve()
                .body(Map.class);

        String accessToken = Objects.toString(body.get("access_token"), null);
        String refreshToken = Objects.toString(body.get("refresh_token"), null);
        Long expiresIn = body.get("expires_in") == null ? null : Long.valueOf(body.get("expires_in").toString());
        return new TokenBundle(accessToken, refreshToken, null, expiresIn == null ? null : LocalDateTime.now().plusSeconds(expiresIn));
    }

    private TokenBundle exchangeFigma(String code) {
        Map<String, Object> body = restClient.post()
                .uri("https://www.figma.com/api/oauth/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(formData(Map.of(
                        "grant_type", "authorization_code",
                        "code", code,
                        "redirect_uri", figmaRedirectUri,
                        "client_id", figmaClientId,
                        "client_secret", figmaClientSecret
                )))
                .retrieve()
                .body(Map.class);

        String accessToken = Objects.toString(body.get("access_token"), null);
        String refreshToken = Objects.toString(body.get("refresh_token"), null);
        Long expiresIn = body.get("expires_in") == null ? null : Long.valueOf(body.get("expires_in").toString());
        return new TokenBundle(accessToken, refreshToken, null, expiresIn == null ? null : LocalDateTime.now().plusSeconds(expiresIn));
    }

    private IntegrationPreviewResponse previewGithub(OAuthConnection connection) {
        Map<String, Object> user = githubApi(connection.getAccessToken(), "/user");
        List<Map<String, Object>> repos = githubApiList(connection.getAccessToken(), "/user/repos?sort=updated&per_page=6");
        return new IntegrationPreviewResponse(
                ProviderType.GITHUB,
                Objects.toString(user.get("name"), Objects.toString(user.get("login"), "GitHub")),
                Objects.toString(user.get("bio"), null),
                Objects.toString(user.get("html_url"), null),
                repos.isEmpty() ? "Recent repositories" : "Recent repositories: " + String.join(", ", repos.stream()
                        .map(repo -> Objects.toString(repo.get("name"), ""))
                        .filter(s -> !s.isBlank())
                        .toList()),
                Objects.toString(user.get("avatar_url"), null),
                List.of("repository", "profile", "github"),
                Map.of("profile", user, "repos", repos)
        );
    }

    private IntegrationPreviewResponse previewNotion(OAuthConnection connection, String resourceId) {
        if (resourceId == null || resourceId.isBlank()) {
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }
        Map<String, Object> page = notionApi(connection.getAccessToken(), "/v1/pages/" + resourceId);
        Map<String, Object> title = extractNotionTitle(resourceId, connection.getAccessToken());
        return new IntegrationPreviewResponse(
                ProviderType.NOTION,
                Objects.toString(title.get("text"), "Notion Page"),
                Objects.toString(page.get("url"), null),
                Objects.toString(page.get("url"), null),
                "Notion page preview",
                null,
                List.of("notion", "page", "embed"),
                Map.of("page", page, "title", title)
        );
    }

    private IntegrationPreviewResponse previewFigma(OAuthConnection connection) {
        return new IntegrationPreviewResponse(
                ProviderType.FIGMA,
                "Figma workspace",
                "Design files and components",
                connection.getWorkspaceUrl(),
                "Figma profile preview",
                null,
                List.of("figma", "design", "system"),
                Map.of("workspaceUrl", connection.getWorkspaceUrl())
        );
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> githubApi(String token, String path) {
        Map<String, Object> body = restClient.get()
                .uri("https://api.github.com" + path)
                .header("Authorization", "Bearer " + token)
                .header("Accept", "application/vnd.github+json")
                .retrieve()
                .body(Map.class);
        return body == null ? Map.of() : body;
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> githubApiList(String token, String path) {
        List<Map<String, Object>> body = restClient.get()
                .uri("https://api.github.com" + path)
                .header("Authorization", "Bearer " + token)
                .header("Accept", "application/vnd.github+json")
                .retrieve()
                .body(List.class);
        return body == null ? List.of() : body;
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> notionApi(String token, String path) {
        Map<String, Object> body = restClient.get()
                .uri("https://api.notion.com" + path)
                .header("Authorization", "Bearer " + token)
                .header("Notion-Version", "2022-06-28")
                .retrieve()
                .body(Map.class);
        return body == null ? Map.of() : body;
    }

    private Map<String, Object> extractNotionTitle(String pageId, String token) {
        Map<String, Object> blocks = restClient.get()
                .uri("https://api.notion.com/v1/blocks/" + pageId + "/children?page_size=1")
                .header("Authorization", "Bearer " + token)
                .header("Notion-Version", "2022-06-28")
                .retrieve()
                .body(Map.class);
        return blocks == null ? Map.of() : blocks;
    }

    private MultiValueMap<String, String> formData(Map<String, String> values) {
        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        values.forEach(form::add);
        return form;
    }

    private String basicAuth(String clientId, String clientSecret) {
        String raw = clientId + ":" + clientSecret;
        return "Basic " + Base64.getEncoder().encodeToString(raw.getBytes());
    }

    private Map<String, String> parseQueryLikeResponse(String response) {
        if (response == null || response.isBlank()) {
            return Map.of();
        }
        String cleaned = response.trim().replace("?", "");
        Map<String, String> parsed = new HashMap<>();
        for (String pair : cleaned.split("&")) {
            int index = pair.indexOf('=');
            if (index > 0) {
                parsed.put(pair.substring(0, index), pair.substring(index + 1));
            }
        }
        return parsed;
    }

    private record TokenBundle(String accessToken, String refreshToken, String workspaceUrl, LocalDateTime expiresAt) {
    }
}
