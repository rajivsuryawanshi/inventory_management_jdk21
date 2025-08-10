<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swaraj Traders - Login</title>
    
    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="/swarajtraders/css/modern-ui.css">
    
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container" style="max-width: 500px; margin: 2rem auto; text-align: center;">
        <div class="card">
            <div class="logo" style="font-size: 2.5rem; font-weight: 700; color: var(--dark-color); margin-bottom: 0.5rem; display: flex; align-items: center; justify-content: center; gap: 0.75rem;">
                <i class="fas fa-store" style="color: var(--primary-color);"></i>
                Swaraj Traders
            </div>
            <div class="subtitle" style="color: var(--text-secondary); margin-bottom: 2.5rem; font-size: 1.1rem; font-weight: 500;">Inventory Management System</div>
            
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> ${message}
                </div>
            </c:if>
            
            <!-- Login Form -->
            <form action="/swarajtraders/perform_login" method="post" id="loginForm">
                <div class="form-section">
                    <div class="form-group">
                        <label for="username" class="form-label">
                            <i class="fas fa-user"></i> Username
                        </label>
                        <input type="text" id="username" name="username" class="form-control" required 
                               placeholder="Enter your username" autocomplete="username">
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <input type="password" id="password" name="password" class="form-control" required 
                               placeholder="Enter your password" autocomplete="current-password">
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-lg" id="submitBtn" style="width: 100%; margin-top: 1rem;">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>
                </div>
            </form>
            
            <div class="footer" style="margin-top: 2rem; color: var(--text-secondary); font-size: 0.875rem; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
                <p>&copy; 2025 Swaraj Traders. All rights reserved.</p>
            </div>
        </div>
    </div>
    
    <script>
        // Auto-focus on username field
        document.getElementById('username').focus();
        
        // Enhanced form interactions
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });

            // Add floating label effect
            input.addEventListener('input', function() {
                if (this.value) {
                    this.classList.add('has-value');
                } else {
                    this.classList.remove('has-value');
                }
            });
        });

        // Form submission with loading state
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
        });

        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                container.style.transition = 'all 0.5s ease-out';
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>
