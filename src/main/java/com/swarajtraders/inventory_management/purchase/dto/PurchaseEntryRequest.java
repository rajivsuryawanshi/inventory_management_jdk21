package com.swarajtraders.inventory_management.purchase.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PurchaseEntryRequest {
    
    @NotNull(message = "Party ID is required")
    private Long partyId;
    
    @NotEmpty(message = "Item Code is required")
    private String itemCode;
    
    @NotEmpty(message = "Item Name is required")
    private String itemName;
    
    @NotEmpty(message = "Category is required")
    private String category;
    
    @NotEmpty(message = "Sub Category is required")
    private String subCategory;
    
    @NotNull(message = "Quantity is required")
    @DecimalMin(value = "1.0", inclusive = true, message = "Quantity must be at least 1")
    private BigDecimal quantity;
    
    @NotNull(message = "Wholesale Price is required")
    @DecimalMin(value = "0.01", inclusive = false, message = "Wholesale Price must be greater than 0")
    private BigDecimal wholesalePrice;
    
    @NotNull(message = "Purchase Price is required")
    @DecimalMin(value = "0.01", inclusive = false, message = "Purchase Price must be greater than 0")
    private BigDecimal purchasePrice;
    
    private BigDecimal discountPercentage;
}
