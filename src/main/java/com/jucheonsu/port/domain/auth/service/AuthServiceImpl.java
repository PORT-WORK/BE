package com.jucheonsu.port.domain.auth.service;

import com.jucheonsu.port.domain.auth.dto.request.TokenRefreshRequest;
import com.jucheonsu.port.domain.auth.dto.response.TokenResponse;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import com.jucheonsu.port.global.security.jwt.JwtTokenProvider;
import com.jucheonsu.port.global.security.jwt.JwtTokenType;
import com.jucheonsu.port.global.util.CookieUtil;
import com.jucheonsu.port.infra.redis.RefreshTokenRedisRepository;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AuthServiceImpl implements AuthService {

    private final JwtTokenProvider jwtTokenProvider;
    private final RefreshTokenRedisRepository refreshTokenRedisRepository;
    private final UserRepository userRepository;

    @Value("${jwt.access-expiration-ms}")
    private long accessExpirationMs;

    @Value("${jwt.refresh-expiration-ms}")
    private long refreshExpirationMs;

    @Value("${app.cookie-secure:true}")
    private boolean cookieSecure;

    public TokenResponse refresh(TokenRefreshRequest request, HttpServletResponse response) {
        String refreshToken = request.refreshToken();
        if (!jwtTokenProvider.isValid(refreshToken) || jwtTokenProvider.getTokenType(refreshToken) != JwtTokenType.REFRESH) {
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }

        Long userId = jwtTokenProvider.getUserId(refreshToken);
        String saved = refreshTokenRedisRepository.findByUserId(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.INVALID_REQUEST));
        if (!saved.equals(refreshToken)) {
            throw new CustomException(ErrorCode.INVALID_REQUEST);
        }

        User user = userRepository.findByIdAndDeletedAtIsNull(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        String newAccessToken = jwtTokenProvider.createAccessToken(user.getId(), user.getEmail());
        String newRefreshToken = jwtTokenProvider.createRefreshToken(user.getId(), user.getEmail());
        refreshTokenRedisRepository.save(userId, newRefreshToken);

        CookieUtil.addHttpOnlyCookie(response, "ACCESS_TOKEN", newAccessToken, accessExpirationMs / 1000, cookieSecure);
        CookieUtil.addHttpOnlyCookie(response, "REFRESH_TOKEN", newRefreshToken, refreshExpirationMs / 1000, cookieSecure);

        return new TokenResponse(newAccessToken, newRefreshToken);
    }

    public void logout(String refreshToken, HttpServletResponse response) {
        if (jwtTokenProvider.isValid(refreshToken)) {
            refreshTokenRedisRepository.delete(jwtTokenProvider.getUserId(refreshToken));
        }
        CookieUtil.expireCookie(response, "ACCESS_TOKEN", cookieSecure);
        CookieUtil.expireCookie(response, "REFRESH_TOKEN", cookieSecure);
    }
}
