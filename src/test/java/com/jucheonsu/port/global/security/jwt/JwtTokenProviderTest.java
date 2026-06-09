package com.jucheonsu.port.global.security.jwt;

import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import static org.assertj.core.api.Assertions.assertThat;

class JwtTokenProviderTest {

    @Test
    void createAndParseAccessToken() {
        JwtTokenProvider provider = new JwtTokenProvider();
        ReflectionTestUtils.setField(provider, "secret", "test-secret-key-test-secret-key-test-secret-key-test-secret-key");
        ReflectionTestUtils.setField(provider, "accessExpirationMs", 1800000L);
        ReflectionTestUtils.setField(provider, "refreshExpirationMs", 604800000L);
        provider.init();

        String token = provider.createAccessToken(1L, "test@test.com");

        assertThat(provider.isValid(token)).isTrue();
        assertThat(provider.getUserId(token)).isEqualTo(1L);
        assertThat(provider.getTokenType(token)).isEqualTo(JwtTokenType.ACCESS);
    }
}
