package com.jucheonsu.port.domain.user.repository;

import com.jucheonsu.port.domain.user.entity.OAuthConnection;
import com.jucheonsu.port.domain.common.enums.ProviderType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OAuthConnectionRepository extends JpaRepository<OAuthConnection, Long> {

    List<OAuthConnection> findAllByUserId(Long userId);

    Optional<OAuthConnection> findByUserIdAndProvider(Long userId, ProviderType provider);

    void deleteByUserIdAndProvider(Long userId, ProviderType provider);
}
