package com.jucheonsu.port.domain.user.converter;

import com.jucheonsu.port.domain.user.dto.response.WorkExperienceResponse;
import com.jucheonsu.port.domain.user.entity.WorkExperience;

public final class WorkExperienceConverter {

    private WorkExperienceConverter() {
    }

    public static WorkExperienceResponse toResponse(WorkExperience workExperience) {
        return new WorkExperienceResponse(
                workExperience.getId(),
                workExperience.getCompanyName(),
                workExperience.getRole(),
                workExperience.getDescription(),
                workExperience.getStartDate(),
                workExperience.getEndDate(),
                workExperience.getIsCurrent()
        );
    }
}
