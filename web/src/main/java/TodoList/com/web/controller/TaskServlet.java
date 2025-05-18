package TodoList.com.web.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.PriorityService;
import TodoList.com.web.service.TaskService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

@WebServlet(urlPatterns = { "/task/*" })
public class TaskServlet extends HttpServlet {

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
        if (this.taskService == null || this.categoryService == null || this.priorityService == null) {
            System.out.println("ERROR: Required services could not be initialized");
            throw new ServletException("Required services could not be initialized");
        }

        System.out.println("TaskServlet initialized successfully");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        System.out.println("TaskServlet: Processing GET request: " + pathInfo);

        if (pathInfo == null || pathInfo.equals("/")) {
            // Default action - show today's tasks
            showTodayTasks(req, resp);
        } else if (pathInfo.equals("/status")) {
            // Filter tasks by status
            filterByStatus(req, resp);
        } else if (pathInfo.equals("/filter")) {
            // Advanced filtering
            filterTasks(req, resp);
        } else if (pathInfo.equals("/statusComing")) {
            // Filter upcoming tasks by status
            filterUpcomingTasksByStatus(req, resp);
        } else if (pathInfo.equals("/filterComing")) {
            // Filter upcoming tasks
            filterUpcomingTasks(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        System.out.println("TaskServlet: Processing POST request: " + pathInfo);

        if (pathInfo == null || pathInfo.equals("/")) {
            // Default action
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else if (pathInfo.equals("/check")) {
            // Toggle task completion
            checkTask(req, resp);
        } else if (pathInfo.equals("/delete")) {
            // Delete task
            deleteTask(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void checkTask(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String taskIdStr = req.getParameter("taskId");
        String completed = req.getParameter("completed");
        System.out.println("Checking task: " + taskIdStr + " status: " + completed);

        try {
            Long taskId = Long.parseLong(taskIdStr);
            boolean isCompleted = (completed != null); // If parameter exists, task is completed

            taskService.updateTaskStatus(taskId, isCompleted);
            System.out.println("Task status updated successfully");
        } catch (NumberFormatException e) {
            System.out.println("Invalid task ID format: " + taskIdStr);
        }

        // Redirect back to today page
        resp.sendRedirect(req.getContextPath() + "/today");
    }

    private void deleteTask(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String taskIdStr = req.getParameter("taskId");
        System.out.println("Deleting task: " + taskIdStr);

        try {
            int taskId = Integer.parseInt(taskIdStr);
            taskService.deleteTask(taskId);
            System.out.println("Task deleted successfully");
        } catch (NumberFormatException e) {
            System.out.println("Invalid task ID format: " + taskIdStr);
        }

        // Redirect to referring page
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/");
    }

    private void showTodayTasks(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Showing today's tasks");

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

        // Set attributes for JSP
        req.setAttribute("tasks", todayTasks);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/view/client/home/today.jsp").forward(req, resp);
    }

    private void filterByStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        if (status == null)
            status = "all";
        System.out.println("Filtering today's tasks by status: " + status);

        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> tasks = taskService.getTasksByStatus(currentUser.getUserId(), status);

        // Filter for today's tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        // Set attributes for JSP
        req.setAttribute("tasks", todayTasks);
        req.setAttribute("status", status);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/view/client/home/today.jsp").forward(req, resp);
    }

    private void filterTasks(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String categoryId = req.getParameter("categoryId");
        String priorityId = req.getParameter("priorityId");
        LocalDate date = null;

        String dateStr = req.getParameter("date");
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                date = LocalDate.parse(dateStr);
            } catch (Exception e) {
                System.out.println("Invalid date format: " + dateStr);
            }
        }

        System.out.println("Filtering tasks with keyword=" + keyword + ", categoryId=" + categoryId + ", priorityId="
                + priorityId + ", date=" + date);

        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> filteredTasks = taskService.filterTasks(currentUser.getUserId(), keyword,
                categoryId, priorityId, date);

        // Filter for today's tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> todayTasks = filteredTasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isEqual(today))
                .collect(Collectors.toList());

        // Set attributes for JSP
        req.setAttribute("tasks", todayTasks);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/view/client/home/today.jsp").forward(req, resp);
    }

    private void filterUpcomingTasksByStatus(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String status = req.getParameter("status");
        if (status == null)
            status = "all";
        System.out.println("Filtering upcoming tasks by status: " + status);

        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> tasks = taskService.getTasksByStatus(currentUser.getUserId(), status);

        // Filter for upcoming tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> upcomingTasks = tasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isAfter(today))
                .collect(Collectors.toList());

        // Set attributes for JSP
        req.setAttribute("tasks", upcomingTasks);
        req.setAttribute("status", status);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/view/client/home/upComing.jsp").forward(req, resp);
    }

    private void filterUpcomingTasks(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String categoryId = req.getParameter("categoryId");
        String priorityId = req.getParameter("priorityId");
        LocalDate date = null;

        String dateStr = req.getParameter("date");
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                date = LocalDate.parse(dateStr);
            } catch (Exception e) {
                System.out.println("Invalid date format: " + dateStr);
            }
        }

        System.out.println("Filtering upcoming tasks with keyword=" + keyword + ", categoryId=" + categoryId
                + ", priorityId=" + priorityId + ", date=" + date);

        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<TaskCategoryPriorityDTO> filteredTasks = taskService.filterTasks(currentUser.getUserId(), keyword,
                categoryId, priorityId, date);

        // Filter for upcoming tasks
        LocalDate today = LocalDate.now();
        List<TaskCategoryPriorityDTO> upcomingTasks = filteredTasks.stream()
                .filter(task -> task.getDate() != null && task.getDate().toLocalDate().isAfter(today))
                .collect(Collectors.toList());

        // Set attributes for JSP
        req.setAttribute("tasks", upcomingTasks);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("priorities", priorityService.getAllPriorities());

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/view/client/home/upComing.jsp").forward(req, resp);
    }
}