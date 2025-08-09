package com.swarajtraders.inventory_management.party.controller;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.swarajtraders.inventory_management.party.entity.Party;
import com.swarajtraders.inventory_management.party.repository.PartyRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class PartyController {

	private static final Logger logger = LoggerFactory.getLogger(PartyController.class);

	@Autowired
	private PartyRepository partyRepository;

	// Test endpoint to verify database connectivity
	@GetMapping("/test-db")
	@ResponseBody
	public String testDatabase() {
		try {
			long count = partyRepository.count();
			logger.info("Database test successful. Party count: {}", count);
			return "Database connection successful. Party count: " + count;
		} catch (Exception e) {
			logger.error("Database test failed", e);
			return "Database connection failed: " + e.getMessage();
		}
	}

	// Show the Party Form
	@GetMapping("/addParty")
	public String showAddPartyForm(Model model) {
		logger.info("Showing add party form");
		model.addAttribute("party", new Party());
		return "addParty"; // JSP view name
	}

	// Show all parties
	@GetMapping("/parties")
	public String listParties(Model model) {
		logger.info("Listing all parties");
		try {
			model.addAttribute("parties", partyRepository.findAll());
			logger.info("Found {} parties", partyRepository.count());
		} catch (Exception e) {
			logger.error("Error fetching parties", e);
			model.addAttribute("error", "Error loading parties: " + e.getMessage());
		}
		return "partyList"; // JSP view for listing parties
	}

	// Handle the Party Form submission
	@PostMapping("/addParty")
	public String handleAddParty(@Valid @ModelAttribute("party") Party party, BindingResult result, Model model) {
		logger.info("Processing add party request for: {}", party.getPartyName());
		logger.info("Party details - Name: {}, GST: {}, Phone: {}, Email: {}", 
			party.getPartyName(), party.getGstNo(), party.getPhoneNumber(), party.getEmail());
		
		// Check for validation errors
		if (result.hasErrors()) {
			logger.warn("Validation errors found: {}", result.getAllErrors());
			// Add the binding result errors to the model so JSP can display them
			model.addAttribute("errors", result.getAllErrors());
			
			// Create field-specific error mapping for better JSP display
			java.util.Map<String, String> fieldErrors = new java.util.HashMap<>();
			result.getFieldErrors().forEach(error -> {
				fieldErrors.put(error.getField(), error.getDefaultMessage());
			});
			model.addAttribute("fieldErrors", fieldErrors);
			
			return "addParty";
		}

		try {
			logger.info("Attempting to save party to database");
			Party savedParty = partyRepository.save(party);
			logger.info("Party saved successfully with ID: {}", savedParty.getPartyId());
			
			// Add success message
			model.addAttribute("message", "Party added successfully!");
			
			// Redirect to the party list
			return "redirect:/parties";
		} catch (Exception e) {
			logger.error("Error saving party", e);
			model.addAttribute("error", "Error saving party: " + e.getMessage());
			return "addParty";
		}
	}

	// Handle the form submission for deleting a party
	@PostMapping("/deleteParty")
	public String deleteParty(@RequestParam("partyId") Long partyId, RedirectAttributes redirectAttributes) {
		logger.info("Deleting party with ID: {}", partyId);
		
		try {
			// Perform the deletion
			partyRepository.deleteById(partyId);
			logger.info("Party deleted successfully with ID: {}", partyId);

			// Add a success message for feedback
			redirectAttributes.addFlashAttribute("message", "Party deleted successfully!");

			// Redirect back to the party list
			return "redirect:/parties";
		} catch (Exception e) {
			logger.error("Error deleting party with ID: {}", partyId, e);
			redirectAttributes.addFlashAttribute("error", "Error deleting party: " + e.getMessage());
			return "redirect:/parties";
		}
	}
}
