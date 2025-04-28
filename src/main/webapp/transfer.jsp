<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bankapp.model.Account" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Bank - Fund Transfer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .main-content {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .register-container {
            max-width: 500px;
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
        .form-control, .form-select {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            height: 2.5rem;
        }
        .form-control:focus, .form-select:focus {
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
        .sidebar {
            background-color: #0d6efd;
            color: white;
            height: 100vh;
            position: fixed;
            padding-top: 20px;
            width: 250px;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.8rem 1rem;
            margin: 0.2rem 0;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        .sidebar .nav-link i {
            width: 20px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <%
        if (session.getAttribute("phoneNumber") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="main-content">
        <div class="register-container">
            <div class="card">
                <div class="card-header">
                    <h3>Online Bank</h3>
                </div>
                <div class="card-body">
                    <h4 class="text-center mb-4">Fund Transfer</h4>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success">
                            <%= request.getAttribute("success") %>
                        </div>
                    <% } %>
                    
                    <form action="transfer" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="fromAccount" class="form-label">From Account</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-wallet"></i></span>
                                <select class="form-select" id="fromAccount" name="fromAccount" required>
                                    <option value="">Select your account</option>
                                    <% 
                                    List<Account> userAccounts = (List<Account>) request.getAttribute("userAccounts");
                                    if (userAccounts != null) {
                                        for (Account account : userAccounts) {
                                    %>
                                        <option value="<%= account.getAccountId() %>">
                                            <%= account.getAccountNumber() %> - ₹<%= String.format("%,.2f", account.getBalance()) %>
                                        </option>
                                    <% 
                                        }
                                    }
                                    %>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="toAccount" class="form-label">To Account</label>
                            <select class="form-select" id="toAccount" name="toAccount" required>
                                <option value="">Select Beneficiary Account</option>
                                <c:forEach var="account" items="${allAccounts}">
                                    <option value="${account.accountId}">
                                        ${account.accountNumber} - ${account.beneficiaryName} (₹${account.balance})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="amount" class="form-label">Amount (₹)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
                                <input type="number" class="form-control" id="amount" name="amount" 
                                       step="0.01" min="0.01" required 
                                       placeholder="Enter amount in Indian Rupees">
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 mb-3">Verify & Complete Transfer</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <a href="dashboard.jsp">Back to Dashboard</a>
                    </div>
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
