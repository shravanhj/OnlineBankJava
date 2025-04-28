<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bankapp.model.Account" %>
<%@ page import="com.bankapp.model.Transaction" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Bank - Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-content {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .account-card {
            border-left: 4px solid #0d6efd;
        }
        .transaction-card {
            border-left: 4px solid #28a745;
        }
        .balance {
            font-size: 1.5rem;
            font-weight: 600;
            color: #0d6efd;
        }
        .account-number {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .transaction-item {
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
            padding: 1rem;
        }
        .transaction-item:hover {
            background-color: #f8f9fa;
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
        .header-section {
            margin-bottom: 2rem;
        }
        .header-section h2 {
            color: #0d6efd;
            font-weight: 600;
        }
        .transaction-details {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .transaction-amount {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        .btn-outline-secondary {
            border: 1px solid #6c757d;
            color: #6c757d;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
        }
        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <%
        if (session.getAttribute("phoneNumber") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Account> accounts = (List<Account>) request.getAttribute("accounts");
        List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
    %>
    <div class="main-content">
        <div class="container-fluid">
            <div class="header-section">
                <div class="d-flex justify-content-between align-items-center">
                    <h2>Your Accounts</h2>
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="dashboard.jsp" class="text-decoration-none me-2 btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                        </a>
                        <a href="addAccount.jsp" class="btn btn-primary me-3">Add New Account</a>

                    </div>
                </div>
            </div>

            <div class="row g-4">
                <% if (accounts != null && !accounts.isEmpty()) { %>
                    <% for (Account account : accounts) { %>
                        <div class="col-md-6 col-lg-4">
                            <div class="card account-card h-100">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h5 class="card-title mb-1">Account #<%= account.getAccountNumber() %></h5>
                                            <p class="account-number mb-0">ID: <%= account.getAccountId() %></p>
                                        </div>
                                    </div>
                                    <div class="balance">₹<%= account.getBalance() %></div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } else { %>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <h4>No Accounts Found</h4>
                                <p class="text-muted">You don't have any accounts yet.</p>
                                <a href="addAccount.jsp" class="btn btn-primary">Add Your First Account</a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>

            <% if (accounts != null && !accounts.isEmpty()) { %>
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card transaction-card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Recent Transactions</h5>
                            </div>
                            <div class="card-body">
                                <% if (transactions != null && !transactions.isEmpty()) { %>
                                    <div class="list-group">
                                        <% for (Transaction transaction : transactions) { %>
                                            <div class="list-group-item transaction-item">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="mb-1">Transaction #<%= transaction.getTransactionId() %></h6>
                                                        <div class="transaction-details">
                                                            <% if (transaction.getType().equals("TRANSFER")) { %>
                                                                From: <%= transaction.getFromAccountId() %> → To: <%= transaction.getToAccountId() %>
                                                            <% } else { %>
                                                                Account: <%= transaction.getFromAccountId() %>
                                                            <% } %>
                                                            <div class="mt-1">
                                                                <%= transaction.getDate() %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="transaction-amount <%= transaction.getType().equals("CREDIT") ? "text-success" : "text-danger" %>">
                                                            <%= transaction.getType().equals("CREDIT") ? "+" : "-" %>₹<%= transaction.getAmount() %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } else { %>
                                    <p class="text-muted">No recent transactions.</p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
