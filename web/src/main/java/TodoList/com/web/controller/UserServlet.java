package TodoList.com.web.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import TodoList.com.web.model.Category;
import TodoList.com.web.model.Priority;
import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.PriorityService;
import TodoList.com.web.service.TaskService;
import TodoList.com.web.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

@WebServlet(urlPatterns = { "/user/*", "/", "/login", "/register", "/today", "/upComing", "/analyst", "/info",
        "/intro" })
public class UserServlet extends HttpServlet {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private TaskService taskService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private PriorityService priorityService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Handle DI if not working automatically
        if (this.userService == null) {
            System.out.println("WARNING: UserService is null, attempting to get from ServletContext");
            this.userService = (UserService) getServletContext().getAttribute("userService");
        }

        if (this.passwordEncoder == null) {
            System.out.println("WARNING: PasswordEncoder is null, attempting to get from ServletContext");
            this.passwordEncoder = (PasswordEncoder) getServletContext().getAttribute("passwordEncoder");
        }

        if (this.taskService == null) {
            System.out.println("WARNING: TaskService is null, attempting to get from ServletContext");
            this.taskService = (TaskService) getServletContext().getAttribute("taskService");
        }

        if (this.categoryService == null) {
            System.out.println("WARNING: CategoryService is null, attempting to get from ServletContext");
            this.categoryService = (CategoryService) getServletContext().getAttribute("categoryService");
        }

        if (this.priorityService == null) {
            System.out.println("WARNING: PriorityService is null, attempting to get from ServletContext");
            this.priorityService = (PriorityService) getServletContext().getAttribute("priorityService");
        }

        // If any service is still null, throw exception
        if (this.userService == null || this.passwordEncoder == null || this.taskService == null
                || this.categoryService == null || this.priorityService == null) {
            System.out.println("ERROR: Required services could not be initialized");
            throw new ServletException("Required services could not be initialized");
        }

        System.out.println("UserServlet initialized successfully");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        System.out.println("UserServlet: Processing GET request: " + servletPath);

        switch (servletPath) {
            case "/":
                showHomePage(req, resp);
                break;
            case "/login":
                showLoginPage(req, resp);
                break;
            case "/register":
                showRegisterPage(req, resp);
                break;
            case "/today":
                showTodayPage(req, resp);
                break;
            case "/upComing":
                showUpcomingPage(req, resp);
                break;
            case "/analyst":
                showAnalystPage(req, resp);
                break;
            case "/info":
                showInfoPage(req, resp);
                break;
            case "/intro":
                showIntroPage(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        String pathInfo = req.getPathInfo();
        System.out.println("UserServlet: Processing POST request: " + servletPath + ", pathInfo: " + pathInfo);

        if ("/user/login".equals(servletPath + (pathInfo != null ? pathInfo : ""))) {
            login(req, resp);
        } else if ("/register".equals(servletPath)) {
            register(req, resp);
        } else if ("/updateUser".equals(servletPath)) {
            updateUser(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showHomePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Get all tasks for this user
        List<TaskCategoryPriorityDTO> tasks = taskService.getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // Filter for today's tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .sorted((t1, t2) -> Integer.compare(t2.getPriorityID(), t1.getPriorityID())) // Sort by priority
                                                                                             // (descending)
                .collect(Collectors.toList());

        // Calculate statistics
        long totalTasks = tasks.size();
        long completedTasks = tasks.stream().filter(t -> t.isStatus()).count();
        long pendingTasks = tasks.stream().filter(t -> !t.isStatus()).count();
        long urgentTasks = tasks.stream().filter(t -> t.getPriorityID() == 4).count();

        // Calculate today's statistics
        long completedToday = todayTasks.stream().filter(TaskCategoryPriorityDTO::isStatus).count();
        long pendingToday = todayTasks.size() - completedToday;

        // Set attributes for the view
        req.setAttribute("user", currentUser);
        req.setAttribute("tasks", todayTasks);
        req.setAttribute("completedToday", completedToday);
        req.setAttribute("pendingToday", pendingToday);
        req.setAttribute("totalTasks", totalTasks);
        req.setAttribute("completedTasks", completedTasks);
        req.setAttribute("pendingTasks", pendingTasks);
        req.setAttribute("urgentTasks", urgentTasks);

        req.getRequestDispatcher("/WEB-INF/view/client/home/index.jsp").forward(req, resp);
    }

    private void showLoginPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("user", new Users());
        req.getRequestDispatcher("/WEB-INF/view/client/auth/login.jsp").forward(req, resp);
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("passwordHash");

        if (this.userService.checkEmail(email)) {
            Users user = this.userService.getUserByEmail(email);
            String storedPassword = user.getPasswordHash();

            if (userService.checkPassword(password, storedPassword)) {
                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
        }

        // If login failed, redirect back to login page
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private void showRegisterPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("newUser", new Users());
        req.getRequestDispatcher("/WEB-INF/view/client/auth/register.jsp").forward(req, resp);
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("passwordHash");
        String confirmPassword = req.getParameter("confirmPassword");

        // Validate input
        boolean hasError = false;

        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("usernameError", "Username is required");
            hasError = true;
        }

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("emailError", "Email is required");
            hasError = true;
        }

        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("passwordError", "Password is required");
            hasError = true;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("confirmPasswordError", "Confirm password does not match");
            hasError = true;
        }

        if (hasError) {
            // Re-populate the form
            Users newUser = new Users();
            newUser.setUserName(username);
            newUser.setEmail(email);
            req.setAttribute("newUser", newUser);
            req.getRequestDispatcher("/WEB-INF/view/client/auth/register.jsp").forward(req, resp);
            return;
        }

        // Create new user
        Users newUser = new Users();
        newUser.setUserName(username);
        newUser.setEmail(email);
        String hashPassword = passwordEncoder.encode(password);
        newUser.setPasswordHash(hashPassword);

        userService.registerUser(newUser);
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private void showTodayPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> tasks = taskService.getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // Filter for today's tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        // Set attributes for view
        req.setAttribute("tasks", todayTasks);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        req.getRequestDispatcher("/WEB-INF/view/client/home/today.jsp").forward(req, resp);
    }

