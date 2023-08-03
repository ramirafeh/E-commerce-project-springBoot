import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.TestPropertySource;

import java.util.Set;
import java.util.stream.Collectors;

import static org.assertj.core.api.Assertions.assertThat;

@JdbcTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@TestPropertySource(locations = "classpath:test.properties")
public class purchase_test {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    public void testPurchasesTableDefinition() {
        // Verify that the purchases table exists
        String tableName = "purchases";
        boolean purchasesTableExists = jdbcTemplate.queryForObject(
                "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ?)",
                Boolean.class, tableName);
        assertThat(purchasesTableExists).isTrue();

        // Verify that the primary key consists of purchase_id, user_id, and product_id
        Set<String> primaryKeyColumnNames = jdbcTemplate.queryForList(
                        "SELECT column_name FROM information_schema.key_column_usage " +
                                "WHERE constraint_name = 'PRIMARY' AND table_name = ?",
                        String.class, tableName).stream()
                .collect(Collectors.toSet());
        assertThat(primaryKeyColumnNames).containsExactlyInAnyOrder("purchase_id", "user_id", "product_id");
    }
}
