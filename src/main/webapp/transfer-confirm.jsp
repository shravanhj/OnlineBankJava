<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Bank - Confirm Transfer</title>
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
        .confirm-container {
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
        .card-header h3 {
            margin: 0;
            font-weight: 600;
        }
        .card-body {
            padding: 2rem;
        }
        .transaction-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #dee2e6;
        }
        .detail-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        .detail-label {
            font-weight: 500;
            color: #495057;
        }
        .detail-value {
            font-weight: 600;
            color: #212529;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-right: none;
            border-radius: 8px 0 0 8px;
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 30px;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .alert {
            border-radius: 8px;
            padding: 1rem;
        }
        .text-center a {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }
        .text-center a:hover {
            text-decoration: underline;
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
        <div class="confirm-container">
            <div class="card">
                <div class="card-header">
                    <h3>Online Bank</h3>
                </div>
                <div class="card-body">
                    <h4 class="text-center mb-4">Confirm Transfer</h4>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <div class="transaction-details">
                        <div class="detail-row">
                            <span class="detail-label">From Account:</span>
                            <span class="detail-value"><%= request.getAttribute("fromAccount") %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">To Account:</span>
                            <span class="detail-value"><%= request.getAttribute("toAccount") %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Beneficiary Name:</span>
                            <span class="detail-value"><%= request.getAttribute("beneficiaryName") %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Amount:</span>
                            <span class="detail-value">₹<%= String.format("%,.2f", request.getAttribute("amount")) %></span>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>OTP for verification:</strong> <%= request.getAttribute("otp") %>
                        <br><small class="text-muted">(This is for demo purposes only. In production, this would be sent to your registered phone number.)</small>
                    </div>
                    
                    <form action="verifyOtp" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="otp" class="form-label">Enter OTP</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="text" class="form-control" id="otp" name="otp" 
                                       required maxlength="6" pattern="[0-9]{6}"
                                       placeholder="Enter 6-digit OTP">
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 mb-3">Verify & Complete Transfer</button>
                    </form>
                    
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/transfer">Cancel Transfer</a>
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