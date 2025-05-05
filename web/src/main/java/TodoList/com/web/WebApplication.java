package TodoList.com.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

//@SpringBootApplication
// tac security
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
@ServletComponentScan // Kích hoạt quét và đăng ký các Servlet có annotation @WebServlet
public class WebApplication {
	public static void main(String[] args) {
		SpringApplication.run(WebApplication.class, args);

	}
}
