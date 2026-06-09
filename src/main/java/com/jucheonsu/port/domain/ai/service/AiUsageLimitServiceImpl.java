package com.jucheonsu.port.domain.ai.service;

import com.jucheonsu.port.domain.common.enums.TierType;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AiUsageLimitServiceImpl implements AiUsageLimitService {

    private final UserRepository userRepository;

    @Value("${app.ai.free-monthly-limit}")
    private int freeLimit;

    @Value("${app.ai.pro-monthly-limit}")
    private int proLimit;

    public boolean canUse(Long userId) {
        User user = getUser(userId);
        int limit = user.getTier() == TierType.PRO ? proLimit : freeLimit;
        return user.getAiUsageCount() < limit;
    }

    @Transactional
    public void increase(Long userId) {
        User user = getUser(userId);
        if (!canUse(userId)) {
            throw new CustomException(ErrorCode.ACCESS_DENIED);
        }
        user.increaseAiUsageCount();
    }

    private User getUser(Long userId) {
        return userRepository.findByIdAndDeletedAtIsNull(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
    }
}
