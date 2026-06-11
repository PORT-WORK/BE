package com.jucheonsu.port.domain.realtime.controller;

import com.jucheonsu.port.domain.realtime.service.RealtimeEventService;
import com.jucheonsu.port.global.exception.CustomException;
import com.jucheonsu.port.global.exception.ErrorCode;
import com.jucheonsu.port.global.security.principal.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
@RequestMapping("/api/realtime")
@RequiredArgsConstructor
public class RealtimeController {

    private final RealtimeEventService realtimeEventService;

    @GetMapping("/stream")
    public SseEmitter stream(Authentication authentication, @RequestParam(required = false) Long userId) {
        if (!(authentication != null && authentication.getPrincipal() instanceof PrincipalDetails principal)) {
            throw new CustomException(ErrorCode.ACCESS_DENIED);
        }
        if (userId != null && !userId.equals(principal.getUserId())) {
            throw new CustomException(ErrorCode.ACCESS_DENIED);
        }
        return realtimeEventService.connect(principal.getUserId());
    }
}
