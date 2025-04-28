package com.bankapp.servlet;

import com.bankapp.dao.UserDAO;
import com.bankapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.IOException;

@WebServlet(
    name = "RegisterServlet",
    urlPatterns = {"/register"},
    loadOnStartup = 1
)
public class RegisterServlet extends HttpServlet {
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");

        User user = new User(0, username, password, name, phoneNumber);
        if (userDAO.createUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
