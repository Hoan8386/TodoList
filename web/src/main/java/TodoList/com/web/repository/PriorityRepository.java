package TodoList.com.web.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import TodoList.com.web.model.Priority;

import java.util.List;

@Repository
public class PriorityRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Priority> findAll() {
        String sql = "SELECT * FROM Priority";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Priority p = new Priority();
            p.setPriorityID(rs.getInt("PriorityID"));
            p.setName(rs.getString("Name"));
            return p;
        });
    }
}
