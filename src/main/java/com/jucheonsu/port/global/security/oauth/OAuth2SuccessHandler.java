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
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final RefreshTokenRedisRepository refreshTokenRedisRepository;

    @Value("${app.frontend-url}")
    private String frontendUrl;

    @Value("${jwt.access-expiration-ms}")
    private long accessExpirationMs;

    @Value("${jwt.refresh-expiration-ms}")
    private long refreshExpirationMs;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {
        OAuth2User oauthUser = (OAuth2User) authentication.getPrincipal();
        String email = extractEmail(oauthUser);
        String name = extractName(oauthUser);

        User user = userRepository.findByEmailAndDeletedAtIsNull(email)
                .orElseGet(() -> userRepository.save(User.builder()
                        .email(email)
                        .name(name)
                        .language(LanguageType.ko)
                        .build()));

        String accessToken = jwtTokenProvider.createAccessToken(user.getId(), user.getEmail());
        String refreshToken = jwtTokenProvider.createRefreshToken(user.getId(), user.getEmail());
        refreshTokenRedisRepository.save(user.getId(), refreshToken);

        CookieUtil.addHttpOnlyCookie(response, "ACCESS_TOKEN", accessToken, accessExpirationMs / 1000);
        CookieUtil.addHttpOnlyCookie(response, "REFRESH_TOKEN", refreshToken, refreshExpirationMs / 1000);
        response.sendRedirect(frontendUrl + "/oauth/success");
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
}
