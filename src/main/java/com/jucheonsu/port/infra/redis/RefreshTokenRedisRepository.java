package com.jucheonsu.port.infra.redis;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class RefreshTokenRedisRepository {

    private final StringRedisTemplate redisTemplate;

    @Value("${jwt.refresh-expiration-ms}")
    private long refreshExpirationMs;

    public void save(Long userId, String refreshToken) {
        redisTemplate.opsForValue().set(key(userId), refreshToken, Duration.ofMillis(refreshExpirationMs));
    }

    public Optional<String> findByUserId(Long userId) {
        return Optional.ofNullable(redisTemplate.opsForValue().get(key(userId)));
    }

    public void delete(Long userId) {
        redisTemplate.delete(key(userId));
    }

    private String key(Long userId) {
        return "auth:refresh:" + userId;
    }
}
