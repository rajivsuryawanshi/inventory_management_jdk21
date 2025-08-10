package com.swarajtraders.inventory_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private SessionTimeoutInterceptor sessionTimeoutInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(sessionTimeoutInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/login", "/logout", "/h2-console/**", "/css/**", "/js/**", "/webjars/**");
    }
}
