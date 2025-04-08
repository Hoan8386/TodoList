package TodoList.com.web.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import TodoList.com.web.model.Category;

@Service
public class CategoryService {

    private JdbcTemplate jdbcTemplate;

    // Constructor injection
    public CategoryService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM category";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Category category = new Category(); // Dùng constructor mặc định
            category.setCategoryID(rs.getInt("CategoryID"));
            category.setName(rs.getString("Name"));
            category.setColor(rs.getString("Color"));
            return category;
        });
    }

    public void createCategory(Category category) {
        String sql = "INSERT INTO Category (Name, Color) VALUES (?, ?)";
        jdbcTemplate.update(sql, category.getName(), category.getColor());
    }

    // ✅ Hàm xóa category theo ID
    public void deleteById(int id) {
        String sql = "DELETE FROM Category WHERE CategoryID = ?";
        jdbcTemplate.update(sql, id);
    }
}
