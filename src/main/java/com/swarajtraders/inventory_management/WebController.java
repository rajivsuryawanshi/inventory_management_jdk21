package com.swarajtraders.inventory_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;

@Controller
public class WebController {

    private static final Logger logger = LoggerFactory.getLogger(WebController.class);

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                       @RequestParam(value = "logout", required = false) String logout,
                       @RequestParam(value = "expired", required = false) String expired,
                       Model model) {
        
        logger.info("Login page accessed - error: {}, logout: {}, expired: {}", error, logout, expired);
        
        if (error != null) {
            model.addAttribute("error", "Invalid username or password.");
            logger.warn("Login attempt failed");
        } else if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully.");
            logger.info("User logged out successfully");
        } else if (expired != null) {
            model.addAttribute("message", "Your session has expired. Please login again.");
            logger.info("Session expired, redirecting to login");
        } else {
            // For regular login route, show the same UI as expired session
            model.addAttribute("message", "Your session has expired. Please login again.");
            logger.info("Regular login route accessed, showing expired session UI");
        }
        
        return "login";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        User user = userRepository.findByUserName(username);
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("name", username);
        }
        
        model.addAttribute("userList", userRepository.findAll());
        return "dashboard";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/dashboard";
    }
    
    // Error page mapping
    @GetMapping("/error")
    public String error(Model model) {
        model.addAttribute("message", "An error occurred. Please try again.");
        return "dashboard";
    }
    
    // Placeholder mappings for future features
    @GetMapping("/productEntry")
    public String productEntry(Model model) {
        model.addAttribute("message", "Product Entry - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @GetMapping("/purchaseEntry")
    public String purchaseEntry(Model model) {
        model.addAttribute("message", "Purchase Entry - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @GetMapping("/saleEntry")
    public String saleEntry(Model model) {
        model.addAttribute("message", "Sale Entry - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @GetMapping("/stockDetails")
    public String stockDetails(Model model) {
        model.addAttribute("message", "Stock Details - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @GetMapping("/stockAdjustment")
    public String stockAdjustment(Model model) {
        model.addAttribute("message", "Stock Adjustment - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @GetMapping("/expenseEntry")
    public String expenseEntry(Model model) {
        model.addAttribute("message", "Expense Entry - Coming Soon!");
        return "dashboard"; // Redirect back to dashboard for now
    }
    
    @PostMapping("/heartbeat")
    @ResponseBody
    public String heartbeat() {
        // This endpoint is used to extend the session
        // The session will be automatically extended when this endpoint is called
        return "OK";
    }
}
