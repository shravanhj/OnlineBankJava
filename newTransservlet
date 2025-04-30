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
    name = "RegisterServlet",
    urlPatterns = {"/register"},
    loadOnStartup = 1
)
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");

        try (Connection conn = Database.getConnection()) {
            // First check if user already exists
            String checkSql = "SELECT COUNT(*) as count FROM users WHERE phone_number = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, phoneNumber);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        response.sendRedirect("register.jsp?error=Phone number already registered");
                        return;
                    }
                }
            }

            // Insert new user
            String sql = "INSERT INTO users (name, phone_number, password) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, name);
                stmt.setString(2, phoneNumber);
                stmt.setString(3, password);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // Get the generated user ID
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int userId = generatedKeys.getInt(1);
                            // Create a session and store user info
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("userName", name);
                            session.setAttribute("phoneNumber", phoneNumber);
                        }
                    }
                    response.sendRedirect("thankyou.jsp");
                } else {
                    response.sendRedirect("register.jsp?error=Registration failed - no rows affected");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Unexpected error: " + e.getMessage());
        }
    }
}
