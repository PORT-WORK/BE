package com.jucheonsu.port.domain.portfolio.repository;

import com.jucheonsu.port.domain.portfolio.entity.Portfolio;
import com.jucheonsu.port.domain.user.entity.User;
import com.jucheonsu.port.domain.user.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@ActiveProfiles("test")
class PortfolioRepositoryTest {

    @Autowired
    PortfolioRepository portfolioRepository;

    @Autowired
    UserRepository userRepository;

    @Test
    void searchPublicPortfolios_withJpql_success() {
        User user = userRepository.save(User.builder()
                .email("test@test.com")
                .name("tester")
                .build());

        portfolioRepository.save(Portfolio.builder()
                .user(user)
                .title("Backend Portfolio")
                .jobRole("Backend Developer")
                .skills("Java,Spring")
                .templateId("default")
                .isPublic(true)
                .build());

        var result = portfolioRepository.searchPublicPortfolios("Backend", "Spring", PageRequest.of(0, 10));
        assertThat(result.getTotalElements()).isEqualTo(1);
    }
}
