package com.swarajtraders.inventory_management.user.service;

import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;
import com.swarajtraders.inventory_management.util.InventoryUtil;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByUserName(username);
		if (user == null) {
			throw new UsernameNotFoundException("User not found with username: " + username);
		}
		return user;
	}
	
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

	public User authenticate(String userName, String password) {
		if (InventoryUtil.isValidString(userName) && InventoryUtil.isValidString(password)) {
	        // Create a predicate for user validation
	        Predicate<User> isValidUser = user ->
	            InventoryUtil.isValidString(user.getUserName()) &&
	            InventoryUtil.isValidString(user.getPassword()) &&
	            userName.equals(user.getUserName()) &&
	            password.equals(user.getPassword());

	        // Stream through the userList and filter based on the predicate
	        Iterable<User> userList = userRepository.findAll();
	        return StreamSupport.stream(userList.spliterator(), false)
	                .filter(isValidUser)
	                .findFirst()
	                .orElse(null);  // return null if no matching user is found
	    }
		return null;
	}
}
