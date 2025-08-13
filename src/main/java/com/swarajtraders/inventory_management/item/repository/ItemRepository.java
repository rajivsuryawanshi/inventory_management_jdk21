package com.swarajtraders.inventory_management.item.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.swarajtraders.inventory_management.item.entity.Item;

@Repository
public interface ItemRepository extends CrudRepository<Item, Long> {
	
	// Find item by itemCode for bulk upload duplicate checking
	java.util.Optional<Item> findByItemCode(String itemCode);
	
	// Check if item exists by itemCode
	boolean existsByItemCode(String itemCode);
}
