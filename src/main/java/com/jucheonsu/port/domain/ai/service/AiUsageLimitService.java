package com.jucheonsu.port.domain.ai.service;

public interface AiUsageLimitService {
    boolean canUse(Long userId);
    void increase(Long userId);
}
