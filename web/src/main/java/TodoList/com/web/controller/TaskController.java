package TodoList.com.web.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.PriorityService;
import TodoList.com.web.service.TaskService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TaskController {
    public final TaskService taskService;
    private final CategoryService categoryService;
    private final PriorityService priorityService;

    public TaskController(TaskService taskService, CategoryService categoryService, PriorityService priorityService) {
        this.taskService = taskService;
        this.categoryService = categoryService;
        this.priorityService = priorityService;
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

        // Lọc theo ngày hôm nay
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        model.addAttribute("tasks", todayTasks);
        model.addAttribute("status", status); // dùng để active nút lọc
        // System.out.println(status);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("priorities", priorityService.getAllPriorities());
        return "client/home/today";
    }

    @GetMapping("/filterTasks")
    public String filterTasks(@RequestParam(required = false) String keyword,
            @RequestParam(required = false) String categoryId,
            @RequestParam(required = false) String priorityId,
            @RequestParam(required = false) LocalDate date,
            Model model, HttpSession session) {

        Users userCurrent = (Users) session.getAttribute("currentUser");
        int userId = userCurrent.getUserId();

        List<TaskCategoryPriorityDTO> filteredTasks = taskService.filterTasks(userId, keyword, categoryId, priorityId,
                date);
        for (TaskCategoryPriorityDTO task : filteredTasks) {
            System.out.println(task.toString());
        }

        // Lọc theo ngày hôm nay
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = filteredTasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        model.addAttribute("tasks", todayTasks);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("priorities", priorityService.getAllPriorities());

        return "client/home/today"; // hoặc trang hiển thị task
    }

    @PostMapping("/deleteTask")
    public String deleteTask(@RequestParam("taskId") int taskId, HttpServletRequest request) {
        taskService.deleteTask(taskId); // Gọi service để xóa task theo ID

        String ref = request.getHeader("Referer"); // Lấy URL trước đó
        return "redirect:" + ref; // Quay lại trang trước
    }

    @GetMapping("/statusComing")
    public String getComingTasks(@RequestParam(value = "status", defaultValue = "all") String status,
            Model model, HttpSession session) {
        Users userCurrent = (Users) session.getAttribute("currentUser");
        int userId = userCurrent.getUserId();

        List<TaskCategoryPriorityDTO> tasks = taskService.getTasksByStatus(userId, status);

        // Lọc task có ngày lớn hơn hôm nay
        List<TaskCategoryPriorityDTO> upcomingTasks = tasks.stream()
                .filter(task -> task.getDate().toLocalDate().isAfter(LocalDate.now()))
                .collect(Collectors.toList());

        model.addAttribute("tasks", upcomingTasks);
        model.addAttribute("status", status); // dùng để active nút lọc
        // System.out.println(status);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("priorities", priorityService.getAllPriorities());
        return "client/home/upComing";
    }

    @GetMapping("/filterTasksComing")
    public String filterTasksComing(@RequestParam(required = false) String keyword,
            @RequestParam(required = false) String categoryId,
            @RequestParam(required = false) String priorityId,
            @RequestParam(required = false) LocalDate date,
            Model model, HttpSession session) {

        Users userCurrent = (Users) session.getAttribute("currentUser");
        int userId = userCurrent.getUserId();

        List<TaskCategoryPriorityDTO> filteredTasks = taskService.filterTasks(userId, keyword, categoryId, priorityId,
                date);
        for (TaskCategoryPriorityDTO task : filteredTasks) {
            System.out.println(task.toString());
        }

        // Lọc task có ngày lớn hơn hôm nay
        List<TaskCategoryPriorityDTO> upcomingTasks = filteredTasks.stream()
                .filter(task -> task.getDate().toLocalDate().isAfter(LocalDate.now()))
                .collect(Collectors.toList());

        model.addAttribute("tasks", upcomingTasks);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("priorities", priorityService.getAllPriorities());

        return "client/home/upComing"; // hoặc trang hiển thị task
    }
}
