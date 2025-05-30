package TodoList.com.web.config;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.WebApplicationContext;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

@Configuration
public class ServletBeanConfig {

    private final WebApplicationContext webApplicationContext;

    public ServletBeanConfig(WebApplicationContext webApplicationContext) {
        this.webApplicationContext = webApplicationContext;
    }

    @Bean
    public ServletContextInitializer servletContextInitializer() {
        return new ServletContextInitializer() {
            @Override
            public void onStartup(ServletContext servletContext) throws ServletException {
                // Hook servlet initialization to handle autowiring for servlets
                servletContext.addListener(new jakarta.servlet.ServletRequestListener() {
                    @Override
                    public void requestInitialized(jakarta.servlet.ServletRequestEvent sre) {
                        // Get the servlet instance
                        Object servlet = sre.getServletContext().getAttribute(sre.getServletRequest().getServletPath());
                        if (servlet != null) {
                            // Autowire the servlet
                            AutowireCapableBeanFactory autowireFactory = webApplicationContext
                                    .getAutowireCapableBeanFactory();
                            autowireFactory.autowireBean(servlet);
                        }
                    }

                    @Override
                    public void requestDestroyed(jakarta.servlet.ServletRequestEvent sre) {
                        // Not needed
                    }
                });
            }
        };
    }
}
