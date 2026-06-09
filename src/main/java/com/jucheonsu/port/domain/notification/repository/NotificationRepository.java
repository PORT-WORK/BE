package com.jucheonsu.port.domain.notification.repository;

import com.jucheonsu.port.domain.notification.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findAllByUserIdOrderByCreatedAtDesc(Long userId);
    List<Notification> findAllByUserIdAndIsReadFalseOrderByCreatedAtDesc(Long userId);
    Optional<Notification> findByIdAndUserId(Long id, Long userId);
    long countByUserIdAndIsReadFalse(Long userId);
}
