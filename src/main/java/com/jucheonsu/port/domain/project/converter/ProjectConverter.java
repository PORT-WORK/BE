package com.jucheonsu.port.domain.project.converter;

import com.jucheonsu.port.domain.project.dto.response.ProjectResponse;
import com.jucheonsu.port.domain.project.entity.Project;

public final class ProjectConverter {

    private ProjectConverter() {
    }

    public static ProjectResponse toResponse(Project project) {
        return new ProjectResponse(
                project.getId(),
                project.getPortfolio().getId(),
                project.getName(),
                project.getRole(),
                project.getSummary(),
                project.getThumbnailUrl(),
                project.getSkills(),
                project.getIsSynced(),
                project.getStartDate(),
                project.getEndDate(),
                project.getOrderIndex()
        );
    }
}
