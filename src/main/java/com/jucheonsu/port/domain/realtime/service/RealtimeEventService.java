package com.jucheonsu.port.domain.realtime.service;

import com.jucheonsu.port.domain.message.dto.response.MessageResponse;
import com.jucheonsu.port.domain.notification.dto.response.NotificationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutorService;

@Service
@RequiredArgsConstructor
public class RealtimeEventService {

    private final ConcurrentMap<Long, CopyOnWriteArrayList<SseEmitter>> emitters = new ConcurrentHashMap<>();
    private final ExecutorService applicationExecutor;

    public SseEmitter connect(Long userId) {
        SseEmitter emitter = new SseEmitter(60L * 60L * 1000L);
        emitters.computeIfAbsent(userId, key -> new CopyOnWriteArrayList<>()).add(emitter);

        emitter.onCompletion(() -> removeEmitter(userId, emitter));
        emitter.onTimeout(() -> removeEmitter(userId, emitter));
        emitter.onError(error -> removeEmitter(userId, emitter));

        sendAsync(userId, emitter, "connected", Map.of("userId", userId));
        return emitter;
    }

    public void publishMessage(MessageResponse message) {
        sendToUser(message.senderId(), "message", message);
        if (!message.senderId().equals(message.receiverId())) {
            sendToUser(message.receiverId(), "message", message);
        }
    }

    public void publishNotification(Long userId, NotificationResponse notification) {
        sendToUser(userId, "notification", notification);
    }

    @Scheduled(fixedRate = 25_000L)
    public void sendHeartbeat() {
        emitters.forEach((userId, list) -> {
            for (SseEmitter emitter : list) {
                sendAsync(userId, emitter, "heartbeat", Map.of("ts", Instant.now().toString()));
            }
        });
    }

    private void sendToUser(Long userId, String eventName, Object data) {
        CopyOnWriteArrayList<SseEmitter> list = emitters.get(userId);
        if (list == null || list.isEmpty()) return;
        for (SseEmitter emitter : list) {
            sendAsync(userId, emitter, eventName, data);
        }
    }

    private void sendAsync(Long userId, SseEmitter emitter, String eventName, Object data) {
        applicationExecutor.submit(() -> {
            try {
                emitter.send(SseEmitter.event().name(eventName).data(data));
            } catch (IOException e) {
                removeEmitter(userId, emitter);
            }
        });
    }

    private void removeEmitter(Long userId, SseEmitter emitter) {
        CopyOnWriteArrayList<SseEmitter> list = emitters.get(userId);
        if (list != null) {
            list.remove(emitter);
            if (list.isEmpty()) {
                emitters.remove(userId, list);
            }
        }
    }
}
