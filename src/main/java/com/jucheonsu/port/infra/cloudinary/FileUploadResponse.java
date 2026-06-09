package com.jucheonsu.port.infra.cloudinary;

public record FileUploadResponse(
        String url,
        String fileName
) {
}
