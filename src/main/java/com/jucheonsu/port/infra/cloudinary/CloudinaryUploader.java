package com.jucheonsu.port.infra.cloudinary;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CloudinaryUploader {

    private final Cloudinary cloudinary;

    @Value("${cloudinary.folder:port}")
    private String folder;

    public FileUploadResponse upload(MultipartFile file, String directory) {
        if (!StringUtils.hasText(folder)) {
            throw new UnsupportedOperationException("Cloudinary folder is not configured.");
        }

        String originalName = StringUtils.cleanPath(file.getOriginalFilename() == null ? "file" : file.getOriginalFilename());
        String publicId = buildPublicId(directory, originalName);

        try {
            Map<?, ?> result = cloudinary.uploader().upload(
                    file.getBytes(),
                    ObjectUtils.asMap(
                            "folder", folder + "/" + normalizeDirectory(directory),
                            "public_id", publicId,
                            "resource_type", "auto",
                            "overwrite", true
                    )
            );

            String secureUrl = result.get("secure_url") == null ? null : result.get("secure_url").toString();
            String returnedPublicId = result.get("public_id") == null ? publicId : result.get("public_id").toString();
            return new FileUploadResponse(secureUrl, returnedPublicId);
        } catch (IOException e) {
            throw new IllegalStateException("Failed to upload file to Cloudinary.", e);
        }
    }

    private String buildPublicId(String directory, String originalName) {
        String suffix = UUID.randomUUID().toString().replace("-", "");
        return suffix + "-" + originalName;
    }

    private String normalizeDirectory(String directory) {
        if (!StringUtils.hasText(directory)) {
            return "uploads";
        }
        return directory.replace("\\", "/").replaceAll("^/+", "").replaceAll("/+$", "");
    }
}
