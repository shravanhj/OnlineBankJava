<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Online Bank</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: #0d6efd !important;
        }
        .header-section {
            background-color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header-section h1 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .action-card {
            background-color: white;
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
            height: 100%;
        }
        .action-card:hover {
            transform: translateY(-5px);
        }
        .action-card i {
            font-size: 2.5rem;
            color: #0d6efd;
            margin-bottom: 1rem;
        }
        .action-card h3 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .action-card p {
            color: #6c757d;
            margin-bottom: 1.5rem;
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
        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 30px;
            font-weight: 500;
        }
        .btn-danger:hover {
            background-color: #c82333;
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


    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">Online Bank</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item ms-2">
                        <a class="btn btn-danger" href="logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Welcome Section -->
    <section class="header-section">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1>Welcome, <%= session.getAttribute("userName") %>!</h1>
                    <p class="text-muted mb-0">Phone Number: <%= session.getAttribute("phoneNumber") %></p>
                </div>
            </div>
        </div>
    </section>

    <!-- Action Cards Section -->
    <section>
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="action-card">
                        <i class="fas fa-plus"></i>
                        <h3>Account Management</h3>
                        <p>Manage new account.</p>
                        <a href="addAccount.jsp" class="btn btn-primary">Add Account</a>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3">
                    <div class="action-card">
                        <i class="fas fa-exchange-alt"></i>
                        <h3>Fund Transfer</h3>
                        <p>Transfer funds to other accounts securely.</p>
                        <a href="${pageContext.request.contextPath}/transfer" class="btn btn-primary">Transfer Funds</a>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3">
                    <div class="action-card">
                        <i class="fas fa-list"></i>
                        <h3>View Accounts</h3>
                        <p>View and manage your existing bank accounts.</p>
                        <a href="${pageContext.request.contextPath}/account" class="btn btn-primary">View Accounts</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
