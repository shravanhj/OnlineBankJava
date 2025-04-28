<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Failed - Online Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .failure-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            text-align: center;
        }
        .failure-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .failure-container h2 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .alert {
            border-radius: 8px;
            padding: 1rem;
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
        .btn-outline-secondary {
            border: 1px solid #6c757d;
            color: #6c757d;
            padding: 0.75rem 1.5rem;
            border-radius: 30px;
            font-weight: 500;
        }
        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body class="bg-light">
    <%
    // Check if user is logged in
    if (session.getAttribute("phoneNumber") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>
    
    <div class="container">
        <div class="failure-container">
            <div class="failure-icon">
                <i class="fas fa-times-circle"></i>
            </div>
            <h2>Transfer Failed</h2>
            
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            
            <div class="d-grid gap-2">
                <a href="${pageContext.request.contextPath}/transfer" class="btn btn-primary">Try Again</a>
                <a href="dashboard.jsp" class="btn btn-outline-secondary">Back to Dashboard</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html> 