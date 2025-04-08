package TodoList.com.web.controller;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import TodoList.com.web.model.Task;
import TodoList.com.web.model.TaskCategoryPriorityDTO;
import TodoList.com.web.model.Users;
import TodoList.com.web.service.TaskService;
import TodoList.com.web.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.util.List;

@Controller
public class UserController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final TaskService taskService;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, TaskService taskService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.taskService = taskService;
    }

    @RequestMapping("/")
    public String HomePage(Model model, HttpSession session) {
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (currentUser != null) {
            model.addAttribute("user", currentUser);
        } else {
            // return "redirect:client/auth/login";
        }
        return "client/home/index";
    }

    @RequestMapping("/intro")
    public String IntroPage(Model model) {

        return "client/home/intro";
    }

    @RequestMapping("/analyst")
    public String AnalystPage(Model model) {
        return "client/home/analyst";
    }

    @RequestMapping("/today")
    public String TodayPage(Model model, HttpSession session) {
        Users userCurrent = (Users) session.getAttribute("currentUser");
        List<TaskCategoryPriorityDTO> lsTasks = taskService
                .getAllTaskWithCategoryPriorityByUser(userCurrent.getUserId());
        for (TaskCategoryPriorityDTO task : lsTasks) {
            System.out.println(task.toString());
        }
        model.addAttribute("tasks", lsTasks); // thêm dòng này
        return "client/home/today";
    }

    @RequestMapping("/upComing")
    public String UpComingPage(Model model) {
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

        // ✅ Kiểm tra mật khẩu xác nhận có khớp không
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
