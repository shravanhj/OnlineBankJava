package com.bankapp.servlet;

import com.bankapp.dao.Database;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(
    name = "LoginServlet",
    urlPatterns = {"/login"}
)
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");

        // Log parameters for debugging
        System.out.println("Login attempt with phoneNumber: " + phoneNumber);

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT user_id, name, phone_number FROM users WHERE phone_number = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, phoneNumber);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // User found, create session and redirect to dashboard
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", rs.getInt("user_id"));
                        session.setAttribute("userName", rs.getString("name"));
                        session.setAttribute("phoneNumber", rs.getString("phone_number"));
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        // User not found, redirect with error message
                        response.sendRedirect("login.jsp?error=Invalid+phone+number+or+password");
                    }
                }
            }
        } catch (SQLException e) {
            // Log SQL exception details
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database+error: " + e.getMessage());
        } catch (Exception e) {
            // Catch any other unexpected exceptions
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Unexpected+error: " + e.getMessage());
        }
    }
}
