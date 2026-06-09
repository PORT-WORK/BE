package com.jucheonsu.port.global.security.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtTokenProvider {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.access-expiration-ms}")
    private long accessExpirationMs;

    @Value("${jwt.refresh-expiration-ms}")
    private long refreshExpirationMs;

    private SecretKey key;

    @PostConstruct
    void init() {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public String createAccessToken(Long userId, String email) {
        return createToken(userId, email, JwtTokenType.ACCESS, accessExpirationMs);
    }

    public String createRefreshToken(Long userId, String email) {
        return createToken(userId, email, JwtTokenType.REFRESH, refreshExpirationMs);
    }

    public boolean isValid(String token) {
        try {
            parseClaims(token);
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }

    public Long getUserId(String token) {
        return Long.valueOf(parseClaims(token).getSubject());
    }

    public JwtTokenType getTokenType(String token) {
        return JwtTokenType.valueOf(parseClaims(token).get("type", String.class));
    }

    private String createToken(Long userId, String email, JwtTokenType type, long expirationMs) {
        Date now = new Date();
        Date expiresAt = new Date(now.getTime() + expirationMs);
        return Jwts.builder()
                .subject(String.valueOf(userId))
                .claim("email", email)
                .claim("type", type.name())
                .issuedAt(now)
                .expiration(expiresAt)
                .signWith(key)
                .compact();
    }

    private Claims parseClaims(String token) {
        return Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
