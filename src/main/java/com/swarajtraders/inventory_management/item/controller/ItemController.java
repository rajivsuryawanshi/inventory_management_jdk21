package com.swarajtraders.inventory_management.item.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

import com.swarajtraders.inventory_management.item.entity.Item;
import com.swarajtraders.inventory_management.item.repository.ItemRepository;
import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Autowired
	private ItemRepository itemRepository;
	
	@Autowired
	private UserRepository userRepository;

	// Test endpoint to verify database connectivity
	@GetMapping("/test-item-db")
	@ResponseBody
	public String testDatabase() {
		try {
			long count = itemRepository.count();
			logger.info("Database test successful. Item count: {}", count);
			return "Database connection successful. Item count: " + count;
		} catch (Exception e) {
			logger.error("Database test failed", e);
			return "Database connection failed: " + e.getMessage();
		}
	}

	// Show the Item Form
	@GetMapping("/addItem")
	public String showAddItemForm(Model model) {
		logger.info("Showing add item form");
		
		// Add user information to model
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userRepository.findByUserName(username);
		if (user != null) {
			model.addAttribute("user", user);
			model.addAttribute("name", username);
		}
		
		model.addAttribute("item", new Item());
		return "addItem"; // JSP view name
	}

	// Show all items
	@GetMapping("/items")
	public String listItems(Model model) {
		logger.info("Listing all items");
		
		// Add user information to model
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userRepository.findByUserName(username);
		if (user != null) {
			model.addAttribute("user", user);
			model.addAttribute("name", username);
		}
		
		try {
			model.addAttribute("items", itemRepository.findAll());
			logger.info("Found {} items", itemRepository.count());
		} catch (Exception e) {
			logger.error("Error fetching items", e);
			model.addAttribute("error", "Error loading items: " + e.getMessage());
		}
		return "itemList"; // JSP view for listing items
	}

	// Handle the Item Form submission
	@PostMapping("/addItem")
	public String handleAddItem(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {
		logger.info("Processing add item request for: {}", item.getItemName());
		logger.info("Item details - Name: {}, Code: {}, Category: {}, SubCategory: {}", 
			item.getItemName(), item.getItemCode(), item.getCategory(), item.getSubCategory());
		
		// Check for validation errors
		if (result.hasErrors()) {
			logger.warn("Validation errors found: {}", result.getAllErrors());
			
			// Add user information to model for re-display
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String username = authentication.getName();
			
			User user = userRepository.findByUserName(username);
			if (user != null) {
				model.addAttribute("user", user);
				model.addAttribute("name", username);
			}
			
			// Add the binding result errors to the model so JSP can display them
			model.addAttribute("errors", result.getAllErrors());
			
			// Create field-specific error mapping for better JSP display
			java.util.Map<String, String> fieldErrors = new java.util.HashMap<>();
			result.getFieldErrors().forEach(error -> {
				fieldErrors.put(error.getField(), error.getDefaultMessage());
			});
			model.addAttribute("fieldErrors", fieldErrors);
			
			return "addItem";
		}

		try {
			logger.info("Attempting to save item to database");
			Item savedItem = itemRepository.save(item);
			logger.info("Item saved successfully with ID: {}", savedItem.getItemId());
			
			// Add success message
			model.addAttribute("message", "Item added successfully!");
			
			// Redirect to the item list
			return "redirect:/items";
		} catch (Exception e) {
			logger.error("Error saving item", e);
			
			// Add user information to model for re-display
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String username = authentication.getName();
			
			User user = userRepository.findByUserName(username);
			if (user != null) {
				model.addAttribute("user", user);
				model.addAttribute("name", username);
			}
			
			model.addAttribute("error", "Error saving item: " + e.getMessage());
			return "addItem";
		}
	}

	// Handle the form submission for deleting an item
	@PostMapping("/deleteItem")
	public String deleteItem(@RequestParam("itemId") Long itemId, RedirectAttributes redirectAttributes) {
		logger.info("Deleting item with ID: {}", itemId);
		
		try {
			// Perform the deletion
			itemRepository.deleteById(itemId);
			logger.info("Item deleted successfully with ID: {}", itemId);

			// Add a success message for feedback
			redirectAttributes.addFlashAttribute("message", "Item deleted successfully!");

			// Redirect back to the item list
			return "redirect:/items";
		} catch (Exception e) {
			logger.error("Error deleting item with ID: {}", itemId, e);
			redirectAttributes.addFlashAttribute("error", "Error deleting item: " + e.getMessage());
			return "redirect:/items";
		}
	}
}
