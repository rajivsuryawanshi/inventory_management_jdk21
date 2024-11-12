package com.swarajtraders.inventory_management.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	public User saveUser(User user) {
		return userRepository.save(user);
	}

	public List<User> fetchUserList() {
		return (List<User>) userRepository.findAll();
	}

	public User updateUser(User user, Long userId) {
		User userDB = userRepository.findById(userId).get();

		if (Objects.nonNull(user.getUserName()) && !"".equalsIgnoreCase(user.getUserName())) {
			userDB.setUserName(user.getUserName());
		}

		if (Objects.nonNull(user.getPassword()) && !"".equalsIgnoreCase(user.getPassword())) {
			userDB.setPassword(user.getPassword());
		}

		if (Objects.nonNull(user.getUserType()) && !"".equalsIgnoreCase(user.getUserType())) {
			userDB.setUserType(user.getUserType());
		}
		return userRepository.save(userDB);
	}

	public void deleteUserById(Long userId) {
		userRepository.deleteById(userId);
	}

}
