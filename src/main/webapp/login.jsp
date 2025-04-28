<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Bank - Login</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 1.5rem;
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
            padding: 1rem;
        }
        .card-header h3 {
            margin: 0;
            font-weight: 600;
            font-size: 1.25rem;
        }
        .card-body {
            padding: 1.5rem;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            height: 2.5rem;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }
        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-right: none;
            border-radius: 6px 0 0 6px;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 0.5rem 1.25rem;
            border-radius: 6px;
            font-weight: 500;
            font-size: 0.9rem;
            height: 2.5rem;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .alert {
            border-radius: 6px;
            padding: 0.75rem;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        .text-center a {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
        }
        .text-center a:hover {
            text-decoration: underline;
        }
        .mb-3 {
            margin-bottom: 1rem !important;
        }
        .mb-4 {
            margin-bottom: 1.25rem !important;
        }
        .mt-3 {
            margin-top: 1rem !important;
        }
    </style>
</head>
<body>

    <!-- Login Section -->
    <section class="login-container">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0"><i class="fas fa-university me-2"></i>Online Bank</h3>
            </div>
            <div class="card-body p-4">
                <h4 class="text-center mb-4">Login to Your Account</h4>
                <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
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
                    <div class="mb-4">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div class="invalid-feedback">
                                Please enter your password.
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-sign-in-alt me-2"></i>Login
                    </button>
                    <% if(request.getParameter("error") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getParameter("error") %>
                        </div>
                    <% } %>
                </form>
                <div class="text-center mt-3">
                    <p class="mb-0">Don't have an account? 
                        <a href="register.jsp" class="text-decoration-none">Register here</a>
                    </p>
                    <a href="index.jsp" class="text-decoration-none mt-2 d-block">
                        <i class="fas fa-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </section>
    <!-- Bootstrap JS Bundle -->
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
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>
