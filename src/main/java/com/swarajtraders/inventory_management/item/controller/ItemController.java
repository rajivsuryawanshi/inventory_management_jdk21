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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.validation.Valid;

import com.swarajtraders.inventory_management.item.entity.Item;
import com.swarajtraders.inventory_management.item.repository.ItemRepository;
import com.swarajtraders.inventory_management.item.service.BulkUploadService;
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
	
	@Autowired
	private BulkUploadService bulkUploadService;

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
	public String listItems(Model model, @RequestParam(value = "message", required = false) String message) {
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
			
			// Add success message if present
			if (message != null && !message.isEmpty()) {
				model.addAttribute("message", message);
			}
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

	// Show the Edit Item Form
	@GetMapping("/editItem")
	public String showEditItemForm(@RequestParam("itemId") Long itemId, Model model) {
		logger.info("Showing edit item form for ID: {}", itemId);
		
		// Add user information to model
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userRepository.findByUserName(username);
		if (user != null) {
			model.addAttribute("user", user);
			model.addAttribute("name", username);
		}
		
		try {
			java.util.Optional<Item> itemOptional = itemRepository.findById(itemId);
			if (itemOptional.isPresent()) {
				Item item = itemOptional.get();
				model.addAttribute("item", item);
				model.addAttribute("isEdit", true);
				logger.info("Found item to edit: {}", item.getItemName());
				return "editItem"; // JSP view name
			} else {
				logger.warn("Item not found with ID: {}", itemId);
				model.addAttribute("error", "Item not found!");
				return "redirect:/items";
			}
		} catch (Exception e) {
			logger.error("Error fetching item for editing", e);
			model.addAttribute("error", "Error loading item: " + e.getMessage());
			return "redirect:/items";
		}
	}

	// Handle the Edit Item Form submission
	@PostMapping("/editItem")
	public String handleEditItem(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {
		logger.info("Processing edit item request for ID: {}, Name: {}", item.getItemId(), item.getItemName());
		
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
			model.addAttribute("isEdit", true);
			
			// Create field-specific error mapping for better JSP display
			java.util.Map<String, String> fieldErrors = new java.util.HashMap<>();
			result.getFieldErrors().forEach(error -> {
				fieldErrors.put(error.getField(), error.getDefaultMessage());
			});
			model.addAttribute("fieldErrors", fieldErrors);
			
			return "editItem";
		}

		try {
			logger.info("Attempting to update item in database");
			Item savedItem = itemRepository.save(item);
			logger.info("Item updated successfully with ID: {}", savedItem.getItemId());
			
			// Add success message and redirect
			return "redirect:/items?message=Item updated successfully!";
		} catch (Exception e) {
			logger.error("Error updating item", e);
			
			// Add user information to model for re-display
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String username = authentication.getName();
			
			User user = userRepository.findByUserName(username);
			if (user != null) {
				model.addAttribute("user", user);
				model.addAttribute("name", username);
			}
			
			model.addAttribute("error", "Error updating item: " + e.getMessage());
			model.addAttribute("isEdit", true);
			return "editItem";
		}
	}

	// Bulk Upload CSV
	@PostMapping("/bulkUploadCSV")
	public String bulkUploadCSV(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
		logger.info("Processing CSV bulk upload");
		
		if (file.isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "Please select a file to upload");
			return "redirect:/addItem";
		}
		
		if (!file.getOriginalFilename().toLowerCase().endsWith(".csv")) {
			redirectAttributes.addFlashAttribute("error", "Please upload a CSV file");
			return "redirect:/addItem";
		}
		
		try {
			BulkUploadService.BulkUploadResult result = bulkUploadService.processCSVFile(file);
			
			if (result.hasErrors()) {
				if (result.getGeneralError() != null) {
					redirectAttributes.addFlashAttribute("error", result.getGeneralError());
				} else {
					redirectAttributes.addFlashAttribute("error", "Upload completed with errors. Check the details below.");
					redirectAttributes.addFlashAttribute("uploadErrors", result.getErrors());
				}
			}
			
			String message = String.format("Bulk upload completed! Created: %d, Updated: %d, Total: %d", 
				result.getCreated(), result.getUpdated(), result.getTotalProcessed());
			redirectAttributes.addFlashAttribute("message", message);
			
		} catch (Exception e) {
			logger.error("Error processing CSV bulk upload", e);
			redirectAttributes.addFlashAttribute("error", "Error processing file: " + e.getMessage());
		}
		
		return "redirect:/addItem";
	}

	// Bulk Upload Excel
	@PostMapping("/bulkUploadExcel")
	public String bulkUploadExcel(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
		logger.info("Processing Excel bulk upload");
		
		if (file.isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "Please select a file to upload");
			return "redirect:/addItem";
		}
		
		String filename = file.getOriginalFilename().toLowerCase();
		if (!filename.endsWith(".xlsx") && !filename.endsWith(".xls")) {
			redirectAttributes.addFlashAttribute("error", "Please upload an Excel file (.xlsx or .xls)");
			return "redirect:/addItem";
		}
		
		try {
			BulkUploadService.BulkUploadResult result = bulkUploadService.processExcelFile(file);
			
			if (result.hasErrors()) {
				if (result.getGeneralError() != null) {
					redirectAttributes.addFlashAttribute("error", result.getGeneralError());
				} else {
					redirectAttributes.addFlashAttribute("error", "Upload completed with errors. Check the details below.");
					redirectAttributes.addFlashAttribute("uploadErrors", result.getErrors());
				}
			}
			
			String message = String.format("Bulk upload completed! Created: %d, Updated: %d, Total: %d", 
				result.getCreated(), result.getUpdated(), result.getTotalProcessed());
			redirectAttributes.addFlashAttribute("message", message);
			
		} catch (Exception e) {
			logger.error("Error processing Excel bulk upload", e);
			redirectAttributes.addFlashAttribute("error", "Error processing file: " + e.getMessage());
		}
		
		return "redirect:/addItem";
	}

	// Download CSV Template
	@GetMapping("/downloadCSVTemplate")
	public void downloadCSVTemplate(HttpServletResponse response) throws IOException {
		logger.info("Downloading CSV template");
		
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"items_template.csv\"");
		
		try (PrintWriter writer = response.getWriter()) {
			writer.println("ItemName,ItemCode,Category,SubCategory,WholesalePrice,PurchasePrice,SalePrice");
			writer.println("Sample Item,ITEM001,Electronics,Smartphones,500.00,400.00,600.00");
			writer.println("Another Item,ITEM002,Clothing,T-Shirts,25.00,20.00,30.00");
		}
	}

	// Download Excel Template
	@GetMapping("/downloadExcelTemplate")
	public void downloadExcelTemplate(HttpServletResponse response) throws IOException {
		logger.info("Downloading Excel template");
		
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=\"items_template.xlsx\"");
		
		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("Items");
			
			// Create header row
			Row headerRow = sheet.createRow(0);
			String[] headers = {"ItemName", "ItemCode", "Category", "SubCategory", "WholesalePrice", "PurchasePrice", "SalePrice"};
			for (int i = 0; i < headers.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(headers[i]);
			}
			
			// Create sample data rows
			String[][] sampleData = {
				{"Sample Item", "ITEM001", "Electronics", "Smartphones", "500.00", "400.00", "600.00"},
				{"Another Item", "ITEM002", "Clothing", "T-Shirts", "25.00", "20.00", "30.00"}
			};
			
			for (int i = 0; i < sampleData.length; i++) {
				Row row = sheet.createRow(i + 1);
				for (int j = 0; j < sampleData[i].length; j++) {
					Cell cell = row.createCell(j);
					cell.setCellValue(sampleData[i][j]);
				}
			}
			
			// Auto-size columns
			for (int i = 0; i < headers.length; i++) {
				sheet.autoSizeColumn(i);
			}
			
			workbook.write(response.getOutputStream());
		}
	}
}
