<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Bank - Home</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .hero-section {
            padding: 4rem 0 2rem;
            text-align: center;
        }
        .btn-custom {
            border-radius: 30px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
        }
        .btn-login {
            background-color: #0d6efd;
            color: #fff;
            border: none;
        }
        .btn-login:hover {
            background-color: #0b5ed7;
        }
        .btn-register {
            background-color: transparent;
            color: #0d6efd;
            border: 1px solid #0d6efd;
        }
        .btn-register:hover {
            background-color: #0d6efd;
            color: #fff;
        }
        .feature-card {
            background-color: #fff;
            border: none;
            padding: 2rem;
            text-align: center;
            border-radius: 0.75rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: 0.3s;
        }
        .feature-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .feature-icon {
            font-size: 2rem;
            color: #0d6efd;
            margin-bottom: 1rem;
        }
        footer {
            background-color: #f1f1f1;
            font-size: 0.9rem;
            padding: 1rem 0;
            text-align: center;
            color: #6c757d;
        }
    </style>

</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="#">Online Bank</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-custom btn-login" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-custom btn-register" href="register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="fw-semibold">Welcome to Online Bank</h1>
            <p class="text-muted mt-3">Secure, Fast and Easy Digital Banking Solutions</p>
            <div class="mt-4">
                <a href="login.jsp" class="btn btn-custom btn-login me-2">Login</a>
                <a href="register.jsp" class="btn btn-custom btn-register">Register</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Features</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-wallet feature-icon"></i>
                        <h5 class="fw-bold">Account Management</h5>
                        <p class="text-muted">Manage your account and transactions with ease anytime, anywhere.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-exchange-alt feature-icon"></i>
                        <h5 class="fw-bold">Fund Transfers</h5>
                        <p class="text-muted">Quick and secure transfer of funds across accounts and banks.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-shield-alt feature-icon"></i>
                        <h5 class="fw-bold">Strong Security</h5>
                        <p class="text-muted">Top-level security protocols keep your banking safe and private.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5 bg-white">
        <div class="container">
            <h2 class="text-center mb-5">About Us</h2>
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-3">Online Bank is committed to providing modern digital banking experiences. We believe in simplifying financial services through innovative technology.</p>
                    <p>Our platform ensures safe transactions, easy account access, and excellent customer support.</p>
                </div>
                <div class="col-md-6 text-center">
                    <i class="fas fa-building feature-icon" style="font-size:5rem; color: #0d6efd;"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p class="mb-0">&copy; 2024 Online Bank. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
