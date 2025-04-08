package TodoList.com.web.repository;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TaskRepository {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public TaskRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Phương thức lưu Task vào cơ sở dữ liệu
    // Phương thức lưu Task vào cơ sở dữ liệu
    public void save(Task task) {
        String sql = "INSERT INTO Task (UserID, Name, Description, CategoryID, PriorityID, Date) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        // Sử dụng JdbcTemplate để thực hiện câu lệnh SQL
        jdbcTemplate.update(sql, task.getUserID(), task.getName(), task.getDescription(),
                task.getCategoryID(), task.getPriorityID(), task.getDate());
    }

    public List<Task> getAllTaskByIdUser(int userId) {
        String sql = "SELECT * FROM Task WHERE UserID = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Task.class), userId);
    }

    // Lấy danh sách task kèm category và priority theo userID
    public List<TaskCategoryPriorityDTO> getAllTaskWithCategoryPriorityByUser(int userId) {
        String sql = "SELECT t.TaskID, t.UserID, t.Name, t.Description, t.Date, " +
                "c.CategoryID, c.Name AS CategoryName, c.Color, " +
                "p.PriorityID, p.Name AS PriorityName " +
                "FROM Task t " +
                "LEFT JOIN Category c ON t.CategoryID = c.CategoryID " +
                "LEFT JOIN Priority p ON t.PriorityID = p.PriorityID " +
                "WHERE t.UserID = ?";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            TaskCategoryPriorityDTO dto = new TaskCategoryPriorityDTO();

            dto.setTaskID(rs.getInt("TaskID"));
            dto.setUserID(rs.getInt("UserID"));
            dto.setName(rs.getString("Name"));
            dto.setDescription(rs.getString("Description"));
            dto.setDate(rs.getDate("Date"));

            dto.setCategoryID(rs.getInt("CategoryID"));
            dto.setCategoryName(rs.getString("CategoryName"));
            dto.setCategoryColor(rs.getString("Color"));

            dto.setPriorityID(rs.getInt("PriorityID"));
            dto.setPriorityName(rs.getString("PriorityName"));

            return dto;
        }, userId); // Truyền tham số đúng cách
        // Truyền tham số dưới dạng Object array

    }

}
