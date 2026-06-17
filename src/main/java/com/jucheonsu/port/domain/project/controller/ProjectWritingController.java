package com.jucheonsu.port.domain.project.controller;

import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSaveRequest;
import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSelectionRequest;
import com.jucheonsu.port.domain.project.dto.response.ProjectWritingSessionResponse;
import com.jucheonsu.port.domain.project.service.ProjectWritingService;
import com.jucheonsu.port.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api/projects/{projectId}/writing")
@RequiredArgsConstructor
public class ProjectWritingController {

    private final ProjectWritingService projectWritingService;

    @GetMapping("/session")
    public ApiResponse<ProjectWritingSessionResponse> getSession(@PathVariable Long projectId) {
        return ApiResponse.ok(projectWritingService.getSession(projectId));
    }

    @GetMapping("/resume")
    public ApiResponse<ProjectWritingSessionResponse> resume(@PathVariable Long projectId) {
        return ApiResponse.ok(projectWritingService.getSession(projectId));
    }

    @PostMapping("/sources")
    public ApiResponse<ProjectWritingSessionResponse> selectSources(
            @PathVariable Long projectId,
            @Valid @RequestBody ProjectWritingSelectionRequest request
    ) {
        return ApiResponse.ok(projectWritingService.selectSources(projectId, request));
    }

    @PutMapping("/draft")
    public ApiResponse<ProjectWritingSessionResponse> saveDraft(
            @PathVariable Long projectId,
            @RequestBody ProjectWritingSaveRequest request
    ) {
        return ApiResponse.ok(projectWritingService.saveDraft(projectId, request));
    }

    @PostMapping("/document")
    public ApiResponse<ProjectWritingSessionResponse> createDocument(@PathVariable Long projectId) {
        return ApiResponse.ok(projectWritingService.createDocument(projectId));
    }

    @PostMapping("/review")
    public ApiResponse<ProjectWritingSessionResponse> reviewDocument(@PathVariable Long projectId) {
        return ApiResponse.ok(projectWritingService.reviewDocument(projectId));
    }

    @PostMapping("/presentation")
    public ApiResponse<ProjectWritingSessionResponse> createPresentation(@PathVariable Long projectId) {
        return ApiResponse.ok(projectWritingService.createPresentation(projectId));
    }

    @GetMapping({"/export/pptx", "/export/pdf"})
    public ResponseEntity<byte[]> exportPptx(@PathVariable Long projectId) {
        byte[] bytes = projectWritingService.exportPptx(projectId);
        ContentDisposition disposition = ContentDisposition.attachment()
                .filename("project-" + projectId + ".pdf", StandardCharsets.UTF_8)
                .build();
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, disposition.toString())
                .contentType(MediaType.APPLICATION_PDF)
                .body(bytes);
    }
}
