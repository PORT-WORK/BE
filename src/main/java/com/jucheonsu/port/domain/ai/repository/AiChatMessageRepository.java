package com.jucheonsu.port.domain.ai.repository;

import com.jucheonsu.port.domain.ai.entity.AiChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiChatMessageRepository extends JpaRepository<AiChatMessage, Long> {

    List<AiChatMessage> findAllByWorkspaceIdOrderByCreatedAtAsc(Long workspaceId);
}
