package com.swarajtraders.inventory_management.item.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Item {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long itemId;

    @NotEmpty(message = "Item Name is required")
    @Size(min = 2, max = 100, message = "Item Name must be between 2 and 100 characters")
    private String itemName;

    @NotEmpty(message = "Item Code is required")
    @Size(min = 3, max = 20, message = "Item Code must be between 3 and 20 characters")
    private String itemCode;

    @NotEmpty(message = "Category is required")
    @Size(min = 2, max = 50, message = "Category must be between 2 and 50 characters")
    private String category;

    @NotEmpty(message = "Sub Category is required")
    @Size(min = 2, max = 50, message = "Sub Category must be between 2 and 50 characters")
    private String subCategory;

    @NotNull(message = "Wholesale Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Wholesale Price must be greater than 0")
    private BigDecimal wholesalePrice;

    @NotNull(message = "Purchase Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Purchase Price must be greater than 0")
    private BigDecimal purchasePrice;

    @NotNull(message = "Sale Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Sale Price must be greater than 0")
    private BigDecimal salePrice;

    // Getters and Setters
    
    public Long getItemId() {
    	return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public BigDecimal getWholesalePrice() {
        return wholesalePrice;
    }

    public void setWholesalePrice(BigDecimal wholesalePrice) {
        this.wholesalePrice = wholesalePrice;
    }

    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }
}
