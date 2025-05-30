package TodoList.com.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRegistration;

@Configuration
public class ServletConfig implements ServletContextInitializer {

    @Autowired
    private ApplicationContext applicationContext;

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        // Register Spring's application context with the servlet context
        servletContext.setAttribute("springApplicationContext", applicationContext);

        // This allows servlets to access Spring beans by:
        // ApplicationContext context =
        // WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        // or
        // ApplicationContext context = (ApplicationContext)
        // getServletContext().getAttribute("springApplicationContext");
    }
}
