package com.swarajtraders.inventory_management.party;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swarajtraders.inventory_management.entity.Party;
import com.swarajtraders.inventory_management.repository.PartyRepository;

import jakarta.validation.Valid;

@Controller
public class PartyController {

	@Autowired
	private PartyRepository partyRepository;

	// Show the Party Form
	@GetMapping("/addParty")
	public String showAddPartyForm(Model model) {
		model.addAttribute("party", new Party());
		return "addParty"; // JSP view name
	}

	// Show all parties
	@GetMapping("/parties")
	public String listParties(Model model) {
		model.addAttribute("parties", partyRepository.findAll());
		return "partyList"; // JSP view for listing parties
	}

	// Handle the Party Form submission
	@PostMapping("/addParty")
	public String handleAddParty(@Valid @ModelAttribute("party") Party party, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("errors", result.getAllErrors());
			return "addParty";
		}

		partyRepository.save(party);

		// Process the party data (e.g., save to database)
		model.addAttribute("message", "Party added successfully!");
		return "redirect:/parties"; // Redirect to the party list
	}

	// Handle the form submission for deleting a party
	@PostMapping("/deleteParty")
	public String deleteParty(@RequestParam("partyId") Long partyId, RedirectAttributes redirectAttributes) {
		// Perform the deletion
		partyRepository.deleteById(partyId);

		// Add a success message for feedback (optional)
		redirectAttributes.addFlashAttribute("message", "Party deleted successfully!");

		// Redirect back to the party list
		return "redirect:/parties";
	}
}
