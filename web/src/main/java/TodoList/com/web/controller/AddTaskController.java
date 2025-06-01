package TodoList.com.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import TodoList.com.web.model.Task;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.TaskService;
import jakarta.servlet.http.HttpSession;

@Controller
public class AddTaskController {

    private TaskService taskService;
    private CategoryService categoryService;

    public AddTaskController(TaskService taskService, CategoryService categoryService) {
        this.taskService = taskService;
        this.categoryService = categoryService;
    }

    @RequestMapping("/addTask")
    public String AddTaskPage(Model model) {
        // Load danh sách Category từ service và truyền vào view
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("task", new Task());
        return "client/home/addTask";
    }

    @PostMapping("/addTask")
    public String addTask(@ModelAttribute Task task, Model model, HttpSession session) {
        // Lưu task vào cơ sở dữ liệu thông qua service
        Task newTask = new Task();
        // Gán các trường từ task vào newTask
        Users currentUser = (Users) session.getAttribute("currentUser");
        newTask.setUserID(currentUser.getUserId());
        newTask.setName(task.getName()); // Gán tiêu đề
        newTask.setDescription(task.getDescription()); // Gán mô tả
        newTask.setDate(task.getDate()); // Gán ngày hết hạn
        newTask.setCategoryID(task.getCategoryID()); // Gán ID danh mục
        newTask.setPriorityID(task.getPriorityID()); // Gán ID mức độ ưu tiên

        taskService.saveTask(newTask);

        // Đưa thông tin task mới vào view, có thể hiển thị thông báo thành công
        model.addAttribute("message", "Task added successfully!");
        return "redirect:/today"; // Chuyển hướng đến trang danh sách task sau khi thêm thành công
    }

    @PostMapping("/updateTask")
    public String updateTask(@ModelAttribute Task task, HttpSession session) {
        Users currentUser = (Users) session.getAttribute("currentUser");
        Task existingTask = taskService.getTaskById(task.getTaskID());

        if (existingTask != null && existingTask.getUserID() == currentUser.getUserId()) {
            existingTask.setName(task.getName());
            existingTask.setDescription(task.getDescription());
            existingTask.setDate(task.getDate());
            existingTask.setCategoryID(task.getCategoryID());
            existingTask.setPriorityID(task.getPriorityID());
            boolean updated = taskService.updateTask(existingTask);
            if (updated) {
                return "redirect:/today"; // Redirect to the main page on success
            }
        }
        return "redirect:/?error=updateFailed"; // Redirect with error on failure
    }

}
