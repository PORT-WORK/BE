package com.jucheonsu.port.domain.project.service;

import com.jucheonsu.port.domain.project.dto.PortfolioSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Component
public class SourceNormalizer {

    public PortfolioSource normalize(Map<?, ?> source) {
        String provider = text(source.get("provider"));
        String title = firstNonBlank(text(source.get("title")), text(source.get("kind")), "Untitled source");
        String description = firstNonBlank(text(source.get("summary")), text(source.get("subtitle")), "");
        List<String> tags = stringList(source.get("tags"));
        List<String> links = new ArrayList<>();
        String url = text(source.get("url"));
        if (StringUtils.hasText(url)) {
            links.add(url);
        }
        String imageUrl = text(source.get("imageUrl"));
        if (StringUtils.hasText(imageUrl)) {
            links.add(imageUrl);
        }

        return new PortfolioSource(
                provider,
                title,
                description,
                tags,
                inferFeatures(source, title, description),
                inferTroubleshooting(source, title, description),
                links
        );
    }

    private List<String> inferFeatures(Map<?, ?> source, String title, String description) {
        String kind = text(source.get("kind")).toLowerCase();
        List<String> features = new ArrayList<>();
        if (kind.contains("readme") || kind.contains("repository") || kind.contains("page") || kind.contains("frame")) {
            features.add(firstNonBlank(description, title));
        }
        return features.stream().filter(StringUtils::hasText).toList();
    }

    private List<String> inferTroubleshooting(Map<?, ?> source, String title, String description) {
        String text = (title + " " + description + " " + source).toLowerCase();
        if (text.contains("issue") || text.contains("bug") || text.contains("error") || text.contains("trouble")) {
            return List.of(firstNonBlank(description, title));
        }
        return List.of();
    }

    private List<String> stringList(Object value) {
        if (!(value instanceof List<?> list)) {
            return List.of();
        }
        return list.stream()
                .map(item -> Objects.toString(item, ""))
                .filter(StringUtils::hasText)
                .distinct()
                .toList();
    }

    private String text(Object value) {
        return Objects.toString(value, "").trim();
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (StringUtils.hasText(value)) {
                return value;
            }
        }
        return "";
    }
}
