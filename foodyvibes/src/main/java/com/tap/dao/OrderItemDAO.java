package com.tap.dao;

import com.tap.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    void addOrderItem(OrderItem orderItem);
    OrderItem getOrderItem(int orderItemId);
    List<OrderItem> getAllOrderItems();
    List<OrderItem> getOrderItemsByOrder(int orderId);
    void updateOrderItem(OrderItem orderItem);
    void deleteOrderItem(int orderItemId);
}
