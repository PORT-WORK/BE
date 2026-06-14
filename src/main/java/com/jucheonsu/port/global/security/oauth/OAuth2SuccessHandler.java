package com.jucheonsu.port.global.security.oauth;

import com.jucheonsu.port.domain.common.enums.LanguageType;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.security.jwt.JwtTokenProvider;
import com.jucheonsu.port.global.util.CookieUtil;
import com.jucheonsu.port.infra.redis.RefreshTokenRedisRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final RefreshTokenRedisRepository refreshTokenRedisRepository;

    @Value("${app.frontend-url}")
    private String frontendUrl;

    @Value("${app.cookie-secure:true}")
    private boolean cookieSecure;

    @Value("${jwt.access-expiration-ms}")
    private long accessExpirationMs;

    @Value("${jwt.refresh-expiration-ms}")
    private long refreshExpirationMs;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {
        try {
            OAuth2User oauthUser = (OAuth2User) authentication.getPrincipal();
            String email = extractEmail(oauthUser);
            String name = extractName(oauthUser);
            String profileImageUrl = extractProfileImage(oauthUser);

            User user = userRepository.findByEmailAndDeletedAtIsNull(email)
                    .orElseGet(() -> userRepository.save(User.builder()
                            .email(email)
                            .name(name)
                            .profileImageUrl(profileImageUrl)
                            .language(LanguageType.ko)
                            .build()));

            String accessToken = jwtTokenProvider.createAccessToken(user.getId(), user.getEmail());
            String refreshToken = jwtTokenProvider.createRefreshToken(user.getId(), user.getEmail());
            refreshTokenRedisRepository.save(user.getId(), refreshToken);

            CookieUtil.addHttpOnlyCookie(response, "ACCESS_TOKEN", accessToken, accessExpirationMs / 1000, cookieSecure);
            CookieUtil.addHttpOnlyCookie(response, "REFRESH_TOKEN", refreshToken, refreshExpirationMs / 1000, cookieSecure);
            response.sendRedirect(frontendUrl + "/oauth/success");
        } catch (Exception e) {
            log.warn("OAuth success handling failed: {}", e.getMessage(), e);
            if (!response.isCommitted()) {
                response.sendRedirect(frontendUrl + "/login?error=oauth");
            }
        }
    }

    private String extractEmail(OAuth2User oauthUser) {
        Object email = oauthUser.getAttribute("email");
        if (email != null) {
            return email.toString();
        }
        Object kakaoAccount = oauthUser.getAttribute("kakao_account");
        if (kakaoAccount instanceof Map<?, ?> account && account.get("email") != null) {
            return account.get("email").toString();
        }
        return oauthUser.getName() + "@oauth.local";
    }

    private String extractName(OAuth2User oauthUser) {
        Object name = oauthUser.getAttribute("name");
        if (name != null) {
            return name.toString();
        }
        Object properties = oauthUser.getAttribute("properties");
        if (properties instanceof Map<?, ?> map && map.get("nickname") != null) {
            return map.get("nickname").toString();
        }
        return "PORT User";
    }

    private String extractProfileImage(OAuth2User oauthUser) {
        Object picture = oauthUser.getAttribute("picture");
        if (picture != null) {
            return picture.toString();
        }
        Object properties = oauthUser.getAttribute("properties");
        if (properties instanceof Map<?, ?> map && map.get("profile_image") != null) {
            return map.get("profile_image").toString();
        }
        Object kakaoAccount = oauthUser.getAttribute("kakao_account");
        if (kakaoAccount instanceof Map<?, ?> account) {
            Object profile = account.get("profile");
            if (profile instanceof Map<?, ?> profileMap && profileMap.get("profile_image_url") != null) {
                return profileMap.get("profile_image_url").toString();
            }
        }
        return null;
    }
}
