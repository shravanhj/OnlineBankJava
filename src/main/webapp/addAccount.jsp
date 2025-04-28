<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Bank - Add Account</title>
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
    </style>
</head>
<body>
    <%
    // Check if user is logged in
    if (session.getAttribute("phoneNumber") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

    <div class="register-container">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0"><i class="fas fa-university me-2"></i>Online Bank</h3>
            </div>
            <div class="card-body p-4">
                <h4 class="text-center mb-4">Add New Account</h4>
                <form action="${pageContext.request.contextPath}/addAccount" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="accountNumber" class="form-label">Account Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-wallet"></i></span>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required placeholder="Enter account number">
                            <div class="invalid-feedback">
                                Please enter an account number.
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="balance" class="form-label">Initial Balance</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
                            <input type="number" class="form-control" id="balance" name="balance" 
                                   min="0" step="0.01" required placeholder="Enter initial balance">
                            <div class="invalid-feedback">
                                Please enter a valid initial balance.
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-plus me-2"></i>Create Account
                    </button>
                    <% if(request.getParameter("error") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getParameter("error") %>
                        </div>
                    <% } %>
                </form>
                <div class="text-center mt-3">
                    <a href="dashboard.jsp" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
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
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>
