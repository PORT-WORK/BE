package com.jucheonsu.port.global.response;

public record ApiResponse<T>(
        boolean success,
        String message,
        T data
) {
    public static <T> ApiResponse<T> ok(T data) {
        return new ApiResponse<>(true, "요청이 성공했습니다.", data);
    }

    public static ApiResponse<Void> ok() {
        return new ApiResponse<>(true, "요청이 성공했습니다.", null);
    }

    public static ApiResponse<Void> error(String message) {
        return new ApiResponse<>(false, message, null);
    }
}
