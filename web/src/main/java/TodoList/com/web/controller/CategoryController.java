package TodoList.com.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import TodoList.com.web.model.Category;
import TodoList.com.web.service.CategoryService;

@Controller
public class CategoryController {

    private CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @PostMapping("/addCategory")
    public String createCategory(@RequestParam String name, @RequestParam String color) {
        Category category = new Category();
        category.setName(name);
        category.setColor(color);
        categoryService.createCategory(category);
        return "redirect:/";
    }

    @PostMapping("/deleteCategory")
    public String deleteCategory(@RequestParam("categoryId") int categoryId) {
        categoryService.deleteById(categoryId); // Xử lý xóa ở tầng service
        return "redirect:/"; // Hoặc load lại trang hiện tại
    }

}
