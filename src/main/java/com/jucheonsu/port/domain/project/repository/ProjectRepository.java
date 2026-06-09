package com.jucheonsu.port.domain.project.repository;

import com.jucheonsu.port.domain.project.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ProjectRepository extends JpaRepository<Project, Long> {
    @Query("select p from Project p where p.portfolio.id = :portfolioId order by p.orderIndex asc nulls last, p.createdAt asc")
    List<Project> findAllByPortfolioIdOrderByOrderIndex(Long portfolioId);
    List<Project> findAllByPortfolioIdOrderByOrderIndexAsc(Long portfolioId);
    Optional<Project> findByIdAndPortfolioId(Long id, Long portfolioId);
}
