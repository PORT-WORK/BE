package com.jucheonsu.port.domain.user.repository;

import com.jucheonsu.port.domain.user.entity.Education;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EducationRepository extends JpaRepository<Education, Long> {

    List<Education> findAllByUserIdOrderByStartYearDesc(Long userId);

    Optional<Education> findByIdAndUserId(Long id, Long userId);
}
