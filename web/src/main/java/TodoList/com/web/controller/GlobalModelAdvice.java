package TodoList.com.web.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import TodoList.com.web.model.Category;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.CategoryService;
import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalModelAdvice {

    private final CategoryService categoryService;

    public GlobalModelAdvice(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @ModelAttribute("categoryList")
    public List<Category> getCategoryList() {
        List<Category> categories = categoryService.getAllCategories();
        return categories;
    }

    @ModelAttribute("birthdayMessage")
    public String getBirthdayMessage(HttpSession session) {
        Users user = (Users) session.getAttribute("currentUser");
        if (user != null && user.getBirthDate() != null) {
            LocalDate today = LocalDate.now();
            LocalDate birthDate = user.getBirthDate();
            if (birthDate.getDayOfMonth() == today.getDayOfMonth() &&
                    birthDate.getMonthValue() == today.getMonthValue()) {
                return "Chúc mừng sinh nhật, " + (user.getUserName() != null ? user.getUserName() : "bạn") + "! 🎉";
            }
        }
        return null;
    }
}