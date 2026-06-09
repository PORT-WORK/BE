package com.jucheonsu.port.domain.project.service;
import com.jucheonsu.port.domain.project.dto.request.*;import com.jucheonsu.port.domain.project.dto.response.ProjectResponse;import java.util.List;
public interface ProjectService{List<ProjectResponse> getProjects(Long portfolioId);ProjectResponse create(Long portfolioId,ProjectCreateRequest request);ProjectResponse update(Long portfolioId,Long projectId,ProjectUpdateRequest request);void delete(Long portfolioId,Long projectId);void updateOrders(Long portfolioId,List<ProjectOrderRequest> requests);}
