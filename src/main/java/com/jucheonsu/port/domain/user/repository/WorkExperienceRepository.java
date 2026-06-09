package com.jucheonsu.port.domain.user.repository;

import com.jucheonsu.port.domain.user.entity.WorkExperience;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface WorkExperienceRepository extends JpaRepository<WorkExperience, Long> {

    List<WorkExperience> findAllByUserIdOrderByStartDateDesc(Long userId);

    Optional<WorkExperience> findByIdAndUserId(Long id, Long userId);
}
