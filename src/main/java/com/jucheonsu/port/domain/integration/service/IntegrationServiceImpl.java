package com.jucheonsu.port.domain.integration.service;

import com.jucheonsu.port.domain.block.dto.request.BlockCreateRequest;
import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.block.service.BlockService;
import com.jucheonsu.port.domain.common.enums.BlockType;
import com.jucheonsu.port.domain.common.enums.ProviderType;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationPreviewResponse;
import com.jucheonsu.port.domain.integration.dto.response.IntegrationSourceItemResponse;
import com.jucheonsu.port.domain.notification.enums.NotificationType;
import com.jucheonsu.port.domain.user.dto.response.OAuthConnectionResponse;
import com.jucheonsu.port.domain.user.entity.OAuthConnection;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.OAuthConnectionRepository;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestClientResponseException;
import org.springframework.web.client.RestClient;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.time.LocalDateTime;
import java.util.*;

@Service
@Slf4j
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
            case FIGMA -> buildAuthorizeUrl("https://www.figma.com/oauth", figmaClientId, figmaRedirectUri, "file_content:read");
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

    public List<IntegrationSourceItemResponse> listSources(Long userId, ProviderType provider) {
        OAuthConnection connection = connectionRepository.findByUserIdAndProvider(userId, provider)
                .orElseThrow(() -> new CustomException(ErrorCode.OAUTH_CONNECTION_NOT_FOUND));

        return switch (provider) {
            case GITHUB -> listGithubSources(connection);
            case NOTION -> listNotionSources(connection);
            case FIGMA -> listFigmaSources(connection);
            default -> throw new CustomException(ErrorCode.INVALID_REQUEST);
        };
    }

    public IntegrationPreviewResponse preview(Long userId, ProviderType provider, String resourceId) {
        IntegrationSourceItemResponse item = findSourceItem(userId, provider, resourceId);
        return new IntegrationPreviewResponse(
                item.provider(),
                item.title(),
                item.subtitle(),
                item.url(),
                item.summary(),
                item.imageUrl(),
                item.tags(),
                item.raw()
        );
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

    private IntegrationSourceItemResponse findSourceItem(Long userId, ProviderType provider, String resourceId) {
        List<IntegrationSourceItemResponse> items = listSources(userId, provider);
        if (items.isEmpty()) {
            throw new CustomException(ErrorCode.OAUTH_CONNECTION_NOT_FOUND);
        }
        if (resourceId == null || resourceId.isBlank()) {
            return items.getFirst();
        }
        return items.stream()
                .filter(item -> resourceId.equals(item.resourceId()))
                .findFirst()
                .orElse(items.getFirst());
    }

    private List<IntegrationSourceItemResponse> listGithubSources(OAuthConnection connection) {
        List<Map<String, Object>> repos = githubApiList(connection.getAccessToken(), "/user/repos?sort=updated&per_page=20&affiliation=owner,collaborator,organization_member");
        List<IntegrationSourceItemResponse> items = new ArrayList<>();
        for (Map<String, Object> repo : repos) {
            String fullName = Objects.toString(repo.get("full_name"), Objects.toString(repo.get("name"), ""));
            if (!StringUtils.hasText(fullName)) {
                continue;
            }
            items.add(buildGithubSource(connection.getAccessToken(), repo));
            items.addAll(buildGithubReadmeSources(connection.getAccessToken(), fullName));
            items.addAll(buildGithubIssueSources(connection.getAccessToken(), fullName));
            items.addAll(buildGithubPullRequestSources(connection.getAccessToken(), fullName));
            items.addAll(buildGithubReleaseSources(connection.getAccessToken(), fullName));
        }
        return items.stream().limit(40).toList();
    }

    private List<IntegrationSourceItemResponse> buildGithubReadmeSources(String token, String fullName) {
        Map<String, Object> readme = githubApi(token, "/repos/" + fullName + "/readme");
        if (readme.isEmpty()) {
            return List.of();
        }
        Map<String, Object> raw = new LinkedHashMap<>();
        raw.put("readme", readme);
        return List.of(new IntegrationSourceItemResponse(
                ProviderType.GITHUB,
                fullName + ":README",
                "README",
                fullName + " README",
                "README",
                StringUtils.hasText(Objects.toString(readme.get("download_url"), "")) ? "Repository README available" : "README document",
                Objects.toString(readme.get("html_url"), Objects.toString(readme.get("url"), null)),
                null,
                List.of("readme", "markdown", "github"),
                raw
        ));
    }

    private List<IntegrationSourceItemResponse> buildGithubIssueSources(String token, String fullName) {
        List<Map<String, Object>> issues = githubApiList(token, "/repos/" + fullName + "/issues?state=all&per_page=3");
        return issues.stream()
                .filter(issue -> !issue.containsKey("pull_request"))
                .map(issue -> {
                    String number = Objects.toString(issue.get("number"), "");
                    Map<String, Object> raw = new LinkedHashMap<>();
                    raw.put("issue", issue);
                    return new IntegrationSourceItemResponse(
                            ProviderType.GITHUB,
                            fullName + ":ISSUE:" + number,
                            "ISSUE",
                            firstNonBlank(Objects.toString(issue.get("title"), ""), "Issue " + number),
                            fullName,
                            buildGithubSummary(issue),
                            Objects.toString(issue.get("html_url"), null),
                            null,
                            List.of("issue", Objects.toString(issue.get("state"), "open"), "github"),
                            raw
                    );
                })
                .toList();
    }

    private List<IntegrationSourceItemResponse> buildGithubPullRequestSources(String token, String fullName) {
        List<Map<String, Object>> pulls = githubApiList(token, "/repos/" + fullName + "/pulls?state=all&per_page=3");
        return pulls.stream()
                .map(pr -> {
                    String number = Objects.toString(pr.get("number"), "");
                    Map<String, Object> raw = new LinkedHashMap<>();
                    raw.put("pullRequest", pr);
                    return new IntegrationSourceItemResponse(
                            ProviderType.GITHUB,
                            fullName + ":PR:" + number,
                            "PR",
                            firstNonBlank(Objects.toString(pr.get("title"), ""), "Pull request " + number),
                            fullName,
                            buildGithubSummary(pr),
                            Objects.toString(pr.get("html_url"), null),
                            null,
                            List.of("pr", "pull-request", "github"),
                            raw
                    );
                })
                .toList();
    }

    private List<IntegrationSourceItemResponse> buildGithubReleaseSources(String token, String fullName) {
        List<Map<String, Object>> releases = githubApiList(token, "/repos/" + fullName + "/releases?per_page=3");
        return releases.stream()
                .map(release -> {
                    String tag = Objects.toString(release.get("tag_name"), "");
                    Map<String, Object> raw = new LinkedHashMap<>();
                    raw.put("release", release);
                    return new IntegrationSourceItemResponse(
                            ProviderType.GITHUB,
                            fullName + ":RELEASE:" + tag,
                            "RELEASE",
                            firstNonBlank(Objects.toString(release.get("name"), ""), tag, "Release"),
                            fullName,
                            buildGithubSummary(release),
                            Objects.toString(release.get("html_url"), null),
                            null,
                            List.of("release", "github"),
                            raw
                    );
                })
                .toList();
    }

    private IntegrationSourceItemResponse buildGithubSource(String token, Map<String, Object> repo) {
        String fullName = Objects.toString(repo.get("full_name"), Objects.toString(repo.get("name"), ""));

        List<String> tags = new ArrayList<>();
        Object repoTopics = repo.get("topics");
        if (repoTopics instanceof List<?> topics) {
            for (Object topic : topics) {
                String value = Objects.toString(topic, "");
                if (!value.isBlank()) {
                    tags.add(value);
                }
            }
        }
        if (repo.get("language") != null) {
            tags.add(Objects.toString(repo.get("language"), ""));
        }
        String visibility = Objects.toString(repo.get("visibility"), "");
        if (StringUtils.hasText(visibility)) {
            tags.add(visibility);
        }

        Map<String, Object> raw = new LinkedHashMap<>();
        raw.put("repo", repo);

        String summary = buildGithubSummary(repo);
        return new IntegrationSourceItemResponse(
                ProviderType.GITHUB,
                fullName,
                "REPOSITORY",
                Objects.toString(repo.get("name"), fullName),
                Objects.toString(repo.get("description"), "Repository source"),
                summary,
                Objects.toString(repo.get("html_url"), null),
                Objects.toString(((Map<?, ?>) repo.getOrDefault("owner", Map.of())).get("avatar_url"), null),
                tags.stream().filter(StringUtils::hasText).distinct().toList(),
                raw
        );
    }

    private String buildGithubSummary(Map<String, Object> repo) {
        List<String> parts = new ArrayList<>();
        String description = Objects.toString(repo.get("description"), "");
        if (StringUtils.hasText(description)) parts.add(description);
        String language = Objects.toString(repo.get("language"), "");
        if (StringUtils.hasText(language)) parts.add("Language: " + language);
        String stars = Objects.toString(repo.get("stargazers_count"), "");
        if (StringUtils.hasText(stars)) parts.add("Stars: " + stars);
        String updated = Objects.toString(repo.get("updated_at"), "");
        if (StringUtils.hasText(updated)) parts.add("Updated: " + updated);
        return String.join(" · ", parts);
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (StringUtils.hasText(value)) {
                return value;
            }
        }
        return "";
    }

    private List<IntegrationSourceItemResponse> listNotionSources(OAuthConnection connection) {
        Map<String, Object> result = notionSearch(connection.getAccessToken());
        List<Map<String, Object>> items = result.get("results") instanceof List<?> list
                ? list.stream().filter(Map.class::isInstance).map(item -> (Map<String, Object>) item).toList()
                : List.of();
        return items.stream().map(item -> buildNotionSource(item)).toList();
    }

    private Map<String, Object> notionSearch(String token) {
        Map<String, Object> body = restClient.post()
                .uri("https://api.notion.com/v1/search")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .header("Notion-Version", "2022-06-28")
                .body(Map.of("page_size", 20))
                .retrieve()
                .body(Map.class);
        return body == null ? Map.of() : body;
    }

    private IntegrationSourceItemResponse buildNotionSource(Map<String, Object> item) {
        String type = Objects.toString(item.get("object"), "page").toUpperCase(Locale.ROOT);
        String resourceId = Objects.toString(item.get("id"), "");
        String title = extractNotionTitle(item);
        String url = Objects.toString(item.get("url"), null);
        String summary = Objects.toString(item.get("last_edited_time"), "Notion source");
        String imageUrl = null;
        Object icon = item.get("icon");
        if (icon instanceof Map<?, ?> iconMap) {
            imageUrl = Objects.toString(iconMap.get("emoji"), null);
        }
        return new IntegrationSourceItemResponse(
                ProviderType.NOTION,
                resourceId,
                type,
                title,
                Objects.toString(item.get("object"), "Notion page"),
                summary,
                url,
                imageUrl,
                List.of(type.toLowerCase(Locale.ROOT), "notion"),
                item
        );
    }

    private String extractNotionTitle(Map<String, Object> item) {
        Object properties = item.get("properties");
        if (properties instanceof Map<?, ?> map) {
            for (Object value : map.values()) {
                if (value instanceof Map<?, ?> valueMap) {
                    Object title = valueMap.get("title");
                    if (title instanceof List<?> titleList && !titleList.isEmpty()) {
                        Object first = titleList.getFirst();
                        if (first instanceof Map<?, ?> firstMap) {
                            String text = Objects.toString(firstMap.get("plain_text"), "");
                            if (StringUtils.hasText(text)) {
                                return text;
                            }
                        }
                    }
                }
            }
        }
        Object title = item.get("title");
        if (title instanceof List<?> titleList && !titleList.isEmpty()) {
            Object first = titleList.getFirst();
            if (first instanceof Map<?, ?> firstMap) {
                String text = Objects.toString(firstMap.get("plain_text"), "");
                if (StringUtils.hasText(text)) {
                    return text;
                }
            }
        }
        return Objects.toString(item.get("id"), "Notion source");
    }

    private List<IntegrationSourceItemResponse> listFigmaSources(OAuthConnection connection) {
        String workspaceUrl = connection.getWorkspaceUrl();
        String fileKey = extractFigmaFileKey(workspaceUrl);
        if (!StringUtils.hasText(fileKey)) {
            return List.of(buildFigmaFallbackSource(workspaceUrl, "figma-workspace"));
        }
        try {
            Map<String, Object> file = figmaFile(connection.getAccessToken(), fileKey);
            Object document = file.get("document");
            if (!(document instanceof Map<?, ?> root)) {
                return List.of(buildFigmaFallbackSource(workspaceUrl, fileKey));
            }
            List<IntegrationSourceItemResponse> items = new ArrayList<>();
            collectFigmaNodes(fileKey, workspaceUrl, file, root, "FILE", 0, items);
            if (items.isEmpty()) {
                items.add(buildFigmaFallbackSource(workspaceUrl, fileKey));
            }
            return items;
        } catch (Exception ex) {
            return List.of(buildFigmaFallbackSource(workspaceUrl, fileKey));
        }
    }

    private IntegrationSourceItemResponse buildFigmaFallbackSource(String workspaceUrl, String fileKey) {
        Map<String, Object> raw = new LinkedHashMap<>();
        raw.put("workspaceUrl", workspaceUrl);
        raw.put("fileKey", fileKey);
        return new IntegrationSourceItemResponse(
                ProviderType.FIGMA,
                StringUtils.hasText(fileKey) ? fileKey : "figma-workspace",
                "FILE",
                StringUtils.hasText(fileKey) ? "Figma file " + fileKey : "Figma workspace",
                "Figma",
                StringUtils.hasText(workspaceUrl) ? "Connected Figma workspace: " + workspaceUrl : "Connected Figma workspace",
                workspaceUrl,
                null,
                List.of("figma", "workspace"),
                raw
        );
    }

    private Map<String, Object> figmaFile(String token, String fileKey) {
        Map<String, Object> body = restClient.get()
                .uri("https://api.figma.com/v1/files/" + fileKey)
                .header("Authorization", "Bearer " + token)
                .retrieve()
                .body(Map.class);
        return body == null ? Map.of() : body;
    }

    @SuppressWarnings("unchecked")
    private void collectFigmaNodes(String fileKey, String workspaceUrl, Map<String, Object> file, Map<?, ?> node, String path, int depth, List<IntegrationSourceItemResponse> items) {
        if (items.size() >= 30) {
            return;
        }
        String type = Objects.toString(node.get("type"), "").toUpperCase(Locale.ROOT);
        String name = Objects.toString(node.get("name"), "");
        String id = Objects.toString(node.get("id"), "");
        String currentPath = path;
        if (StringUtils.hasText(name)) {
            currentPath = StringUtils.hasText(path) ? path + " / " + name : name;
        }
        if (StringUtils.hasText(id) && (depth == 0 || Set.of("PAGE", "FRAME", "SECTION", "COMPONENT", "INSTANCE").contains(type))) {
            Object childrenObj = node.get("children");
            int childCount = childrenObj instanceof List<?> childList ? childList.size() : 0;
            Map<String, Object> raw = new LinkedHashMap<>();
            raw.put("file", file);
            raw.put("node", new LinkedHashMap<>((Map<String, Object>) node));
            raw.put("path", currentPath);
            raw.put("childCount", childCount);
            items.add(new IntegrationSourceItemResponse(
                    ProviderType.FIGMA,
                    fileKey + ":" + id,
                    type.isBlank() ? "NODE" : type,
                    StringUtils.hasText(name) ? name : "Untitled node",
                    currentPath,
                    childCount + " child nodes",
                    buildFigmaUrl(workspaceUrl, id),
                    null,
                    List.of(type.isBlank() ? "node" : type.toLowerCase(Locale.ROOT)),
                    raw
            ));
        }

        Object children = node.get("children");
        if (children instanceof List<?> childList) {
            for (Object child : childList) {
                if (items.size() >= 30) {
                    break;
                }
                if (child instanceof Map<?, ?> childMap) {
                    collectFigmaNodes(fileKey, workspaceUrl, file, childMap, currentPath, depth + 1, items);
                }
            }
        }
    }

    private String extractFigmaFileKey(String workspaceUrl) {
        if (!StringUtils.hasText(workspaceUrl)) {
            return "";
        }
        String cleaned = workspaceUrl.trim();
        if (cleaned.contains("figma.com/file/")) {
            String after = cleaned.substring(cleaned.indexOf("figma.com/file/") + "figma.com/file/".length());
            return after.split("[/?#]")[0];
        }
        if (cleaned.contains("figma.com/design/")) {
            String after = cleaned.substring(cleaned.indexOf("figma.com/design/") + "figma.com/design/".length());
            return after.split("[/?#]")[0];
        }
        return cleaned.split("[/?#]")[0];
    }

    private String buildFigmaUrl(String workspaceUrl, String nodeId) {
        if (!StringUtils.hasText(workspaceUrl)) {
            return null;
        }
        return workspaceUrl.contains("?") ? workspaceUrl + "&node-id=" + nodeId : workspaceUrl + "?node-id=" + nodeId;
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
                .build()
                .encode()
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
        try {
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

            if (body == null || body.containsKey("error") || body.get("access_token") == null) {
                log.warn("GitHub token exchange failed: {}", body);
                throw new CustomException(ErrorCode.INVALID_REQUEST);
            }
            String accessToken = Objects.toString(body.get("access_token"), null);
            String refreshToken = Objects.toString(body.get("refresh_token"), null);
            return new TokenBundle(accessToken, refreshToken, null, null);
        } catch (RestClientResponseException e) {
            log.warn("GitHub token exchange error: status={} body={}", e.getStatusCode().value(), e.getResponseBodyAsString());
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        } catch (RestClientException e) {
            log.warn("GitHub token exchange transport error: {}", e.getMessage(), e);
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }
    }

    private TokenBundle exchangeNotion(String code) {
        try {
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

            if (body == null || body.containsKey("error") || body.get("access_token") == null) {
                log.warn("Notion token exchange failed: {}", body);
                throw new CustomException(ErrorCode.INVALID_REQUEST);
            }
            String accessToken = Objects.toString(body.get("access_token"), null);
            String refreshToken = Objects.toString(body.get("refresh_token"), null);
            Long expiresIn = body.get("expires_in") == null ? null : Long.valueOf(body.get("expires_in").toString());
            return new TokenBundle(accessToken, refreshToken, null, expiresIn == null ? null : LocalDateTime.now().plusSeconds(expiresIn));
        } catch (RestClientResponseException e) {
            log.warn("Notion token exchange error: status={} body={}", e.getStatusCode().value(), e.getResponseBodyAsString());
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        } catch (RestClientException e) {
            log.warn("Notion token exchange transport error: {}", e.getMessage(), e);
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }
    }

    private TokenBundle exchangeFigma(String code) {
        try {
            log.info("===== FIGMA TOKEN EXCHANGE =====");
            log.info("redirectUri={}", figmaRedirectUri);
            log.info("clientId={}", figmaClientId);
            log.info("code={}", code);

            Map<String, Object> body = restClient.post()
                    .uri("https://api.figma.com/v1/oauth/token")
                    .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                    .header(
                            "Authorization",
                            basicAuth(figmaClientId, figmaClientSecret)
                    )
                    .body(formData(Map.of(
                            "grant_type", "authorization_code",
                            "code", code,
                            "redirect_uri", figmaRedirectUri
                    )))
                    .retrieve()
                    .body(Map.class);

            if (body == null || body.containsKey("error") || body.get("access_token") == null) {
                log.warn("Figma token exchange failed: {}", body);
                throw new CustomException(ErrorCode.INVALID_REQUEST);
            }

            String accessToken = Objects.toString(body.get("access_token"), null);
            String refreshToken = Objects.toString(body.get("refresh_token"), null);

            Long expiresIn = body.get("expires_in") == null
                    ? null
                    : Long.valueOf(body.get("expires_in").toString());

            return new TokenBundle(
                    accessToken,
                    refreshToken,
                    null,
                    expiresIn == null
                            ? null
                            : LocalDateTime.now().plusSeconds(expiresIn)
            );

        } catch (RestClientResponseException e) {
            log.warn(
                    "Figma token exchange error: status={} body={}",
                    e.getStatusCode().value(),
                    e.getResponseBodyAsString()
            );
            throw new CustomException(ErrorCode.INVALID_REQUEST);

        } catch (RestClientException e) {
            log.warn(
                    "Figma token exchange transport error: {}",
                    e.getMessage(),
                    e
            );
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }
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
        try {
            Map<String, Object> body = restClient.get()
                    .uri("https://api.github.com" + path)
                    .header("Authorization", "Bearer " + token)
                    .header("Accept", "application/vnd.github+json")
                    .retrieve()
                    .body(Map.class);
            return body == null ? Map.of() : body;
        } catch (RestClientResponseException e) {
            log.warn("GitHub API error on {}: status={} body={}", path, e.getStatusCode().value(), e.getResponseBodyAsString());
            return Map.of();
        } catch (RestClientException e) {
            log.warn("GitHub API transport error on {}: {}", path, e.getMessage(), e);
            return Map.of();
        }
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> githubApiList(String token, String path) {
        try {
            List<Map<String, Object>> body = restClient.get()
                    .uri("https://api.github.com" + path)
                    .header("Authorization", "Bearer " + token)
                    .header("Accept", "application/vnd.github+json")
                    .retrieve()
                    .body(List.class);
            return body == null ? List.of() : body;
        } catch (RestClientResponseException e) {
            log.warn("GitHub API list error on {}: status={} body={}", path, e.getStatusCode().value(), e.getResponseBodyAsString());
            return List.of();
        } catch (RestClientException e) {
            log.warn("GitHub API transport error on {}: {}", path, e.getMessage(), e);
            return List.of();
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> notionApi(String token, String path) {
        try {
            Map<String, Object> body = restClient.get()
                    .uri("https://api.notion.com" + path)
                    .header("Authorization", "Bearer " + token)
                    .header("Notion-Version", "2022-06-28")
                    .retrieve()
                    .body(Map.class);
            return body == null ? Map.of() : body;
        } catch (RestClientResponseException e) {
            log.warn("Notion API error on {}: status={} body={}", path, e.getStatusCode().value(), e.getResponseBodyAsString());
            return Map.of();
        } catch (RestClientException e) {
            log.warn("Notion API transport error on {}: {}", path, e.getMessage(), e);
            return Map.of();
        }
    }

    private Map<String, Object> extractNotionTitle(String pageId, String token) {
        try {
            Map<String, Object> blocks = restClient.get()
                    .uri("https://api.notion.com/v1/blocks/" + pageId + "/children?page_size=1")
                    .header("Authorization", "Bearer " + token)
                    .header("Notion-Version", "2022-06-28")
                    .retrieve()
                    .body(Map.class);
            return blocks == null ? Map.of() : blocks;
        } catch (RestClientResponseException e) {
            log.warn("Notion title fetch error on {}: status={} body={}", pageId, e.getStatusCode().value(), e.getResponseBodyAsString());
            return Map.of();
        } catch (RestClientException e) {
            log.warn("Notion title fetch transport error on {}: {}", pageId, e.getMessage(), e);
            return Map.of();
        }
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
