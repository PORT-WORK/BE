package com.jucheonsu.port.domain.user.converter;

import com.jucheonsu.port.domain.user.dto.response.EducationResponse;
import com.jucheonsu.port.domain.user.entity.Education;

public final class EducationConverter {

    private EducationConverter() {
    }

    public static EducationResponse toResponse(Education education) {
        return new EducationResponse(
                education.getId(),
                education.getSchoolName(),
                education.getMajor(),
                education.getStartYear(),
                education.getEndYear(),
                education.getIsAttending()
        );
    }
}
