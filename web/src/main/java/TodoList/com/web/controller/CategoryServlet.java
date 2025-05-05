package TodoList.com.web.controller;

import java.io.IOException;
import TodoList.com.web.model.Category;
import TodoList.com.web.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    @Autowired
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Kiểm tra nếu DI không hoạt động, thử lấy từ ServletContext
        if (this.categoryService == null) {
            System.out.println("WARNING: CategoryService is null, attempting to get from ServletContext");
            this.categoryService = (CategoryService) getServletContext().getAttribute("categoryService");
            
            // Nếu vẫn không có, tạo mới (không khuyến khích trong production)
            if (this.categoryService == null) {
                System.out.println("ERROR: CategoryService could not be found or created");
                throw new ServletException("CategoryService could not be initialized");
            }
        }
        System.out.println("CategoryServlet initialized successfully");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("CategoryServlet: Processing POST request to /category");

        String action = req.getParameter("action");
        System.out.println("Action: " + action);

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String color = req.getParameter("color");
            System.out.println("Adding category: " + name + " with color: " + color);

            Category category = new Category();
            category.setName(name);
            category.setColor(color);

            categoryService.createCategory(category);
            System.out.println("Category created successfully");
        } else if ("delete".equals(action)) {
            String categoryIdStr = req.getParameter("categoryId");
            System.out.println("Attempting to delete category ID: " + categoryIdStr);
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                categoryService.deleteById(categoryId);
                System.out.println("Category deleted successfully");
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID format: " + categoryIdStr);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/");
    }
}
