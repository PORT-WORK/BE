package com.jucheonsu.port.domain.ai.repository;

import com.jucheonsu.port.domain.ai.entity.AiWorkspace;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AiWorkspaceRepository extends JpaRepository<AiWorkspace, Long> {

    List<AiWorkspace> findAllByPortfolioIdOrderByCreatedAtDesc(Long portfolioId);

    Optional<AiWorkspace> findByIdAndPortfolioId(Long id, Long portfolioId);
}
