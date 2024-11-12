package com.swarajtraders.inventory_management.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;
import com.swarajtraders.inventory_management.util.InventoryUtil;

@Service
public class AuthenticationService {

	@Autowired
	private UserRepository userRepository;

	public User authenticate(String userName, String password) {

		if (InventoryUtil.isValidString(userName) && InventoryUtil.isValidString(password)) {
			Iterable<User> userList = userRepository.findAll();
			for (User user : userList) {
				if (InventoryUtil.isValidString(user.getUserName()) && InventoryUtil.isValidString(user.getPassword())
						&& userName.equals(user.getUserName()) && password.equals(user.getPassword())) {
					return user;
				}
			}
		}
		return null;
	}
}
