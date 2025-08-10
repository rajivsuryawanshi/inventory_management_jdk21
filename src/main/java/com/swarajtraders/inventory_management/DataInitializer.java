package com.swarajtraders.inventory_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.swarajtraders.inventory_management.user.entity.User;
import com.swarajtraders.inventory_management.user.repository.UserRepository;
import com.swarajtraders.inventory_management.item.entity.Item;
import com.swarajtraders.inventory_management.item.repository.ItemRepository;
import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ItemRepository itemRepository;

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

        // Create sample items if no items exist
        if (itemRepository.count() == 0) {
            Item sampleItem1 = Item.builder()
                .itemName("Sample Product 1")
                .itemCode("SP001")
                .category("Electronics")
                .subCategory("Mobile Phones")
                .wholesalePrice(new BigDecimal("15000.00"))
                .purchasePrice(new BigDecimal("16000.00"))
                .salePrice(new BigDecimal("18000.00"))
                .build();
            itemRepository.save(sampleItem1);

            Item sampleItem2 = Item.builder()
                .itemName("Sample Product 2")
                .itemCode("SP002")
                .category("Electronics")
                .subCategory("Laptops")
                .wholesalePrice(new BigDecimal("45000.00"))
                .purchasePrice(new BigDecimal("48000.00"))
                .salePrice(new BigDecimal("52000.00"))
                .build();
            itemRepository.save(sampleItem2);

            System.out.println("Sample items created");
        }
    }
}
