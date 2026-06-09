package com.jucheonsu.port.global.util;

import java.util.UUID;

public final class FileNameUtil {

    private FileNameUtil() {
    }

    public static String createUniqueFileName(String originalFileName) {
        String extension = extractExtension(originalFileName);
        return UUID.randomUUID() + extension;
    }

    private static String extractExtension(String originalFileName) {
        if (originalFileName == null || !originalFileName.contains(".")) {
            return "";
        }
        return originalFileName.substring(originalFileName.lastIndexOf("."));
    }
}
