package com.jucheonsu.port.domain.message.repository;

import com.jucheonsu.port.domain.message.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface MessageRepository extends JpaRepository<Message, Long> {
    @Query("select m from Message m where m.receiver.id = :userId or m.sender.id = :userId order by m.createdAt desc")
    List<Message> findInbox(Long userId);
    List<Message> findAllByReceiverIdOrderByCreatedAtDesc(Long receiverId);
    List<Message> findAllBySenderIdOrderByCreatedAtDesc(Long senderId);
    Optional<Message> findByIdAndReceiverId(Long id, Long receiverId);
    Optional<Message> findByIdAndSenderId(Long id, Long senderId);
}
