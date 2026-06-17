package com.jucheonsu.port.domain.project.entity;

import com.jucheonsu.port.domain.project.enums.ProjectWritingStatus;
import com.jucheonsu.port.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "project_writing_sessions")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class ProjectWritingSession extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id", nullable = false, unique = true)
    private Project project;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    @Builder.Default
    private ProjectWritingStatus status = ProjectWritingStatus.NOT_STARTED;

    @Column(length = 50)
    private String role;

    @Column(nullable = false)
    @Builder.Default
    private Integer progress = 0;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String selectedSourcesJson;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String sourceSnapshotJson;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String sectionDraftJson;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String sectionStatusJson;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String documentText;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String reviewedDocument;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String presentationJson;

    @Column(length = 2000)
    private String lastError;

    private LocalDateTime lastSavedAt;

    public void markSelected(String role, String selectedSourcesJson, String sourceSnapshotJson) {
        this.role = role;
        this.selectedSourcesJson = selectedSourcesJson;
        this.sourceSnapshotJson = sourceSnapshotJson;
        this.status = ProjectWritingStatus.WRITING;
        this.lastSavedAt = LocalDateTime.now();
    }

    public void saveDraft(Integer progress, String sectionDraftJson, String sectionStatusJson, String documentText, String reviewedDocument) {
        this.progress = progress == null ? 0 : progress;
        this.sectionDraftJson = sectionDraftJson;
        this.sectionStatusJson = sectionStatusJson;
        if (documentText != null) {
            this.documentText = documentText;
        }
        if (reviewedDocument != null) {
            this.reviewedDocument = reviewedDocument;
        }
        if (reviewedDocument != null && !reviewedDocument.isBlank()) {
            this.status = ProjectWritingStatus.REVIEWED;
        } else if (documentText != null && !documentText.isBlank()) {
            this.status = ProjectWritingStatus.DOCUMENT_CREATED;
        } else {
            this.status = ProjectWritingStatus.WRITING;
        }
        this.lastSavedAt = LocalDateTime.now();
    }

    public void markDocumentCreated(String documentText, Integer progress) {
        this.documentText = documentText;
        this.progress = progress == null ? this.progress : progress;
        this.status = ProjectWritingStatus.DOCUMENT_CREATED;
        this.lastSavedAt = LocalDateTime.now();
    }

    public void markReviewed(String reviewedDocument) {
        this.reviewedDocument = reviewedDocument;
        this.status = ProjectWritingStatus.REVIEWED;
        this.lastSavedAt = LocalDateTime.now();
    }

    public void markPptCreated(String presentationJson) {
        this.presentationJson = presentationJson;
        this.status = ProjectWritingStatus.PPT_CREATED;
        this.lastSavedAt = LocalDateTime.now();
    }

    public void markError(String error) {
        this.lastError = error;
        this.lastSavedAt = LocalDateTime.now();
    }
}
