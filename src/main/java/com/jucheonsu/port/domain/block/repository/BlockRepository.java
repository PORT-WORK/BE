package com.jucheonsu.port.domain.block.repository;

import com.jucheonsu.port.domain.block.entity.Block;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface BlockRepository extends JpaRepository<Block, Long> {
    @Query("select b from Block b left join fetch b.parent where b.document.id = :documentId order by b.orderIndex asc nulls last, b.createdAt asc")
    List<Block> findTreeByDocumentId(Long documentId);
    List<Block> findAllByDocumentIdOrderByOrderIndexAsc(Long documentId);
    Optional<Block> findByIdAndDocumentId(Long id, Long documentId);
}
