package com.jucheonsu.port.domain.message.service;

import com.jucheonsu.port.domain.message.converter.MessageConverter;
import com.jucheonsu.port.domain.message.dto.request.MessageCreateRequest;
import com.jucheonsu.port.domain.message.dto.response.MessageResponse;
import com.jucheonsu.port.domain.message.entity.Message;
import com.jucheonsu.port.domain.message.repository.MessageRepository;
import com.jucheonsu.port.domain.notification.enums.NotificationType;
import com.jucheonsu.port.domain.notification.service.NotificationService;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MessageServiceImpl implements MessageService {

    private final MessageRepository messageRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;

    public List<MessageResponse> getInbox(Long userId) {
        return messageRepository.findAllByReceiverIdOrderByCreatedAtDesc(userId).stream()
                .map(MessageConverter::toResponse)
                .toList();
    }

    public List<MessageResponse> getSent(Long userId) {
        return messageRepository.findAllBySenderIdOrderByCreatedAtDesc(userId).stream()
                .map(MessageConverter::toResponse)
                .toList();
    }

    @Transactional
    public MessageResponse send(Long senderId, MessageCreateRequest request) {
        User sender = userRepository.findByIdAndDeletedAtIsNull(senderId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
        User receiver = userRepository.findByIdAndDeletedAtIsNull(request.receiverId())
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Message message = messageRepository.save(Message.builder()
                .sender(sender)
                .receiver(receiver)
                .content(request.content())
                .build());

        notificationService.create(
                receiver.getId(),
                NotificationType.MESSAGE,
                sender.getName() + "님이 새 메시지를 보냈습니다.",
                request.content(),
                "/messages/" + message.getId()
        );

        return MessageConverter.toResponse(message);
    }

    @Transactional
    public MessageResponse markAsRead(Long userId, Long messageId) {
        Message message = messageRepository.findByIdAndReceiverId(messageId, userId)
                .orElseThrow(() -> new CustomException(ErrorCode.MESSAGE_NOT_FOUND));
        message.read();
        return MessageConverter.toResponse(message);
    }
}
