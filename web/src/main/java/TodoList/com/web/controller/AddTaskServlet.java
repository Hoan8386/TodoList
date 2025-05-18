package TodoList.com.web.controller;

import java.io.IOException;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import TodoList.com.web.service.TaskService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

@WebServlet(urlPatterns = { "/addTask", "/updateTask" })
public class AddTaskServlet extends HttpServlet {

    @Autowired
    private TaskService taskService;

    @Autowired
    private CategoryService categoryService;

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

        // If any service is still null, throw exception
        if (this.taskService == null || this.categoryService == null) {
            System.out.println("ERROR: Required services could not be initialized");
            throw new ServletException("Required services could not be initialized");
        }

        System.out.println("AddTaskServlet initialized successfully");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        System.out.println("AddTaskServlet: Processing GET request: " + servletPath);

        if ("/addTask".equals(servletPath)) {
            showAddTaskPage(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        System.out.println("AddTaskServlet: Processing POST request: " + servletPath);

        if ("/addTask".equals(servletPath)) {
            addTask(req, resp);
        } else if ("/updateTask".equals(servletPath)) {
            updateTask(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showAddTaskPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Load categories for the form
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("task", new Task());

        req.getRequestDispatcher("/WEB-INF/view/client/home/addTask.jsp").forward(req, resp);
    }

    private void addTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Create new task from form parameters
        Task newTask = new Task();

        // Set user ID from session
        newTask.setUserID(currentUser.getUserId());

        // Set other fields from request parameters
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String dateStr = req.getParameter("date");
        String categoryIDStr = req.getParameter("categoryID");
        String priorityIDStr = req.getParameter("priorityID");

        newTask.setName(name);
        newTask.setDescription(description);

        // Parse date if provided
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                java.sql.Date date = java.sql.Date.valueOf(dateStr);
                newTask.setDate(date);
            } catch (IllegalArgumentException e) {
                System.out.println("Invalid date format: " + dateStr);
            }
        }

        // Parse category ID if provided
        if (categoryIDStr != null && !categoryIDStr.isEmpty()) {
            try {
                int categoryID = Integer.parseInt(categoryIDStr);
                newTask.setCategoryID(categoryID);
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID: " + categoryIDStr);
            }
        }

        // Parse priority ID if provided
        if (priorityIDStr != null && !priorityIDStr.isEmpty()) {
            try {
                int priorityID = Integer.parseInt(priorityIDStr);
                newTask.setPriorityID(priorityID);
            } catch (NumberFormatException e) {
                System.out.println("Invalid priority ID: " + priorityIDStr);
            }
        }

        // Save task
        taskService.saveTask(newTask);
        System.out.println("Task added successfully: " + name);

        // Redirect to today's tasks page
        resp.sendRedirect(req.getContextPath() + "/today");
    }

    private void updateTask(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Check if user is logged in
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Parse request parameters
        String taskIDStr = req.getParameter("taskID");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String dateStr = req.getParameter("date");
        String categoryIDStr = req.getParameter("categoryID");
        String priorityIDStr = req.getParameter("priorityID");

        try {
            // Parse task ID
            int taskID = Integer.parseInt(taskIDStr);

            // Get existing task
            Task existingTask = taskService.getTaskById(taskID);

            // Check if task exists and belongs to current user
            if (existingTask != null && existingTask.getUserID() == currentUser.getUserId()) {
                // Update task fields
                existingTask.setName(name);
                existingTask.setDescription(description);

                // Parse date if provided
                if (dateStr != null && !dateStr.isEmpty()) {
                    try {
                        java.sql.Date date = java.sql.Date.valueOf(dateStr);
                        existingTask.setDate(java.sql.Date.valueOf(date.toLocalDate()));
                    } catch (IllegalArgumentException e) {
                        System.out.println("Invalid date format: " + dateStr);
                    }
                }

                // Parse category ID if provided
                if (categoryIDStr != null && !categoryIDStr.isEmpty()) {
                    try {
                        int categoryID = Integer.parseInt(categoryIDStr);
                        existingTask.setCategoryID(categoryID);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid category ID: " + categoryIDStr);
                    }
                }

                // Parse priority ID if provided
                if (priorityIDStr != null && !priorityIDStr.isEmpty()) {
                    try {
                        int priorityID = Integer.parseInt(priorityIDStr);
                        existingTask.setPriorityID(priorityID);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid priority ID: " + priorityIDStr);
                    }
                }

                // Save updated task
                taskService.updateTask(existingTask);
                System.out.println("Task updated successfully: " + name);
            } else {
                System.out.println("Task not found or not owned by current user: " + taskID);
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid task ID: " + taskIDStr);
        }

        // Redirect to referring page or to today's tasks page
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/today");
    }
}