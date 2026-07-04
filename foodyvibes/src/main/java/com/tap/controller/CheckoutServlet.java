package com.tap.controller;

import java.io.IOException;
import java.sql.Timestamp;

import com.tap.dao.OrderDAO;
import com.tap.dao.OrderItemDAO;
import com.tap.daoimpl.OrderDAOImpl;
import com.tap.daoimpl.OrderItemDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 1. Get user from session
        User user = (User) session.getAttribute("loggedInUser");

        // 2. Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");

        // 3. Get restaurant ID from session
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");

        // Guard: If user not logged in, redirect to login
        if (user == null) {
            request.getRequestDispatcher("login.html").forward(request, response);
            return;
        }

        // Guard: If cart is empty or missing, redirect to cart page
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // 4. Get payment method from request (submitted via form)
        String paymentMode = request.getParameter("paymentMode");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            paymentMode = "Cash on Delivery";
        }

        // 5. Get final amount from session (calculated in checkout.jsp)
        Double finalAmount = (Double) session.getAttribute("finalAmount");
        if (finalAmount == null) {
            // Recalculate if not in session
            double grandTotal = 0;
            for (CartItem item : cart.getItems().values()) {
                grandTotal += item.getTotalPrice();
            }
            finalAmount = grandTotal + 40 + 5; // delivery + platform fee
        }

        // 6. Build the Order object
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId != null ? restaurantId : 0);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(finalAmount);
        order.setStatus("Pending");
        order.setPaymentMethod(paymentMode);

        // 7. Save Order to DB — returns the auto-generated OrderID
        OrderDAO orderDAO = new OrderDAOImpl();
        int generatedOrderId = orderDAO.addOrder(order);

        // 8. Save each OrderItem using the returned orderId
        if (generatedOrderId > 0) {
            OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
            for (CartItem cartItem : cart.getItems().values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(generatedOrderId);
                orderItem.setMenuId(cartItem.getItemId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setItemTotal(cartItem.getTotalPrice());
                orderItemDAO.addOrderItem(orderItem);
            }
        }

        // 9. Clear the cart from session after order is placed
        session.removeAttribute("cart");
        session.removeAttribute("restaurantId");
        session.removeAttribute("finalAmount");

        // 10. Forward to order-confirmation page with order details
        request.setAttribute("orderId", generatedOrderId);
        request.setAttribute("finalAmount", finalAmount);
        request.setAttribute("paymentMode", paymentMode);
        request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
    }
}
