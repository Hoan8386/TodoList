package TodoList.com.web.service;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.repository.TaskRepository;

import java.util.List;

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
}