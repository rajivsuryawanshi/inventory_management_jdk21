package com.swarajtraders.inventory_management;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class SessionTimeoutInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(SessionTimeoutInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Check if session is expired
            long currentTime = System.currentTimeMillis();
            long lastAccessTime = session.getLastAccessedTime();
            long sessionTimeout = session.getMaxInactiveInterval() * 1000L; // Convert to milliseconds
            
            if (currentTime - lastAccessTime > sessionTimeout) {
                logger.info("Session expired for user, redirecting to login");
                session.invalidate();
                response.sendRedirect("/swarajtraders/login?expired");
                return false;
            }
            
            // Update last access time
            session.setAttribute("lastAccessTime", currentTime);
        }
        
        return true;
    }
}
