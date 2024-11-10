package com.swarajtraders.inventory_management.service;

import java.util.List;

import com.swarajtraders.inventory_management.entity.User;

public interface UserService {
	
	// save operation
    User saveUser(User user);
 
    // read operation
    List<User> fetchUserList();
 
    // update operation
    User updateUser(User user, Long userId);
 
    // delete operation
    void deleteUserById(Long userId);
    
}
