package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.dao.MenuDAO;
import com.tap.dao.RestaurantDAO;
import com.tap.daoimpl.MenuDAOImpl;
import com.tap.daoimpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("restaurantId");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(idParam);
                
                RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
                Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
                
                MenuDAO menuDAO = new MenuDAOImpl();
                List<Menu> menuList = menuDAO.getMenusByRestaurant(restaurantId);
                
                request.setAttribute("restaurant", restaurant);
                request.setAttribute("menuList", menuList);
                
                request.getRequestDispatcher("menu.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("restaurants");
            }
        } else {
            response.sendRedirect("restaurants");
        }
    }
}
