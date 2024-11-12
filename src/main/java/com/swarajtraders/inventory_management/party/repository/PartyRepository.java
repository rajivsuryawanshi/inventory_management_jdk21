package com.swarajtraders.inventory_management.party.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.swarajtraders.inventory_management.party.entity.Party;

@Repository
public interface PartyRepository extends CrudRepository<Party, Long> {

}
