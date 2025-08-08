package com.swarajtraders.inventory_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;

@Controller
public class WebController {

    @Autowired
    private UserRepository userRepository;

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
}
