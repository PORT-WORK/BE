package com.jucheonsu.port.domain.realtime.controller;

import com.jucheonsu.port.domain.realtime.service.RealtimeEventService;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
@RequestMapping("/api/realtime")
@RequiredArgsConstructor
public class RealtimeController {

    private final RealtimeEventService realtimeEventService;

    @GetMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter stream(@AuthenticationPrincipal PrincipalDetails principal) {
        if (principal == null) {
            throw new CustomException(ErrorCode.ACCESS_DENIED);
        }
        return realtimeEventService.connect(principal.getUserId());
    }
}
