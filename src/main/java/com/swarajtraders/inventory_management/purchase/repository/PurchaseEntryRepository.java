package com.swarajtraders.inventory_management.purchase.repository;

import com.swarajtraders.inventory_management.purchase.entity.PurchaseEntry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PurchaseEntryRepository extends JpaRepository<PurchaseEntry, Long> {
    
    List<PurchaseEntry> findByPartyPartyIdOrderByPurchaseDateDesc(Long partyId);
    
    List<PurchaseEntry> findByItemCodeOrderByPurchaseDateDesc(String itemCode);
    
    @Query("SELECT p FROM PurchaseEntry p WHERE p.purchaseDate >= :startDate AND p.purchaseDate <= :endDate ORDER BY p.purchaseDate DESC")
    List<PurchaseEntry> findByPurchaseDateBetween(@Param("startDate") java.time.LocalDateTime startDate, 
                                                  @Param("endDate") java.time.LocalDateTime endDate);
    
    @Query("SELECT p FROM PurchaseEntry p WHERE p.party.partyName LIKE %:partyName% ORDER BY p.purchaseDate DESC")
    List<PurchaseEntry> findByPartyNameContaining(@Param("partyName") String partyName);
}
