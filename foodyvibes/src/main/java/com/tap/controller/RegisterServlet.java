package com.tap.controller;

import java.io.IOException;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.dao.UserDAO;
import com.tap.daoimpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        if (username != null && email != null && password != null) {
            // Hash the password using BCrypt
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(hashedPassword);
            user.setAddress(address);
            user.setRole(role != null ? role : "Customer");
            user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));

            UserDAO userDAO = new UserDAOImpl();
            int status = userDAO.addUser(user);

            if (status == 1) {
                // Redirect to login page after successful registration
                response.sendRedirect("login.html");
            } else {
                // Re-render register page on failure
                response.sendRedirect("register.html");
            }
        } else {
            // Re-render register page on failure
            response.sendRedirect("register.html");
        }
    }
}
