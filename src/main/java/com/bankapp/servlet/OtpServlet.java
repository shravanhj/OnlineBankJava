package com.bankapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/generateOtp")
public class OtpServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Generate OTP and store it in the session
        Random rand = new Random();
        int otp = rand.nextInt(999999);
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);

        // Send OTP to user (for now, just display it on the screen)
        response.sendRedirect("otp.jsp?otp=" + otp);
    }
}
