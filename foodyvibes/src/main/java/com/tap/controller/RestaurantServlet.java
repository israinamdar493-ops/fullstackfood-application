package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.daoimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Create DAO instance
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        
        // 2. Fetch all restaurants from database
        List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();
        
        // 3. Set the list as a request attribute
        request.setAttribute("restaurantList", restaurantList);
        
        // 4. Forward the request to restaurant.jsp page
        request.getRequestDispatcher("restaurant.jsp").forward(request, response);
    }
}
