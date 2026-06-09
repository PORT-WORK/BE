package com.jucheonsu.port.domain.ai.dto.response;

import com.jucheonsu.port.domain.block.dto.response.BlockResponse;
import com.jucheonsu.port.domain.document.dto.response.DocumentResponse;
import com.jucheonsu.port.domain.portfolio.dto.response.PortfolioResponse;
import com.jucheonsu.port.domain.project.dto.response.ProjectResponse;

import java.util.List;

public record PortfolioDataResponse(
        PortfolioResponse portfolio,
        List<ProjectData> projects
) {
    public record ProjectData(
            ProjectResponse project,
            List<DocumentData> documents
    ) {
    }

    public record DocumentData(
            DocumentResponse document,
            List<BlockResponse> blocks
    ) {
    }
}
