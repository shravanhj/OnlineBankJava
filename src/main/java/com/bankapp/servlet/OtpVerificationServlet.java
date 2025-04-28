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
    name = "OtpVerificationServlet",
    urlPatterns = {"/verifyOtp"},
    loadOnStartup = 1
)
public class OtpVerificationServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Retrieve OTP from form
        String enteredOtp = request.getParameter("otp");
        
        HttpSession session = request.getSession();
        String storedOtp = (String) session.getAttribute("otp");
        Integer fromAccountId = (Integer) session.getAttribute("fromAccountId");
        Integer toAccountId = (Integer) session.getAttribute("toAccountId");
        Double amount = (Double) session.getAttribute("amount");

        if (fromAccountId == null || toAccountId == null || amount == null || storedOtp == null) {
            response.sendRedirect("transfer.jsp?error=Invalid session. Please try the transfer again.");
            return;
        }

        if (!enteredOtp.equals(storedOtp)) {
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.setAttribute("otp", storedOtp);
            request.setAttribute("fromAccount", session.getAttribute("fromAccountNumber"));
            request.setAttribute("toAccount", session.getAttribute("toAccountNumber"));
            request.setAttribute("beneficiaryName", session.getAttribute("beneficiaryName"));
            request.setAttribute("amount", session.getAttribute("amount"));
            request.getRequestDispatcher("transfer-confirm.jsp").forward(request, response);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            try {
                // Get user_id for both accounts
                int fromUserId = 0;
                int toUserId = 0;
                
                String getUserIdsSql = "SELECT a.user_id FROM accounts a WHERE a.account_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(getUserIdsSql)) {
                    stmt.setInt(1, fromAccountId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            fromUserId = rs.getInt("user_id");
                        }
                    }
                    
                    stmt.setInt(1, toAccountId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            toUserId = rs.getInt("user_id");
                        }
                    }
                }

                // Create transaction record for sender (debit)
                String transactionSql = "INSERT INTO transactions (user_id, from_account_id, to_account_id, amount, transaction_type, status) VALUES (?, ?, ?, ?, 'DEBIT', 'COMPLETED')";
                int transactionId;
                try (PreparedStatement stmt = conn.prepareStatement(transactionSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, fromUserId);
                    stmt.setInt(2, fromAccountId);
                    stmt.setInt(3, toAccountId);
                    stmt.setDouble(4, amount);
                    stmt.executeUpdate();
                    
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            transactionId = generatedKeys.getInt(1);
                        } else {
                            throw new SQLException("Failed to create transaction");
                        }
                    }
                }

                // Create transaction record for beneficiary (credit)
                String beneficiaryTransactionSql = "INSERT INTO transactions (user_id, from_account_id, to_account_id, amount, transaction_type, status) VALUES (?, ?, ?, ?, 'CREDIT', 'COMPLETED')";
                try (PreparedStatement stmt = conn.prepareStatement(beneficiaryTransactionSql)) {
                    stmt.setInt(1, toUserId);
                    stmt.setInt(2, fromAccountId);
                    stmt.setInt(3, toAccountId);
                    stmt.setDouble(4, amount);
                    stmt.executeUpdate();
                }

                // Update from account balance
                String updateFromSql = "UPDATE accounts SET balance = balance - ? WHERE account_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateFromSql)) {
                    stmt.setDouble(1, amount);
                    stmt.setInt(2, fromAccountId);
                    stmt.executeUpdate();
                }

                // Update to account balance
                String updateToSql = "UPDATE accounts SET balance = balance + ? WHERE account_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateToSql)) {
                    stmt.setDouble(1, amount);
                    stmt.setInt(2, toAccountId);
                    stmt.executeUpdate();
                }
                
                // Commit transaction
                conn.commit();
                
                // Clear session attributes only after successful transaction
                session.removeAttribute("fromAccountId");
                session.removeAttribute("toAccountId");
                session.removeAttribute("amount");
                session.removeAttribute("otp");
                
                // Store success message
                request.setAttribute("message", "Transfer completed successfully!");
                request.setAttribute("transactionId", transactionId);
                request.getRequestDispatcher("transfer-success.jsp").forward(request, response);

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Transfer failed: " + e.getMessage());
            request.getRequestDispatcher("transfer-failed.jsp").forward(request, response);
        }
    }
} 