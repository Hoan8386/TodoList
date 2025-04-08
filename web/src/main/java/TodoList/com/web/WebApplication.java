package TodoList.com.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@SpringBootApplication
// tac security
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)

public class WebApplication {
	public static void main(String[] args) {
		SpringApplication.run(WebApplication.class, args);

	}
}
