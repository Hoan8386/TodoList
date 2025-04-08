package TodoList.com.web.repository;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import TodoList.com.web.model.Users;

import java.util.List;

@Repository
public class UserRepository {
    private final JdbcTemplate jdbcTemplate;

    public UserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Thêm user mới
    public int addUser(Users users) {
        String sql = "INSERT INTO User (Username, Email, PasswordHash) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, users.getUserName(), users.getEmail(), users.getPasswordHash());
    }

    // // Lấy danh sách user
    // public List<Users> getAllUsers() {
    // String sql = "SELECT * FROM Users";
    // return jdbcTemplate.query(sql, userRowMapper);
    // }

    // // Lấy user theo email
    // public Users getUserByEmail(String email) {
    // String sql = "SELECT * FROM Users WHERE Email = ?";
    // return jdbcTemplate.queryForObject(sql, userRowMapper, email);
    // }

    // // Xóa user theo ID
    // public int deleteUser(int userId) {
    // String sql = "DELETE FROM Users WHERE UserID = ?";
    // return jdbcTemplate.update(sql, userId);
    // }

    // Mapper ánh xạ dữ liệu từ SQL sang Java Object
    // private final RowMapper<Users> userRowMapper = (rs, rowNum) -> {
    // Users user = new Users();
    // user.setUserId(rs.getInt("UserID"));
    // user.setFullName(rs.getString("FullName"));
    // user.setEmail(rs.getString("Email"));
    // user.setPasswordHash(rs.getString("PasswordHash"));
    // return user;
    // };

    public boolean checkEmail(String email) {
        String sql = "SELECT COUNT(*) FROM user WHERE Email = ?";

        // Sử dụng JdbcTemplate để thực hiện truy vấn và kiểm tra số lượng email trong
        // database
        int count = jdbcTemplate.queryForObject(sql, new Object[] { email }, Integer.class);

        // Nếu count > 0, email đã tồn tại
        if (count > 0) {
            return true;
        }
        return false;
    }

    public Users findByEmail(String email) {
        String sql = "SELECT * FROM User WHERE Email = ?";
        try {
            return jdbcTemplate.queryForObject(
                    sql,
                    new Object[] { email },
                    new BeanPropertyRowMapper<>(Users.class));
        } catch (EmptyResultDataAccessException e) {
            // Không tìm thấy người dùng
            return null;
        } catch (DataAccessException e) {
            // Các lỗi khác như sai tên bảng, lỗi kết nối...
            e.printStackTrace(); // Log lỗi để kiểm tra
            return null;
        }
    }

}
