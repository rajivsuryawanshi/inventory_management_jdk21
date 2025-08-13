package com.swarajtraders.inventory_management.item.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import com.swarajtraders.inventory_management.item.entity.Item;
import com.swarajtraders.inventory_management.item.repository.ItemRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class BulkUploadService {

    private static final Logger logger = LoggerFactory.getLogger(BulkUploadService.class);

    @Autowired
    private ItemRepository itemRepository;

    public BulkUploadResult processCSVFile(MultipartFile file) {
        BulkUploadResult result = new BulkUploadResult();
        
        try (CSVReader reader = new CSVReader(new InputStreamReader(file.getInputStream()))) {
            String[] header = reader.readNext(); // Skip header row
            
            if (header == null || header.length < 7) {
                result.setError("Invalid CSV format. Expected columns: ItemName, ItemCode, Category, SubCategory, WholesalePrice, PurchasePrice, SalePrice");
                return result;
            }
            
            String[] line;
            int rowNumber = 1; // Start from 1 since we skipped header
            
            while ((line = reader.readNext()) != null) {
                rowNumber++;
                try {
                    Item item = parseCSVLine(line, rowNumber);
                    if (item != null) {
                        processItem(item, result);
                    }
                } catch (Exception e) {
                    result.addError("Row " + rowNumber + ": " + e.getMessage());
                }
            }
            
        } catch (IOException | CsvValidationException e) {
            logger.error("Error processing CSV file", e);
            result.setError("Error reading CSV file: " + e.getMessage());
        }
        
        return result;
    }

    public BulkUploadResult processExcelFile(MultipartFile file) {
        BulkUploadResult result = new BulkUploadResult();
        
        try (InputStream is = file.getInputStream();
             Workbook workbook = new XSSFWorkbook(is)) {
            
            Sheet sheet = workbook.getSheetAt(0);
            Row headerRow = sheet.getRow(0);
            
            if (headerRow == null || headerRow.getLastCellNum() < 7) {
                result.setError("Invalid Excel format. Expected columns: ItemName, ItemCode, Category, SubCategory, WholesalePrice, PurchasePrice, SalePrice");
                return result;
            }
            
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    try {
                        Item item = parseExcelRow(row, i + 1);
                        if (item != null) {
                            processItem(item, result);
                        }
                    } catch (Exception e) {
                        result.addError("Row " + (i + 1) + ": " + e.getMessage());
                    }
                }
            }
            
        } catch (IOException e) {
            logger.error("Error processing Excel file", e);
            result.setError("Error reading Excel file: " + e.getMessage());
        }
        
        return result;
    }

    private Item parseCSVLine(String[] line, int rowNumber) {
        if (line.length < 7) {
            throw new IllegalArgumentException("Insufficient columns. Expected 7 columns.");
        }
        
        String itemName = line[0].trim();
        String itemCode = line[1].trim();
        String category = line[2].trim();
        String subCategory = line[3].trim();
        String wholesalePriceStr = line[4].trim();
        String purchasePriceStr = line[5].trim();
        String salePriceStr = line[6].trim();
        
        // Validate required fields
        if (itemName.isEmpty() || itemCode.isEmpty() || category.isEmpty() || subCategory.isEmpty()) {
            throw new IllegalArgumentException("Required fields cannot be empty");
        }
        
        // Parse prices
        BigDecimal wholesalePrice = parsePrice(wholesalePriceStr, "Wholesale Price");
        BigDecimal purchasePrice = parsePrice(purchasePriceStr, "Purchase Price");
        BigDecimal salePrice = parsePrice(salePriceStr, "Sale Price");
        
        return Item.builder()
                .itemName(itemName)
                .itemCode(itemCode)
                .category(category)
                .subCategory(subCategory)
                .wholesalePrice(wholesalePrice)
                .purchasePrice(purchasePrice)
                .salePrice(salePrice)
                .build();
    }

    private Item parseExcelRow(Row row, int rowNumber) {
        if (row.getLastCellNum() < 7) {
            throw new IllegalArgumentException("Insufficient columns. Expected 7 columns.");
        }
        
        String itemName = getCellValueAsString(row.getCell(0));
        String itemCode = getCellValueAsString(row.getCell(1));
        String category = getCellValueAsString(row.getCell(2));
        String subCategory = getCellValueAsString(row.getCell(3));
        String wholesalePriceStr = getCellValueAsString(row.getCell(4));
        String purchasePriceStr = getCellValueAsString(row.getCell(5));
        String salePriceStr = getCellValueAsString(row.getCell(6));
        
        // Validate required fields
        if (itemName.isEmpty() || itemCode.isEmpty() || category.isEmpty() || subCategory.isEmpty()) {
            throw new IllegalArgumentException("Required fields cannot be empty");
        }
        
        // Parse prices
        BigDecimal wholesalePrice = parsePrice(wholesalePriceStr, "Wholesale Price");
        BigDecimal purchasePrice = parsePrice(purchasePriceStr, "Purchase Price");
        BigDecimal salePrice = parsePrice(salePriceStr, "Sale Price");
        
        return Item.builder()
                .itemName(itemName)
                .itemCode(itemCode)
                .category(category)
                .subCategory(subCategory)
                .wholesalePrice(wholesalePrice)
                .purchasePrice(purchasePrice)
                .salePrice(salePrice)
                .build();
    }

    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    return String.valueOf(cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }

    private BigDecimal parsePrice(String priceStr, String fieldName) {
        if (priceStr == null || priceStr.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " cannot be empty");
        }
        
        try {
            BigDecimal price = new BigDecimal(priceStr.trim());
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException(fieldName + " must be greater than 0");
            }
            return price;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(fieldName + " must be a valid number");
        }
    }

    private void processItem(Item item, BulkUploadResult result) {
        try {
            // Check if item already exists by itemCode
            Optional<Item> existingItem = itemRepository.findByItemCode(item.getItemCode());
            
            if (existingItem.isPresent()) {
                // Update existing item
                Item existing = existingItem.get();
                existing.setItemName(item.getItemName());
                existing.setCategory(item.getCategory());
                existing.setSubCategory(item.getSubCategory());
                existing.setWholesalePrice(item.getWholesalePrice());
                existing.setPurchasePrice(item.getPurchasePrice());
                existing.setSalePrice(item.getSalePrice());
                
                itemRepository.save(existing);
                result.incrementUpdated();
                logger.info("Updated existing item: {}", item.getItemCode());
            } else {
                // Create new item
                itemRepository.save(item);
                result.incrementCreated();
                logger.info("Created new item: {}", item.getItemCode());
            }
            
        } catch (Exception e) {
            logger.error("Error processing item: {}", item.getItemCode(), e);
            result.addError("Error processing item " + item.getItemCode() + ": " + e.getMessage());
        }
    }

    // Result class to track upload statistics
    public static class BulkUploadResult {
        private int created = 0;
        private int updated = 0;
        private List<String> errors = new ArrayList<>();
        private String generalError = null;

        public void incrementCreated() {
            created++;
        }

        public void incrementUpdated() {
            updated++;
        }

        public void addError(String error) {
            errors.add(error);
        }

        public void setError(String error) {
            this.generalError = error;
        }

        // Getters
        public int getCreated() { return created; }
        public int getUpdated() { return updated; }
        public List<String> getErrors() { return errors; }
        public String getGeneralError() { return generalError; }
        public boolean hasErrors() { return generalError != null || !errors.isEmpty(); }
        public int getTotalProcessed() { return created + updated; }
    }
}
