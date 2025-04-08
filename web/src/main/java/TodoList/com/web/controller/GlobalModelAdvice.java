package TodoList.com.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import TodoList.com.web.model.Category;
import TodoList.com.web.service.CategoryService;

@ControllerAdvice
public class GlobalModelAdvice {

    private final CategoryService categoryService;

    public GlobalModelAdvice(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @ModelAttribute("categoryList")
    public List<Category> getCategoryList() {
        List<Category> categories = categoryService.getAllCategories();
        // Debug

        return categories;
    }
}