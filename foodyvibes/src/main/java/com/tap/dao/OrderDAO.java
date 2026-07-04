package com.tap.dao;

import com.tap.model.Order;
import java.util.List;

public interface OrderDAO {
    int addOrder(Order order);
    Order getOrder(int orderId);
    List<Order> getAllOrders();
    List<Order> getOrdersByUser(int userId);
    void updateOrder(Order order);
    void deleteOrder(int orderId);
}
