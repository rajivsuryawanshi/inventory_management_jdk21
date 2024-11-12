package com.swarajtraders.inventory_management.user.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.swarajtraders.inventory_management.user.entity.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

}
