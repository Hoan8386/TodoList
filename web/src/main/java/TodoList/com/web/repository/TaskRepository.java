package TodoList.com.web.repository;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TaskRepository {

    private final JdbcTemplate jdbcTemplate;

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
        String sql = "SELECT t.TaskID, t.UserID, t.Name, t.Description, t.Date, t.Status, " +
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
            dto.setStatus(rs.getBoolean("Status")); // <-- Thêm dòng này

            dto.setCategoryID(rs.getInt("CategoryID"));
            dto.setCategoryName(rs.getString("CategoryName"));
            dto.setCategoryColor(rs.getString("Color"));

            dto.setPriorityID(rs.getInt("PriorityID"));
            dto.setPriorityName(rs.getString("PriorityName"));

            return dto;
        }, userId);
    }

    public List<TaskCategoryPriorityDTO> filterTasks(
            int userId,
            String keyword,
            String category,
            String priority,
            String sort,
            String status) {
        StringBuilder sql = new StringBuilder("SELECT t.TaskID, t.UserID, t.Name, t.Description, t.Date, t.Status, " +
                "c.CategoryID, c.Name AS CategoryName, c.Color, " +
                "p.PriorityID, p.Name AS PriorityName " +
                "FROM Task t " +
                "LEFT JOIN Category c ON t.CategoryID = c.CategoryID " +
                "LEFT JOIN Priority p ON t.PriorityID = p.PriorityID " +
                "WHERE t.UserID = ?");
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND LOWER(t.Name) LIKE ?");
            params.add("%" + keyword.toLowerCase() + "%");
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND LOWER(c.Name) = ?");
            params.add(category.toLowerCase());
        }

        if (priority != null && !priority.isEmpty()) {
            sql.append(" AND LOWER(p.Name) = ?");
            params.add(priority.toLowerCase());
        }

        if (status != null && !status.isEmpty()) {
            if (status.equalsIgnoreCase("completed")) {
                sql.append(" AND t.Status = true");
            } else if (status.equalsIgnoreCase("pending")) {
                sql.append(" AND t.Status = false");
            }
        }

        if (sort != null && sort.equalsIgnoreCase("priority")) {
            sql.append(" ORDER BY CASE LOWER(p.Name) " +
                    "WHEN 'high' THEN 1 " +
                    "WHEN 'medium' THEN 2 " +
                    "WHEN 'low' THEN 3 " +
                    "ELSE 4 END");
        }

        return jdbcTemplate.query(sql.toString(), (rs, rowNum) -> {
            TaskCategoryPriorityDTO dto = new TaskCategoryPriorityDTO();
            dto.setTaskID(rs.getInt("TaskID"));
            dto.setUserID(rs.getInt("UserID"));
            dto.setName(rs.getString("Name"));
            dto.setDescription(rs.getString("Description"));
            dto.setDate(rs.getDate("Date"));
            dto.setStatus(rs.getBoolean("Status"));

            dto.setCategoryID(rs.getInt("CategoryID"));
            dto.setCategoryName(rs.getString("CategoryName"));
            dto.setCategoryColor(rs.getString("Color"));

            dto.setPriorityID(rs.getInt("PriorityID"));
            dto.setPriorityName(rs.getString("PriorityName"));

            return dto;
        }, params.toArray());

    }

    public boolean updateStatus(Long taskId, boolean isCompleted) {
        String sql = "UPDATE Task SET Status = ? WHERE TaskID = ?";
        int rows = jdbcTemplate.update(sql, isCompleted, taskId);
        return rows > 0;
    }

    public List<TaskCategoryPriorityDTO> getTasksByStatus(int userId, int status) {
        String sql = "SELECT t.TaskID, t.UserID, t.Name, t.Description, t.Date, t.Status, " +
                "c.CategoryID, c.Name AS CategoryName, c.Color, " +
                "p.PriorityID, p.Name AS PriorityName " +
                "FROM Task t " +
                "LEFT JOIN Category c ON t.CategoryID = c.CategoryID " +
                "LEFT JOIN Priority p ON t.PriorityID = p.PriorityID " +
                "WHERE t.UserID = ? AND t.Status = ?";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            TaskCategoryPriorityDTO dto = new TaskCategoryPriorityDTO();

            dto.setTaskID(rs.getInt("TaskID"));
            dto.setUserID(rs.getInt("UserID"));
            dto.setName(rs.getString("Name"));
            dto.setDescription(rs.getString("Description"));
            dto.setDate(rs.getDate("Date"));
            dto.setStatus(rs.getInt("Status") == 1);

            dto.setCategoryID(rs.getInt("CategoryID"));
            dto.setCategoryName(rs.getString("CategoryName"));
            dto.setCategoryColor(rs.getString("Color"));

            dto.setPriorityID(rs.getInt("PriorityID"));
            dto.setPriorityName(rs.getString("PriorityName"));

            return dto;
        }, userId, status);
    }

}
