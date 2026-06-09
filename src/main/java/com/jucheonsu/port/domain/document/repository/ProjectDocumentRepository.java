package com.jucheonsu.port.domain.document.repository;

import com.jucheonsu.port.domain.document.entity.ProjectDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ProjectDocumentRepository extends JpaRepository<ProjectDocument, Long> {
    @Query("select d from ProjectDocument d where d.project.id = :projectId order by d.orderIndex asc nulls last, d.createdAt asc")
    List<ProjectDocument> findAllByProjectIdOrderByOrderIndex(Long projectId);
    List<ProjectDocument> findAllByProjectIdOrderByOrderIndexAsc(Long projectId);
    Optional<ProjectDocument> findByIdAndProjectId(Long id, Long projectId);
}
