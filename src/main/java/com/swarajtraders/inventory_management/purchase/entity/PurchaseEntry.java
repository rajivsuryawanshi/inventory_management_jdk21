package com.swarajtraders.inventory_management.purchase.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "purchase_entries")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PurchaseEntry {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long purchaseId;
    
    @NotNull(message = "Party is required")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "party_id", nullable = false)
    private com.swarajtraders.inventory_management.party.entity.Party party;
    
    @NotNull(message = "Item Code is required")
    @Column(name = "item_code", nullable = false)
    private String itemCode;
    
    @NotNull(message = "Item Name is required")
    @Column(name = "item_name", nullable = false)
    private String itemName;
    
    @NotNull(message = "Category is required")
    @Column(name = "category", nullable = false)
    private String category;
    
    @NotNull(message = "Sub Category is required")
    @Column(name = "sub_category", nullable = false)
    private String subCategory;
    
    @NotNull(message = "Quantity is required")
    @DecimalMin(value = "1.0", inclusive = true, message = "Quantity must be at least 1")
    @Column(name = "quantity", nullable = false)
    private BigDecimal quantity;
    
    @NotNull(message = "Wholesale Price is required")
    @DecimalMin(value = "0.01", inclusive = false, message = "Wholesale Price must be greater than 0")
    @Column(name = "wholesale_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal wholesalePrice;
    
    @NotNull(message = "Purchase Price is required")
    @DecimalMin(value = "0.01", inclusive = false, message = "Purchase Price must be greater than 0")
    @Column(name = "purchase_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal purchasePrice;
    
    @Column(name = "discount_percentage", precision = 5, scale = 2)
    private BigDecimal discountPercentage;
    
    @Column(name = "total_amount", precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Column(name = "purchase_date", nullable = false)
    private LocalDateTime purchaseDate;
    
    @PrePersist
    protected void onCreate() {
        purchaseDate = LocalDateTime.now();
        calculateTotal();
    }
    
    @PreUpdate
    protected void onUpdate() {
        calculateTotal();
    }
    
    private void calculateTotal() {
        if (quantity != null && purchasePrice != null) {
            BigDecimal subtotal = quantity.multiply(purchasePrice);
            if (discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal discountAmount = subtotal.multiply(discountPercentage).divide(BigDecimal.valueOf(100));
                totalAmount = subtotal.subtract(discountAmount);
            } else {
                totalAmount = subtotal;
            }
        }
    }
}
