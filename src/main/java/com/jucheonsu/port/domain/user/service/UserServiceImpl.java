package com.jucheonsu.port.domain.user.service;

import com.jucheonsu.port.domain.user.converter.UserConverter;
import com.jucheonsu.port.domain.user.dto.request.SettingsUpdateRequest;
import com.jucheonsu.port.domain.user.dto.request.UserUpdateRequest;
import com.jucheonsu.port.domain.user.dto.response.PublicUserResponse;
import com.jucheonsu.port.domain.user.dto.response.SettingsResponse;
import com.jucheonsu.port.domain.user.dto.response.UserResponse;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.domain.portfolio.converter.PortfolioConverter;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioSummaryResponse;
import com.jucheonsu.port.domain.portfolio.repository.PortfolioRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PortfolioRepository portfolioRepository;

    @Override
    public UserResponse getMe(Long userId) {
        return UserConverter.toResponse(getUser(userId));
    }

    @Override
    public PublicUserResponse getPublicUser(Long userId) {
        return UserConverter.toPublicResponse(getUser(userId));
    }

    @Override
    public List<PortfolioSummaryResponse> getPublicUserPortfolios(Long userId) {
        return portfolioRepository.findPublicPortfoliosByUserId(userId).stream().map(PortfolioConverter::toSummaryResponse).toList();
    }

    @Override
    @Transactional
    public UserResponse updateMe(Long userId, UserUpdateRequest request) {
        User user = getUser(userId);
        user.updateProfile(
                request.name(),
                request.profileImageUrl(),
                request.bio(),
                request.location(),
                request.experienceYears(),
                request.isEmailPublic()
        );
        return UserConverter.toResponse(user);
    }

    @Override
    @Transactional
    public void deleteMe(Long userId) {
        getUser(userId).delete();
    }

    @Override
    public SettingsResponse getSettings(Long userId) {
        return UserConverter.toSettingsResponse(getUser(userId));
    }

    @Override
    @Transactional
    public SettingsResponse updateSettings(Long userId, SettingsUpdateRequest request) {
        User user = getUser(userId);
        user.updateSettings(
                request.language(),
                request.notiEmail(),
                request.notiPush(),
                request.notiMessage()
        );
        return UserConverter.toSettingsResponse(user);
    }

    private User getUser(Long userId) {
        return userRepository.findByIdAndDeletedAtIsNull(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
    }
}
