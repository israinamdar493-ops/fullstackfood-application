package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.dao.UserDAO;
import com.tap.daoimpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String passwordParam = request.getParameter("password");

        if (username != null && passwordParam != null) {
            UserDAO userDAO = new UserDAOImpl();
            // Assuming "username" could be an actual username or an email
            User user = userDAO.getUserByUsername(username);

            // BCrypt.checkpw takes the raw password and the hashed password from the database
            if (user != null && BCrypt.checkpw(passwordParam, user.getPassword())) {
                // Passwords match, login successful
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                
                // Redirect to the restaurants page as the main landing page
                response.sendRedirect("restaurants");
            } else {
                // Passwords do not match or user not found
                response.sendRedirect("login.html?error=invalid");
            }
        } else {
            response.sendRedirect("login.html");
        }
    }
}
