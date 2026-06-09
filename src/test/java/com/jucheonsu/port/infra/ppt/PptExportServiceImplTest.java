package com.jucheonsu.port.infra.ppt;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class PptExportServiceImplTest {

    @Test
    void exportPortfolio_success() {
        PptExportService service = new PptExportServiceImpl();

        byte[] result = service.exportPortfolio(1L, "{\"slides\":[]}");

        assertThat(result).isNotEmpty();
        assertThat(result[0]).isEqualTo((byte) 'P');
        assertThat(result[1]).isEqualTo((byte) 'K');
    }
}
