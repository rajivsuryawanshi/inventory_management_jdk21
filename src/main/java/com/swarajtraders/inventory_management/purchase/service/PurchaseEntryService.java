package com.swarajtraders.inventory_management.purchase.service;

import com.swarajtraders.inventory_management.item.entity.Item;
import com.swarajtraders.inventory_management.item.repository.ItemRepository;
import com.swarajtraders.inventory_management.party.entity.Party;
import com.swarajtraders.inventory_management.party.repository.PartyRepository;
import com.swarajtraders.inventory_management.purchase.entity.PurchaseEntry;
import com.swarajtraders.inventory_management.purchase.repository.PurchaseEntryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PurchaseEntryService {
    
    @Autowired
    private PurchaseEntryRepository purchaseEntryRepository;
    
    @Autowired
    private ItemRepository itemRepository;
    
    @Autowired
    private PartyRepository partyRepository;
    
    public PurchaseEntry savePurchaseEntry(PurchaseEntry purchaseEntry) {
        // Find or create item
        Item item = findOrCreateItem(purchaseEntry);
        
        // Update item prices
        updateItemPrices(item, purchaseEntry);
        
        // Save the purchase entry
        return purchaseEntryRepository.save(purchaseEntry);
    }
    
    private Item findOrCreateItem(PurchaseEntry purchaseEntry) {
        Optional<Item> existingItem = itemRepository.findByItemCode(purchaseEntry.getItemCode());
        
        if (existingItem.isPresent()) {
            return existingItem.get();
        } else {
            // Create new item with blank sale price
            Item newItem = Item.builder()
                .itemCode(purchaseEntry.getItemCode())
                .itemName(purchaseEntry.getItemName())
                .category(purchaseEntry.getCategory())
                .subCategory(purchaseEntry.getSubCategory())
                .wholesalePrice(purchaseEntry.getWholesalePrice())
                .purchasePrice(purchaseEntry.getPurchasePrice())
                .salePrice(BigDecimal.ZERO) // Blank sale price as requested
                .build();
            
            return itemRepository.save(newItem);
        }
    }
    
    private void updateItemPrices(Item item, PurchaseEntry purchaseEntry) {
        // Update wholesale price and purchase price
        item.setWholesalePrice(purchaseEntry.getWholesalePrice());
        item.setPurchasePrice(purchaseEntry.getPurchasePrice());
        
        // Keep sale price blank (as requested)
        item.setSalePrice(BigDecimal.ZERO);
        
        itemRepository.save(item);
    }
    
    public List<PurchaseEntry> getAllPurchaseEntries() {
        return purchaseEntryRepository.findAll();
    }
    
    public Optional<PurchaseEntry> getPurchaseEntryById(Long id) {
        return purchaseEntryRepository.findById(id);
    }
    
    public List<PurchaseEntry> getPurchaseEntriesByParty(Long partyId) {
        return purchaseEntryRepository.findByPartyPartyIdOrderByPurchaseDateDesc(partyId);
    }
    
    public List<PurchaseEntry> getPurchaseEntriesByItemCode(String itemCode) {
        return purchaseEntryRepository.findByItemCodeOrderByPurchaseDateDesc(itemCode);
    }
    
    public void deletePurchaseEntry(Long id) {
        purchaseEntryRepository.deleteById(id);
    }
    
    public boolean validatePurchaseEntry(PurchaseEntry purchaseEntry) {
        // Validate party exists
        if (purchaseEntry.getParty() == null || purchaseEntry.getParty().getPartyId() == null) {
            return false;
        }
        
        Optional<Party> party = partyRepository.findById(purchaseEntry.getParty().getPartyId());
        if (!party.isPresent()) {
            return false;
        }
        
        // Validate required fields
        if (purchaseEntry.getItemCode() == null || purchaseEntry.getItemCode().trim().isEmpty() ||
            purchaseEntry.getItemName() == null || purchaseEntry.getItemName().trim().isEmpty() ||
            purchaseEntry.getCategory() == null || purchaseEntry.getCategory().trim().isEmpty() ||
            purchaseEntry.getSubCategory() == null || purchaseEntry.getSubCategory().trim().isEmpty() ||
            purchaseEntry.getQuantity() == null || purchaseEntry.getQuantity().compareTo(BigDecimal.ZERO) <= 0 ||
            purchaseEntry.getWholesalePrice() == null || purchaseEntry.getWholesalePrice().compareTo(BigDecimal.ZERO) <= 0 ||
            purchaseEntry.getPurchasePrice() == null || purchaseEntry.getPurchasePrice().compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        return true;
    }
}
