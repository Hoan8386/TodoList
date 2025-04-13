package TodoList.com.web.repository;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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

    public List<TaskCategoryPriorityDTO> filterTasks(int userId, String keyword, String categoryId, String priorityId,
            LocalDate date) {
        StringBuilder sql = new StringBuilder(
                "SELECT t.TaskID, t.UserID, t.Name, t.Description, t.Date, t.Status, " +
                        "c.CategoryID, c.Name AS CategoryName, c.Color, " +
                        "p.PriorityID, p.Name AS PriorityName " +
                        "FROM Task t " +
                        "LEFT JOIN Category c ON t.CategoryID = c.CategoryID " +
                        "LEFT JOIN Priority p ON t.PriorityID = p.PriorityID " +
                        "WHERE t.UserID = ?");

        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (t.Name LIKE ? OR t.Description LIKE ?)");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (categoryId != null && !categoryId.equals("0") && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                sql.append(" AND t.CategoryID = ?");
                params.add(catId);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không hợp lệ
            }
        }

        if (priorityId != null && !priorityId.equals("0") && !priorityId.isEmpty()) {
            try {
                int priId = Integer.parseInt(priorityId);
                sql.append(" AND t.PriorityID = ?");
                params.add(priId);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không hợp lệ
            }
        }

        if (date != null) {
            sql.append(" AND t.Date = ?");
            params.add(java.sql.Date.valueOf(date)); // chuyển LocalDate thành java.sql.Date
        }

        return jdbcTemplate.query(sql.toString(), (rs, rowNum) -> {
            TaskCategoryPriorityDTO dto = new TaskCategoryPriorityDTO();

            dto.setTaskID(rs.getInt("TaskID"));
            dto.setUserID(rs.getInt("UserID"));
            dto.setName(rs.getString("Name"));
            dto.setDescription(rs.getString("Description"));
            dto.setDate(rs.getDate("Date")); // java.sql.Date
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

    public void deleteTaskById(int taskId) {
        String sql = "DELETE FROM task WHERE taskID = ?";
        jdbcTemplate.update(sql, taskId);
    }
}
