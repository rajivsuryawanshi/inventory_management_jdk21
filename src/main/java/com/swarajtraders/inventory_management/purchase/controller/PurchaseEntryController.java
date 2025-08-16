package com.swarajtraders.inventory_management.purchase.controller;

import com.swarajtraders.inventory_management.party.entity.Party;
import com.swarajtraders.inventory_management.party.repository.PartyRepository;
import com.swarajtraders.inventory_management.purchase.dto.PurchaseEntryRequest;
import com.swarajtraders.inventory_management.purchase.entity.PurchaseEntry;
import com.swarajtraders.inventory_management.purchase.service.PurchaseEntryService;
import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/purchase-entry")
public class PurchaseEntryController {
    
    @Autowired
    private PurchaseEntryService purchaseEntryService;
    
    @Autowired
    private PartyRepository partyRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("")
    public String showPurchaseEntryPage(Model model) {
        // Add user information to model
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        User user = userRepository.findByUserName(username);
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("name", username);
        }
        
        return "purchaseEntry";
    }
    
    @GetMapping("/api/parties")
    @ResponseBody
    public ResponseEntity<List<Party>> getAllParties() {
        try {
            System.out.println("getAllParties endpoint called");
            
            Iterable<Party> partyIterable = partyRepository.findAll();
            List<Party> parties = new ArrayList<>();
            partyIterable.forEach(parties::add);
            
            // Log for debugging
            System.out.println("Found " + parties.size() + " parties");
            parties.forEach(party -> System.out.println("Party: " + party.getPartyName() + " (ID: " + party.getPartyId() + ")"));
            
            return ResponseEntity.ok(parties);
        } catch (Exception e) {
            System.err.println("Error loading parties: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    
    // Test endpoint to verify the controller is working
    @GetMapping("/api/test")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> testEndpoint() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "PurchaseEntryController is working");
        response.put("timestamp", System.currentTimeMillis());
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/api/purchase-entry")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> savePurchaseEntry(@RequestBody PurchaseEntryRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Find party
            Optional<Party> partyOpt = partyRepository.findById(request.getPartyId());
            if (!partyOpt.isPresent()) {
                response.put("success", false);
                response.put("message", "Party not found");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Create purchase entry
            PurchaseEntry purchaseEntry = PurchaseEntry.builder()
                .party(partyOpt.get())
                .itemCode(request.getItemCode())
                .itemName(request.getItemName())
                .category(request.getCategory())
                .subCategory(request.getSubCategory())
                .quantity(request.getQuantity())
                .wholesalePrice(request.getWholesalePrice())
                .purchasePrice(request.getPurchasePrice())
                .discountPercentage(request.getDiscountPercentage())
                .build();
            
            // Validate purchase entry
            if (!purchaseEntryService.validatePurchaseEntry(purchaseEntry)) {
                response.put("success", false);
                response.put("message", "Invalid purchase entry data");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Save purchase entry
            PurchaseEntry savedEntry = purchaseEntryService.savePurchaseEntry(purchaseEntry);
            
            response.put("success", true);
            response.put("message", "Purchase entry saved successfully");
            response.put("purchaseId", savedEntry.getPurchaseId());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error saving purchase entry: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    @PostMapping("/api/purchase-entries-bulk")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveBulkPurchaseEntries(@RequestBody List<PurchaseEntryRequest> requests) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (requests == null || requests.isEmpty()) {
                response.put("success", false);
                response.put("message", "No purchase entries to save");
                return ResponseEntity.badRequest().body(response);
            }
            
            List<Long> savedIds = new ArrayList<>();
            List<String> errors = new ArrayList<>();
            
            for (int i = 0; i < requests.size(); i++) {
                PurchaseEntryRequest request = requests.get(i);
                try {
                    // Find party
                    Optional<Party> partyOpt = partyRepository.findById(request.getPartyId());
                    if (!partyOpt.isPresent()) {
                        errors.add("Entry " + (i + 1) + ": Party not found");
                        continue;
                    }
                    
                    // Create purchase entry
                    PurchaseEntry purchaseEntry = PurchaseEntry.builder()
                        .party(partyOpt.get())
                        .itemCode(request.getItemCode())
                        .itemName(request.getItemName())
                        .category(request.getCategory())
                        .subCategory(request.getSubCategory())
                        .quantity(request.getQuantity())
                        .wholesalePrice(request.getWholesalePrice())
                        .purchasePrice(request.getPurchasePrice())
                        .discountPercentage(request.getDiscountPercentage())
                        .build();
                    
                    // Validate purchase entry
                    if (!purchaseEntryService.validatePurchaseEntry(purchaseEntry)) {
                        errors.add("Entry " + (i + 1) + ": Invalid data");
                        continue;
                    }
                    
                    // Save purchase entry
                    PurchaseEntry savedEntry = purchaseEntryService.savePurchaseEntry(purchaseEntry);
                    savedIds.add(savedEntry.getPurchaseId());
                    
                } catch (Exception e) {
                    errors.add("Entry " + (i + 1) + ": " + e.getMessage());
                }
            }
            
            if (savedIds.isEmpty() && !errors.isEmpty()) {
                response.put("success", false);
                response.put("message", "All entries failed to save");
                response.put("errors", errors);
                return ResponseEntity.badRequest().body(response);
            }
            
            response.put("success", true);
            response.put("message", savedIds.size() + " entries saved successfully");
            response.put("savedIds", savedIds);
            if (!errors.isEmpty()) {
                response.put("errors", errors);
                response.put("partialSuccess", true);
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error saving bulk purchase entries: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    @GetMapping("/list")
    public String showPurchaseEntryList(Model model) {
        // Add user information to model
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        User user = userRepository.findByUserName(username);
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("name", username);
        }
        
        List<PurchaseEntry> purchaseEntries = purchaseEntryService.getAllPurchaseEntries();
        model.addAttribute("purchaseEntries", purchaseEntries);
        return "purchaseEntryList";
    }
    
    @GetMapping("/details")
    public String showPurchaseDetails(Model model) {
        // Add user information to model
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        User user = userRepository.findByUserName(username);
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("name", username);
        }
        
        // Get all parties for filter dropdown
        Iterable<Party> partyIterable = partyRepository.findAll();
        List<Party> parties = new ArrayList<>();
        partyIterable.forEach(parties::add);
        model.addAttribute("parties", parties);
        
        return "purchaseDetails";
    }
    
    @GetMapping("/api/purchase-entries")
    @ResponseBody
    public ResponseEntity<List<PurchaseEntry>> getAllPurchaseEntries() {
        List<PurchaseEntry> purchaseEntries = purchaseEntryService.getAllPurchaseEntries();
        return ResponseEntity.ok(purchaseEntries);
    }
    
    @GetMapping("/api/purchase-entries/party/{partyId}")
    @ResponseBody
    public ResponseEntity<List<PurchaseEntry>> getPurchaseEntriesByParty(@PathVariable Long partyId) {
        List<PurchaseEntry> purchaseEntries = purchaseEntryService.getPurchaseEntriesByParty(partyId);
        return ResponseEntity.ok(purchaseEntries);
    }
    
    @GetMapping("/api/purchase-entries/item/{itemCode}")
    @ResponseBody
    public ResponseEntity<List<PurchaseEntry>> getPurchaseEntriesByItemCode(@PathVariable String itemCode) {
        List<PurchaseEntry> purchaseEntries = purchaseEntryService.getPurchaseEntriesByItemCode(itemCode);
        return ResponseEntity.ok(purchaseEntries);
    }
}
