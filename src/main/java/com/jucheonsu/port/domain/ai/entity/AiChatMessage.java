package com.jucheonsu.port.domain.ai.entity;

import com.jucheonsu.port.domain.common.enums.ChatRoleType;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "ai_chat_messages")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class AiChatMessage extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "workspace_id", nullable = false)
    private AiWorkspace workspace;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ChatRoleType role;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;

    @Column(nullable = false, length = 255)
    private String idempotencyKey;
}
