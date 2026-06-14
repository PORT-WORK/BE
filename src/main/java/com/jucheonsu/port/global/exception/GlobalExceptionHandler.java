package com.jucheonsu.port.global.exception;

import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException e, HttpServletRequest request) {
        if (isSseRequest(request)) {
            return ResponseEntity.status(e.getErrorCode().getStatus()).contentType(MediaType.TEXT_EVENT_STREAM).build();
        }
        return ResponseEntity
                .status(e.getErrorCode().getStatus())
                .contentType(MediaType.APPLICATION_JSON)
                .body(ApiResponse.error(e.getMessage()));
    }

    @ExceptionHandler({AccessDeniedException.class, AuthorizationDeniedException.class})
    public ResponseEntity<?> handleAccessDenied(Exception e, HttpServletRequest request) {
        if (isSseRequest(request)) {
            return ResponseEntity.status(403).contentType(MediaType.TEXT_EVENT_STREAM).build();
        }
        return ResponseEntity
                .status(403)
                .contentType(MediaType.APPLICATION_JSON)
                .body(ApiResponse.error("접근 권한이 없습니다."));
    }

    @ExceptionHandler({MethodArgumentNotValidException.class, BindException.class})
    public ResponseEntity<ApiResponse<Void>> handleValidationException(Exception e) {
        return ResponseEntity
                .badRequest()
                .contentType(MediaType.APPLICATION_JSON)
                .body(ApiResponse.error("요청 값 검증에 실패했습니다."));
    }

    @ExceptionHandler(HttpMediaTypeNotAcceptableException.class)
    public ResponseEntity<?> handleNotAcceptable(HttpMediaTypeNotAcceptableException e, HttpServletRequest request) {
        if (isSseRequest(request)) {
            return ResponseEntity.status(406).contentType(MediaType.TEXT_EVENT_STREAM).build();
        }
        return ResponseEntity
                .status(406)
                .contentType(MediaType.APPLICATION_JSON)
                .body(ApiResponse.error("JSON response is required."));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception e, HttpServletRequest request) {
        if (isSseRequest(request)) {
            return ResponseEntity.internalServerError().contentType(MediaType.TEXT_EVENT_STREAM).build();
        }
        return ResponseEntity
                .internalServerError()
                .contentType(MediaType.APPLICATION_JSON)
                .body(ApiResponse.error("서버 내부 오류가 발생했습니다."));
    }

    private boolean isSseRequest(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        String uri = request.getRequestURI();
        return (accept != null && accept.contains(MediaType.TEXT_EVENT_STREAM_VALUE))
                || (uri != null && uri.startsWith("/api/realtime/stream"));
    }
}
