package com.jucheonsu.port.domain.project.repository;

import com.jucheonsu.port.domain.project.entity.ProjectWritingSession;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProjectWritingSessionRepository extends JpaRepository<ProjectWritingSession, Long> {
    Optional<ProjectWritingSession> findByProjectId(Long projectId);
}
