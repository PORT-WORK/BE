package com.jucheonsu.port.global.util;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseCookie;

public final class CookieUtil {

    private CookieUtil() {
    }

    public static void addHttpOnlyCookie(HttpServletResponse response, String name, String value, long maxAgeSeconds) {
        addHttpOnlyCookie(response, name, value, maxAgeSeconds, false);
    }

    public static void addHttpOnlyCookie(HttpServletResponse response, String name, String value, long maxAgeSeconds, boolean secure) {
        ResponseCookie cookie = ResponseCookie.from(name, value)
                .httpOnly(true)
                .secure(secure)
                .sameSite(secure ? "None" : "Lax")
                .path("/")
                .maxAge(maxAgeSeconds)
                .build();
        response.addHeader("Set-Cookie", cookie.toString());
    }

    public static void expireCookie(HttpServletResponse response, String name) {
        expireCookie(response, name, false);
    }

    public static void expireCookie(HttpServletResponse response, String name, boolean secure) {
        ResponseCookie cookie = ResponseCookie.from(name, "")
                .httpOnly(true)
                .secure(secure)
                .sameSite(secure ? "None" : "Lax")
                .path("/")
                .maxAge(0)
                .build();
        response.addHeader("Set-Cookie", cookie.toString());
    }
}
