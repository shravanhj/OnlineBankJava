package com.bankapp.servlet;

import com.bankapp.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT user_id, username FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // User authenticated successfully
                        int userId = rs.getInt("user_id");
                        String userName = rs.getString("username");
                        
                        // Create session and store user info
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", userId);
                        session.setAttribute("username", userName);
                        
                        // Debug information
                        System.out.println("Login successful for user: " + userName);
                        System.out.println("Context path: " + request.getContextPath());
                        System.out.println("Request URI: " + request.getRequestURI());
                        System.out.println("Request URL: " + request.getRequestURL());
                        
                        // Use context-relative path for redirect (works in both Tomcat 10 and 11)
                        String contextPath = request.getContextPath();
                        if (contextPath == null || contextPath.isEmpty()) {
                            contextPath = "/";
                        }
                        String redirectPath = contextPath + (contextPath.endsWith("/") ? "" : "/") + "dashboard.jsp";
                        System.out.println("Redirecting to: " + redirectPath);
                        response.sendRedirect(redirectPath);
                    } else {
                        // Authentication failed
                        System.out.println("Login failed - invalid credentials");
                        request.setAttribute("error", "Invalid username or password");
                        // Use context-relative path for forward
                        String contextPath = request.getContextPath();
                        if (contextPath == null || contextPath.isEmpty()) {
                            contextPath = "/";
                        }
                        String forwardPath = contextPath + (contextPath.endsWith("/") ? "" : "/") + "login.jsp";
                        System.out.println("Forwarding to: " + forwardPath);
                        request.getRequestDispatcher(forwardPath).forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Add more detailed error information
            String errorMessage = "Database error occurred: " + e.getMessage();
            System.out.println("Login Error: " + errorMessage);
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
