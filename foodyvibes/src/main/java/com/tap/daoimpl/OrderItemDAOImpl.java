package com.tap.daoimpl;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_QUERY = "INSERT INTO OrderItem (OrderID, MenuID, Quantity, ItemTotal) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM OrderItem WHERE OrderItemID = ?";
    private static final String SELECT_ALL_QUERY = "SELECT * FROM OrderItem";
    private static final String SELECT_BY_ORDER_QUERY = "SELECT * FROM OrderItem WHERE OrderID = ?";
    private static final String UPDATE_QUERY = "UPDATE OrderItem SET OrderID = ?, MenuID = ?, Quantity = ?, ItemTotal = ? WHERE OrderItemID = ?";
    private static final String DELETE_QUERY = "DELETE FROM OrderItem WHERE OrderItemID = ?";

    @Override
    public void addOrderItem(OrderItem orderItem) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUERY)) {
            
            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setInt(3, orderItem.getQuantity());
            preparedStatement.setDouble(4, orderItem.getItemTotal());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {
        OrderItem orderItem = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID_QUERY)) {
            
            preparedStatement.setInt(1, orderItemId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                orderItem = new OrderItem(
                        resultSet.getInt("OrderItemID"),
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("Quantity"),
                        resultSet.getDouble("ItemTotal")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItem;
    }

    @Override
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> orderItems = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_QUERY)) {
            
            while (resultSet.next()) {
                OrderItem orderItem = new OrderItem(
                        resultSet.getInt("OrderItemID"),
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("Quantity"),
                        resultSet.getDouble("ItemTotal")
                );
                orderItems.add(orderItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ORDER_QUERY)) {
            
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                OrderItem orderItem = new OrderItem(
                        resultSet.getInt("OrderItemID"),
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("Quantity"),
                        resultSet.getDouble("ItemTotal")
                );
                orderItems.add(orderItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUERY)) {
            
            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setInt(3, orderItem.getQuantity());
            preparedStatement.setDouble(4, orderItem.getItemTotal());
            preparedStatement.setInt(5, orderItem.getOrderItemId());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUERY)) {
            
            preparedStatement.setInt(1, orderItemId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
