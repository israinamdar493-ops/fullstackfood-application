package com.tap.controller;

import java.io.IOException;

import com.tap.dao.MenuDAO;
import com.tap.daoimpl.MenuDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Integer oldRestaurantId = (Integer) session.getAttribute("restaurantId");
        
        String restIdParam = request.getParameter("restaurantId");
        if (restIdParam == null || restIdParam.isEmpty()) {
            response.sendRedirect("restaurants");
            return;
        }
        
        int newRestaurantId = Integer.parseInt(restIdParam);
        
        // Create a new cart if it doesn't exist or if ordering from a different restaurant
        if (cart == null || oldRestaurantId == null || oldRestaurantId != newRestaurantId) {
            cart = new Cart();
            session.setAttribute("cart", cart);
            session.setAttribute("restaurantId", newRestaurantId);
        }
        
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                addItemToCart(request, cart);
                // Redirect back to the menu so the user can keep adding items
                response.sendRedirect("menu?restaurantId=" + newRestaurantId);
            } else if (action.equals("update")) {
                updateCartItem(request, cart);
                // Redirect to cart page after updating
                response.sendRedirect("cart.jsp");
            } else if (action.equals("delete")) {
                removeItemFromCart(request, cart);
                // Redirect to cart page after removing
                response.sendRedirect("cart.jsp");
            }
        } else {
            response.sendRedirect("cart.jsp");
        }
    }
    
    private void addItemToCart(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        MenuDAO menuDAO = new MenuDAOImpl();
        Menu menu = menuDAO.getMenu(menuId);
        
        if (cart.getItems().containsKey(menuId)) {
            CartItem existingItem = cart.getItems().get(menuId);
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            if (menu != null) {
                CartItem newItem = new CartItem(
                    menu.getMenuId(), 
                    menu.getRestaurantId(), 
                    menu.getItemName(), 
                    (float) menu.getPrice(), 
                    quantity
                );
                cart.getItems().put(menuId, newItem);
            }
        }
    }
    
    private void updateCartItem(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        if (cart.getItems().containsKey(menuId)) {
            if (quantity <= 0) {
                cart.getItems().remove(menuId);
            } else {
                cart.getItems().get(menuId).setQuantity(quantity);
            }
        }
    }
    
    private void removeItemFromCart(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        cart.getItems().remove(menuId);
    }
}
