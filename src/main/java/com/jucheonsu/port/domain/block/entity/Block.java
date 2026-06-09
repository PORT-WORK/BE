package com.jucheonsu.port.domain.block.entity;

import com.jucheonsu.port.domain.common.enums.BlockType;
import com.jucheonsu.port.domain.document.entity.ProjectDocument;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.Map;

@Getter
@Entity
@Table(name = "blocks")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Block extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "document_id", nullable = false)
    private ProjectDocument document;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Block parent;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private BlockType blockType;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb", nullable = false)
    private Map<String, Object> content;

    private Integer orderIndex;

    public void updateContent(Map<String, Object> content) {
        this.content = content;
    }

    public void updateOrder(Integer orderIndex, Block parent) {
        this.orderIndex = orderIndex;
        this.parent = parent;
    }
}
