package com.jucheonsu.port.global.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "사용자를 찾을 수 없습니다."),
    OAUTH_CONNECTION_NOT_FOUND(HttpStatus.NOT_FOUND, "OAuth 연동 정보를 찾을 수 없습니다."),
    USER_LINK_NOT_FOUND(HttpStatus.NOT_FOUND, "사용자 링크를 찾을 수 없습니다."),
    EDUCATION_NOT_FOUND(HttpStatus.NOT_FOUND, "학력 정보를 찾을 수 없습니다."),
    WORK_EXPERIENCE_NOT_FOUND(HttpStatus.NOT_FOUND, "경력 정보를 찾을 수 없습니다."),
    PORTFOLIO_NOT_FOUND(HttpStatus.NOT_FOUND, "포트폴리오를 찾을 수 없습니다."),
    PROJECT_NOT_FOUND(HttpStatus.NOT_FOUND, "프로젝트를 찾을 수 없습니다."),
    DOCUMENT_NOT_FOUND(HttpStatus.NOT_FOUND, "문서를 찾을 수 없습니다."),
    BLOCK_NOT_FOUND(HttpStatus.NOT_FOUND, "블록을 찾을 수 없습니다."),
    WORKSPACE_NOT_FOUND(HttpStatus.NOT_FOUND, "AI 워크스페이스를 찾을 수 없습니다."),
    MESSAGE_NOT_FOUND(HttpStatus.NOT_FOUND, "메시지를 찾을 수 없습니다."),
    NOTIFICATION_NOT_FOUND(HttpStatus.NOT_FOUND, "알림을 찾을 수 없습니다."),
    ANALYTICS_NOT_FOUND(HttpStatus.NOT_FOUND, "통계 정보를 찾을 수 없습니다."),
    DUPLICATE_REACTION(HttpStatus.CONFLICT, "이미 처리된 반응입니다."),
    ACCESS_DENIED(HttpStatus.FORBIDDEN, "접근 권한이 없습니다."),
    INVALID_REQUEST(HttpStatus.BAD_REQUEST, "잘못된 요청입니다.");

    private final HttpStatus status;
    private final String message;

    ErrorCode(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }
}
