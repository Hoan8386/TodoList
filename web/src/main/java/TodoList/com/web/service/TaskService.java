package TodoList.com.web.service;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.repository.TaskRepository;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TaskService {

    private final TaskRepository taskRepository;

    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    // Phương thức lưu Task vào cơ sở dữ liệu
    public void saveTask(Task task) {
        taskRepository.save(task); // Lưu task vào cơ sở dữ liệu
    }

    public List<TaskCategoryPriorityDTO> getAllTaskWithCategoryPriorityByUser(int userId) {
        return taskRepository.getAllTaskWithCategoryPriorityByUser(userId);
    }

    public List<TaskCategoryPriorityDTO> filterTasks(
            int userId,
            String keyword,
            String category,
            String priority,
            String sort,
            String status) {
        return taskRepository.filterTasks(userId, keyword, category, priority, sort, status);
    }

    public boolean updateTaskStatus(Long taskId, boolean isCompleted) {
        return taskRepository.updateStatus(taskId, isCompleted);
    }

    public List<TaskCategoryPriorityDTO> getTasksByStatus(int userId, String status) {
        if ("1".equals(status)) {
            return taskRepository.getTasksByStatus(userId, 1); // completed
        } else if ("0".equals(status)) {
            return taskRepository.getTasksByStatus(userId, 0); // pending
        } else {
            return taskRepository.getAllTaskWithCategoryPriorityByUser(userId); // all
        }
    }

}