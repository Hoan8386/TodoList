package TodoList.com.web.controller;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import TodoList.com.web.model.Category;
import TodoList.com.web.model.Priority;
import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.PriorityService;
import TodoList.com.web.service.TaskService;
import TodoList.com.web.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final TaskService taskService;
    private final CategoryService categoryService;
    private final PriorityService priorityService;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, TaskService taskService,
            CategoryService categoryService, PriorityService priorityService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.taskService = taskService;
        this.categoryService = categoryService;
        this.priorityService = priorityService;
    }

    @RequestMapping("/")
    public String HomePage(Model model, HttpSession session) {
        model.addAttribute("user", new Users());
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "client/auth/login";
        }

        List<TaskCategoryPriorityDTO> lsTasks = taskService
                .getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // Lọc theo ngày hôm nay
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = lsTasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .sorted(Comparator.comparing(TaskCategoryPriorityDTO::getPriorityID).reversed()) // Sắp xếp giảm dần
                                                                                                 // theo priority
                .collect(Collectors.toList());

        // Tính tổng số lượng
        long totalTasks = lsTasks.size();
        long completedTasks = lsTasks.stream().filter(t -> t.isStatus()).count(); // Status = true => completed
        long pendingTasks = lsTasks.stream().filter(t -> !t.isStatus()).count(); // Status = false => pending
        long urgentTasks = lsTasks.stream().filter(t -> t.getPriorityID() == 4).count(); // Urgent priority = 4

        model.addAttribute("user", currentUser);
        model.addAttribute("tasks", todayTasks);

        for (TaskCategoryPriorityDTO taskCategoryPriorityDTO : todayTasks) {
            System.out.println(taskCategoryPriorityDTO.toString());
        }

        // Tính task hôm nay đã hoàn thành và chưa hoàn thành
        long completedToday = todayTasks.stream().filter(TaskCategoryPriorityDTO::isStatus).count();
        long pendingToday = todayTasks.size() - completedToday;

        model.addAttribute("completedToday", completedToday);
        model.addAttribute("pendingToday", pendingToday);

        // Thêm thông tin thống kê
        model.addAttribute("totalTasks", totalTasks);
        model.addAttribute("completedTasks", completedTasks);
        model.addAttribute("pendingTasks", pendingTasks);
        model.addAttribute("urgentTasks", urgentTasks);

        return "client/home/index";
    }

    @RequestMapping("/intro")
    public String IntroPage(Model model) {

        return "client/home/intro";
    }

    @RequestMapping("/analyst")
    public String AnalystPage(Model model, HttpSession session) {
        Users currentUser = (Users) session.getAttribute("currentUser");

        // Lấy danh sách Task DTO có kèm thông tin Category và Priority
        List<TaskCategoryPriorityDTO> lsTasks = taskService
                .getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // 2. Tính tỷ lệ hoàn thành
        int completedTasks = (int) lsTasks.stream().filter(TaskCategoryPriorityDTO::isStatus).count();
        int pendingTasks = lsTasks.size() - completedTasks;
        System.out.println(completedTasks);
        System.out.println(pendingTasks);

        // 3. Thống kê theo tháng
        List<Integer> tasksByMonth = new ArrayList<>(Collections.nCopies(12, 0));
        for (TaskCategoryPriorityDTO task : lsTasks) {
            if (task.getDate() != null) {
                LocalDate localDate = task.getDate().toLocalDate();
                int month = localDate.getMonthValue(); // 1 = Jan ... 12 = Dec
                tasksByMonth.set(month - 1, tasksByMonth.get(month - 1) + 1);
            }
        }

        // 4. Thống kê 7 ngày gần nhất (không tính hôm nay)
        Map<String, Integer> tasksLast7Days = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE dd/MM"); // ví dụ: Mon 08/04

        for (int i = 7; i >= 1; i--) {
            LocalDate targetDate = today.minusDays(i);
            String label = targetDate.format(formatter);
            tasksLast7Days.put(label, 0);
        }

        for (TaskCategoryPriorityDTO task : lsTasks) {
            if (task.getDate() != null) {
                LocalDate taskDate = task.getDate().toLocalDate();
                String label = taskDate.format(formatter);
                if (tasksLast7Days.containsKey(label)) {
                    tasksLast7Days.put(label, tasksLast7Days.get(label) + 1);
                }
            }
        }

        // Đẩy dữ liệu sang JSP
        model.addAttribute("completedTasks", completedTasks);
        model.addAttribute("pendingTasks", pendingTasks);
        model.addAttribute("tasksByMonth", tasksByMonth);

        // Dữ liệu cho biểu đồ 7 ngày gần nhất (không gồm hôm nay)
        model.addAttribute("tasksLast7DaysLabels", new ArrayList<>(tasksLast7Days.keySet()));
        model.addAttribute("tasksLast7DaysValues", new ArrayList<>(tasksLast7Days.values()));

        return "client/home/analyst";
    }

    @RequestMapping("/today")
    public String TodayPage(Model model, HttpSession session) {
        Users userCurrent = (Users) session.getAttribute("currentUser");
        List<TaskCategoryPriorityDTO> lsTasks = taskService
                .getAllTaskWithCategoryPriorityByUser(userCurrent.getUserId());

        // Lọc theo ngày hôm nay
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = lsTasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());
        // for (TaskCategoryPriorityDTO task : lsTasks) {
        // System.out.println(task.toString());
        // }

        // Lấy danh sách category
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        List<Priority> priorities = priorityService.getAllPriorities();
        model.addAttribute("priorities", priorities);

        model.addAttribute("tasks", todayTasks); // thêm dòng này
        return "client/home/today";
    }

    @RequestMapping("/upComing")
    public String UpComingPage(Model model, HttpSession session) {
        Users userCurrent = (Users) session.getAttribute("currentUser");
        List<TaskCategoryPriorityDTO> lsTasks = taskService
                .getAllTaskWithCategoryPriorityByUser(userCurrent.getUserId());

        // Lấy danh sách category
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        // Lọc task có ngày lớn hơn hôm nay
        List<TaskCategoryPriorityDTO> upcomingTasks = lsTasks.stream()
                .filter(task -> task.getDate().toLocalDate().isAfter(LocalDate.now()))
                .collect(Collectors.toList());

        List<Priority> priorities = priorityService.getAllPriorities();
        model.addAttribute("priorities", priorities);

        model.addAttribute("tasks", upcomingTasks); // thêm dòng này
        return "client/home/upComing";
    }

    @RequestMapping("/info")
    public String infoPage(Model model, HttpSession session) {
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (currentUser != null) {
            model.addAttribute("user", currentUser);
        }
        System.err.println(currentUser);
        return "client/home/info";
    }

    @RequestMapping("/login")
    public String LoginPage(Model model) {
        model.addAttribute("user", new Users());

        return "client/auth/login";
    }

    @RequestMapping(value = "user/login", method = RequestMethod.POST)
    public String Login(@Valid @ModelAttribute("user") Users user,
            BindingResult result, HttpSession session) {

        if (this.userService.checkEmail(user.getEmail()) == true) {
            Users checkUser = this.userService.getUserByEmail(user.getEmail());
            String checkPassword = checkUser.getPasswordHash();
            if (userService.checkPassword(user.getPasswordHash(), checkPassword) == true) {
                session.setAttribute("currentUser", checkUser);
                return "redirect:/";
            } else {
                return "redirect:/login";
            }
        }
        return "redirect:/login";
    }

    // tạo một đối tượng newUser để truyền qua view và bên view sẽ có
    // modelAttribute="newUser" để nhận biến đo
    // sau đó định nghĩa các path để các input filler dữ liệu vào newUser
    @RequestMapping("/register")
    public String RegisterPage(Model model) {
        model.addAttribute("newUser", new Users()); // Thêm đối tượng vào Model
        return "client/auth/register";
    }

    // sau đó khi post thì bên register này sẽ nhận dữ liệu qua anotation
    // @ModelAttribute("newUser")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String Register(@Valid @ModelAttribute("newUser") Users newUsers,
            BindingResult result) {

        // Kiểm tra mật khẩu xác nhận có khớp không
        if (newUsers.getPasswordHash() != null && newUsers.getConfirmPassword() != null &&
                !newUsers.getPasswordHash().equals(newUsers.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "error.confirmPassword", "Xác nhận mật khẩu không khớp");
        }

        List<FieldError> lstError = result.getFieldErrors();
        for (FieldError fieldError : lstError) {
            System.out.println(fieldError.getField() + " " + fieldError.getDefaultMessage());
        }
        if (result.hasErrors()) {
            return "client/auth/register";
        }
        String hashPassword = passwordEncoder.encode(newUsers.getPasswordHash());
        newUsers.setPasswordHash(hashPassword);
        userService.registerUser(newUsers);
        return "redirect:/login";
    }

}
