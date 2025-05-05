package TodoList.com.web.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import TodoList.com.web.model.Users;
import TodoList.com.web.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void registerUser(Users users) {
        userRepository.addUser(users);
    }

    // public List<Users> getAllUsers() {
    // return userRepository.getAllUsers();
    // }

    // public Users getUserByEmail(String email) {
    // return userRepository.getUserByEmail(email);
    // }

    public boolean checkPassword(String rawPassword, String hashedPassword) {
        return passwordEncoder.matches(rawPassword, hashedPassword);
    }

    public boolean checkEmail(String email) {
        return userRepository.checkEmail(email);
    }

    public Users getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean updateUser(Users user) {
        return userRepository.updateUser(user);
    }
}
