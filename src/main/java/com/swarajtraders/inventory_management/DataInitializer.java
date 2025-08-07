package com.swarajtraders.inventory_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        // Create a default user if no users exist
        if (userRepository.count() == 0) {
            User defaultUser = new User("admin", passwordEncoder.encode("admin"), "ADMIN");
            userRepository.save(defaultUser);
            System.out.println("Default user created: admin/admin");
        }
    }
}
