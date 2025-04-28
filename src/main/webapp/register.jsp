<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Bank - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            max-width: 500px;
            width: 100%;
            padding: 2rem;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-header {
            background-color: #0d6efd;
            color: white;
            text-align: center;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.5rem;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-primary {
            padding: 0.75rem;
            font-weight: 500;
        }
        .invalid-feedback {
            display: none;
        }
        .was-validated .form-control:invalid ~ .invalid-feedback {
            display: block;
        }
        .password-strength {
            height: 5px;
            margin-top: 5px;
            border-radius: 3px;
            transition: all 0.3s ease;
        }
        .strength-weak {
            background-color: #dc3545;
            width: 25%;
        }
        .strength-medium {
            background-color: #ffc107;
            width: 50%;
        }
        .strength-strong {
            background-color: #28a745;
            width: 75%;
        }
        .strength-very-strong {
            background-color: #20c997;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0"><i class="fas fa-university me-2"></i>Online Bank</h3>
            </div>
            <div class="card-body p-4">
                <h4 class="text-center mb-4">Create Your Account</h4>
                <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                    <div class="row">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="name" name="name" required>
                                <div class="invalid-feedback">
                                    Please enter your name.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" 
                                   pattern="[0-9]{10}" required placeholder="Enter 10-digit phone number">
                            <div class="invalid-feedback">
                                Please enter a valid 10-digit phone number.
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required
                                   minlength="8" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$">
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                            <div class="invalid-feedback">
                                Password must be at least 8 characters long and contain uppercase, lowercase, and numbers.
                            </div>
                        </div>
                        <div class="password-strength mt-2" id="passwordStrength"></div>
                        <small class="text-muted">Password must contain at least 8 characters, including uppercase, lowercase, and numbers.</small>
                    </div>
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            <div class="invalid-feedback">
                                Passwords do not match.
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-user-plus me-2"></i>Register
                    </button>
                    <% if(request.getParameter("error") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getParameter("error") %>
                        </div>
                    <% } %>
                </form>
                <div class="text-center mt-3">
                    <p class="mb-0">Already have an account? 
                        <a href="login.jsp" class="text-decoration-none">Login here</a>
                    </p>
                    <a href="index.jsp" class="text-decoration-none mt-2 d-block">
                        <i class="fas fa-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        
                        // Check if passwords match
                        var password = document.getElementById('password')
                        var confirmPassword = document.getElementById('confirmPassword')
                        if (password.value !== confirmPassword.value) {
                            confirmPassword.setCustomValidity('Passwords do not match')
                            event.preventDefault()
                            event.stopPropagation()
                        } else {
                            confirmPassword.setCustomValidity('')
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
        })()

        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            var password = this.value;
            var strengthBar = document.getElementById('passwordStrength');
            
            // Reset classes
            strengthBar.className = 'password-strength';
            
            if (password.length === 0) {
                return;
            }
            
            var strength = 0;
            if (password.length >= 8) strength += 1;
            if (password.match(/[a-z]/)) strength += 1;
            if (password.match(/[A-Z]/)) strength += 1;
            if (password.match(/[0-9]/)) strength += 1;
            if (password.match(/[^a-zA-Z0-9]/)) strength += 1;
            
            switch(strength) {
                case 1:
                case 2:
                    strengthBar.classList.add('strength-weak');
                    break;
                case 3:
                    strengthBar.classList.add('strength-medium');
                    break;
                case 4:
                    strengthBar.classList.add('strength-strong');
                    break;
                case 5:
                    strengthBar.classList.add('strength-very-strong');
                    break;
            }
        });

        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            var passwordInput = document.getElementById('password');
            var icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>
