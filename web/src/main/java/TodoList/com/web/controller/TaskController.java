package TodoList.com.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.TaskService;
import jakarta.servlet.http.HttpSession;

@Controller
public class TaskController {
    public final TaskService taskService;

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @PostMapping("/checkTask")
    public String checkTask(@RequestParam("taskId") Long taskId,
            @RequestParam(value = "completed", required = false) String completed) {
        boolean isCompleted = (completed != null); // nếu có nghĩa là checked

        taskService.updateTaskStatus(taskId, isCompleted); // Bạn viết phương thức này trong service

        return "redirect:/today";
    }

    @GetMapping("/status")
    public String getTodayTasks(@RequestParam(value = "status", defaultValue = "all") String status,
            Model model, HttpSession session) {
        Users userCurrent = (Users) session.getAttribute("currentUser");
        int userId = userCurrent.getUserId();

        List<TaskCategoryPriorityDTO> tasks = taskService.getTasksByStatus(userId, status);
        model.addAttribute("tasks", tasks);
        model.addAttribute("status", status); // dùng để active nút lọc
        System.out.println(status);
        return "client/home/today";
    }

}
