package com.jucheonsu.port.domain.project.service;

import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSaveRequest;
import com.jucheonsu.port.domain.project.dto.request.ProjectWritingSelectionRequest;
import com.jucheonsu.port.domain.project.dto.response.ProjectWritingSessionResponse;

public interface ProjectWritingService {
    ProjectWritingSessionResponse getSession(Long projectId);

    ProjectWritingSessionResponse selectSources(Long projectId, ProjectWritingSelectionRequest request);

    ProjectWritingSessionResponse saveDraft(Long projectId, ProjectWritingSaveRequest request);

    ProjectWritingSessionResponse createDocument(Long projectId);

    ProjectWritingSessionResponse reviewDocument(Long projectId);

    ProjectWritingSessionResponse createPresentation(Long projectId);

    byte[] exportPptx(Long projectId);
}
