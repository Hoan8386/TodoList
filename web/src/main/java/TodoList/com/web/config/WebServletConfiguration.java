package TodoList.com.web.config;

import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import TodoList.com.web.controller.AddTaskServlet;
import TodoList.com.web.controller.CategoryServlet;
import TodoList.com.web.controller.TaskServlet;

@Configuration
public class WebServletConfiguration {

    // This class is only needed if you want to register servlets programmatically
    // in addition to using @WebServlet annotation

    /*
     * // Example of programmatically registering a servlet
     * 
     * @Bean
     * public ServletRegistrationBean<AddTaskServlet> addTaskServlet() {
     * ServletRegistrationBean<AddTaskServlet> servRegBean = new
     * ServletRegistrationBean<>();
     * servRegBean.setServlet(new AddTaskServlet());
     * servRegBean.addUrlMappings("/addTask", "/updateTask");
     * servRegBean.setLoadOnStartup(1);
     * return servRegBean;
     * }
     */
}
