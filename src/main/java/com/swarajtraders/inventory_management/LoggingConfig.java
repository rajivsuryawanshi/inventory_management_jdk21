package com.swarajtraders.inventory_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Component
public class LoggingConfig implements CommandLineRunner {
    
    private static final Logger logger = LoggerFactory.getLogger(LoggingConfig.class);
    
    @Value("${logging.file.path:/data/logs}")
    private String logPath;
    
    @Override
    public void run(String... args) throws Exception {
        initializeLogDirectory();
    }
    
    private void initializeLogDirectory() {
        try {
            Path logDir = Paths.get(logPath);
            
            if (!Files.exists(logDir)) {
                Files.createDirectories(logDir);
                logger.info("Created log directory: {}", logPath);
            } else {
                logger.info("Log directory already exists: {}", logPath);
            }
            
            // Test if the directory is writable
            File testFile = new File(logDir.toFile(), "test-write.tmp");
            if (testFile.createNewFile()) {
                testFile.delete();
                logger.info("Log directory is writable: {}", logPath);
            } else {
                logger.warn("Log directory may not be writable: {}", logPath);
            }
            
        } catch (Exception e) {
            logger.error("Failed to initialize log directory: {}", logPath, e);
            // Fallback to system temp directory if configured directory fails
            try {
                String fallbackPath = System.getProperty("java.io.tmpdir") + "/inventory-logs";
                Path fallbackDir = Paths.get(fallbackPath);
                Files.createDirectories(fallbackDir);
                logger.info("Using fallback log directory: {}", fallbackPath);
            } catch (Exception fallbackException) {
                logger.error("Failed to create fallback log directory", fallbackException);
            }
        }
    }
}
