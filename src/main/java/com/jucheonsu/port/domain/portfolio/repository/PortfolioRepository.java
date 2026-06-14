package com.jucheonsu.port.domain.portfolio.repository;

import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PortfolioRepository extends JpaRepository<Portfolio, Long> {

    @Query(
            value = """
                    select *
                    from portfolios p
                    where p.deleted_at is null
                      and p.is_public = true
                      and (:jobRole is null or lower(coalesce(p.job_role, '')) like lower(concat('%', :jobRole, '%')))
                      and (:skills is null or lower(coalesce(cast(p.skills as text), '')) like lower(concat('%', :skills, '%')))
                    """,
            countQuery = """
                    select count(*)
                    from portfolios p
                    where p.deleted_at is null
                      and p.is_public = true
                      and (:jobRole is null or lower(coalesce(p.job_role, '')) like lower(concat('%', :jobRole, '%')))
                      and (:skills is null or lower(coalesce(cast(p.skills as text), '')) like lower(concat('%', :skills, '%')))
                    """,
            nativeQuery = true
    )
    Page<Portfolio> searchPublicPortfolios(@Param("jobRole") String jobRole, @Param("skills") String skills, Pageable pageable);

    @Query("select p from Portfolio p where p.user.id = :userId and p.deletedAt is null order by p.createdAt desc")
    List<Portfolio> findMyPortfolios(@Param("userId") Long userId);

    List<Portfolio> findAllByUserIdAndDeletedAtIsNullOrderByCreatedAtDesc(Long userId);
    Optional<Portfolio> findByIdAndDeletedAtIsNull(Long id);
    Optional<Portfolio> findByIdAndUserIdAndDeletedAtIsNull(Long id, Long userId);
}
