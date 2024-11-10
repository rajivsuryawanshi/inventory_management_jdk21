package com.swarajtraders.inventory_management.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.swarajtraders.inventory_management.entity.User;
import com.swarajtraders.inventory_management.repository.UserRepository;

@Controller
@SessionAttributes("user")
public class LoginController {

	private AuthenticationService authenticationService;
	@Autowired
	private UserRepository userRepository;

	public LoginController(AuthenticationService authenticationService) {
		super();
		this.authenticationService = authenticationService;
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String renderLoginPage() {
		return "login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String gotoWelcomePage(@RequestParam String name, @RequestParam String password, ModelMap model) {
		User user = authenticationService.authenticate(name, password);
		if (user != null) {
			model.put("user", user);
			model.put("name", name);
			model.put("userList", userRepository.findAll());
			return "dashboard";
		}
		model.put("errorMessage", "Wrong UserName or Password");
		return "login";
	}
	
	// This will show the main dashboard after successful login
	@RequestMapping("/dashboard")
    public String showDashboard() {
        return "dashboard";  // JSP view for main dashboard
    }
	
}
