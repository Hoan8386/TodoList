package TodoList.com.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
public class DatabaseConfig {

    private static DataSource staticDataSource;

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/todolist?useSSL=false&serverTimezone=UTC");
        dataSource.setUsername("root");
        dataSource.setPassword("123456");

        // Lưu tham chiếu tĩnh
        staticDataSource = dataSource;

        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    /**
     * Cung cấp access đến DataSource bên ngoài Spring context
     * Được sử dụng bởi CategoryService khi được khởi tạo từ Servlet
     */
    public static DataSource getDataSource() {
        if (staticDataSource == null) {
            // Nếu chưa được khởi tạo thông qua Spring, tạo mới một instance
            DriverManagerDataSource dataSource = new DriverManagerDataSource();
            dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
            dataSource.setUrl("jdbc:mysql://localhost:3306/todolist?useSSL=false&serverTimezone=UTC");
            dataSource.setUsername("root");
            dataSource.setPassword("123456");
            return dataSource;
        }
        return staticDataSource;
    }
}
