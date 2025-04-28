package com.bankapp.servlet;

import com.bankapp.dao.UserDAO;
import com.bankapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.IOException;

@WebServlet(
    name = "OtpVerificationServlet",
    urlPatterns = {"/verifyOtp"},
    loadOnStartup = 1
)
public class OtpVerificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource dataSource = (DataSource) envContext.lookup("jdbc/bankdb");
            userDAO = new UserDAO(dataSource);
        } catch (NamingException e) {
            throw new ServletException("Error initializing UserDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String storedOtp = (String) session.getAttribute("otp");
        String phoneNumber = (String) session.getAttribute("phoneNumber");

        if (otp != null && otp.equals(storedOtp)) {
            // OTP verified, get user and set in session
            User user = userDAO.getUserByPhoneNumber(phoneNumber);
            if (user != null) {
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "User not found");
                request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid OTP");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
        }
    }
} 