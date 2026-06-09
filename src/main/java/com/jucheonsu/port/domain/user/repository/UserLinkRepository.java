package com.jucheonsu.port.domain.user.repository;

import com.jucheonsu.port.domain.user.entity.UserLink;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserLinkRepository extends JpaRepository<UserLink, Long> {

    List<UserLink> findAllByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<UserLink> findByIdAndUserId(Long id, Long userId);
}
