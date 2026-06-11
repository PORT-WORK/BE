package com.jucheonsu.port.global.config;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.util.StringUtils;

@Configuration
public class RedisConfig {

    @Bean
    public LettuceConnectionFactory redisConnectionFactory(
            @Value("${REDIS_URL:${spring.data.redis.url:redis://localhost:6379}}") String redisUrl
    ) {
        RedisUrlParts parts = parse(redisUrl);
        RedisStandaloneConfiguration standalone = new RedisStandaloneConfiguration(parts.host(), parts.port());
        if (StringUtils.hasText(parts.username())) {
            standalone.setUsername(parts.username());
        }
        if (StringUtils.hasText(parts.password())) {
            standalone.setPassword(RedisPassword.of(parts.password()));
        }

        LettuceClientConfiguration.LettuceClientConfigurationBuilder clientBuilder = LettuceClientConfiguration.builder();
        if (parts.ssl()) {
            clientBuilder.useSsl();
        }
        return new LettuceConnectionFactory(standalone, clientBuilder.build());
    }

    private RedisUrlParts parse(String rawUrl) {
        try {
            URI uri = new URI(rawUrl);
            String scheme = uri.getScheme() == null ? "redis" : uri.getScheme();
            boolean ssl = "rediss".equalsIgnoreCase(scheme);
            String host = StringUtils.hasText(uri.getHost()) ? uri.getHost() : "localhost";
            int port = uri.getPort() > 0 ? uri.getPort() : 6379;
            String userInfo = uri.getUserInfo();
            String username = null;
            String password = null;
            if (StringUtils.hasText(userInfo)) {
                String[] credentials = userInfo.split(":", 2);
                username = credentials[0];
                if (credentials.length > 1) {
                    password = credentials[1];
                }
            }
            return new RedisUrlParts(host, port, username, password, ssl);
        } catch (URISyntaxException e) {
            throw new IllegalArgumentException("Invalid REDIS_URL: " + rawUrl, e);
        }
    }

    private record RedisUrlParts(String host, int port, String username, String password, boolean ssl) {}
}