    private void showUpcomingPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> tasks = taskService.getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // Filter for upcoming tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> upcomingTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isAfter(today))
                .collect(Collectors.toList());

        // Set attributes for view
        req.setAttribute("tasks", upcomingTasks);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        req.getRequestDispatcher("/WEB-INF/view/client/home/upComing.jsp").forward(req, resp);
    }

    private void showAnalystPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> tasks = taskService.getAllTaskWithCategoryPriorityByUser(currentUser.getUserId());

        // Calculate completion statistics
        int completedTasks = (int) tasks.stream().filter(TaskCategoryPriorityDTO::isStatus).count();
        int pendingTasks = tasks.size() - completedTasks;

        // Statistics by month
        List<Integer> tasksByMonth = new ArrayList<>(Collections.nCopies(12, 0));
        for (TaskCategoryPriorityDTO task : tasks) {
            if (task.getDate() != null) {
                LocalDate localDate = task.getDate().toLocalDate();
                int month = localDate.getMonthValue(); // 1 = Jan ... 12 = Dec
                tasksByMonth.set(month - 1, tasksByMonth.get(month - 1) + 1);
            }
        }

        // Statistics for last 7 days
        Map<String, Integer> tasksLast7Days = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE dd/MM"); // e.g., Mon 08/04

        for (int i = 7; i >= 1; i--) {
            LocalDate targetDate = today.minusDays(i);
            String label = targetDate.format(formatter);
            tasksLast7Days.put(label, 0);
        }

        for (TaskCategoryPriorityDTO task : tasks) {
            if (task.getDate() != null) {
                LocalDate taskDate = task.getDate().toLocalDate();
                String label = taskDate.format(formatter);
                if (tasksLast7Days.containsKey(label)) {
                    tasksLast7Days.put(label, tasksLast7Days.get(label) + 1);
                }
            }
        }

        // Set attributes for view
        req.setAttribute("completedTasks", completedTasks);
        req.setAttribute("pendingTasks", pendingTasks);
        req.setAttribute("tasksByMonth", tasksByMonth);
        req.setAttribute("tasksLast7DaysLabels", new ArrayList<>(tasksLast7Days.keySet()));
        req.setAttribute("tasksLast7DaysValues", new ArrayList<>(tasksLast7Days.values()));

        req.getRequestDispatcher("/WEB-INF/view/client/home/analyst.jsp").forward(req, resp);
    }

    private void showInfoPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/WEB-INF/view/client/home/info.jsp").forward(req, resp);
    }

    private void showIntroPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/client/home/intro.jsp").forward(req, resp);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Get form parameters
        String username = req.getParameter("username");
        String email = req.getParameter("email");

        // Update user data
        Users user = new Users();
        user.setUserId(currentUser.getUserId());
        user.setUserName(username);
        user.setEmail(email);
        user.setPasswordHash(currentUser.getPasswordHash()); // Keep existing password

        userService.updateUser(user);

        // Refresh user info in session
        Users updatedUser = userService.getUserByEmail(email);
        session.setAttribute("currentUser", updatedUser);

        resp.sendRedirect(req.getContextPath() + "/info");
    }
}