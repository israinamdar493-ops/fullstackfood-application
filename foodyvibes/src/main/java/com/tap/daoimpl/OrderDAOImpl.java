package com.tap.daoimpl;

import com.tap.dao.OrderDAO;
import com.tap.model.Order;
import com.tap.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private static final String INSERT_QUERY = "INSERT INTO OrderTable (UserID, RestaurantID, OrderDate, TotalAmount, Status, PaymentMethod) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM OrderTable WHERE OrderID = ?";
    private static final String SELECT_ALL_QUERY = "SELECT * FROM OrderTable";
    private static final String SELECT_BY_USER_QUERY = "SELECT * FROM OrderTable WHERE UserID = ?";
    private static final String UPDATE_QUERY = "UPDATE OrderTable SET UserID = ?, RestaurantID = ?, OrderDate = ?, TotalAmount = ?, Status = ?, PaymentMethod = ? WHERE OrderID = ?";
    private static final String DELETE_QUERY = "DELETE FROM OrderTable WHERE OrderID = ?";

    @Override
    public int addOrder(Order order) {
        int generatedOrderId = -1;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setTimestamp(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMethod());
            
            preparedStatement.executeUpdate();
            
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedOrderId = generatedKeys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedOrderId;
    }

    @Override
    public Order getOrder(int orderId) {
        Order order = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID_QUERY)) {
            
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                order = new Order(
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getTimestamp("OrderDate"),
                        resultSet.getDouble("TotalAmount"),
                        resultSet.getString("Status"),
                        resultSet.getString("PaymentMethod")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_QUERY)) {
            
            while (resultSet.next()) {
                Order order = new Order(
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getTimestamp("OrderDate"),
                        resultSet.getDouble("TotalAmount"),
                        resultSet.getString("Status"),
                        resultSet.getString("PaymentMethod")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_USER_QUERY)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                Order order = new Order(
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getTimestamp("OrderDate"),
                        resultSet.getDouble("TotalAmount"),
                        resultSet.getString("Status"),
                        resultSet.getString("PaymentMethod")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public void updateOrder(Order order) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUERY)) {
            
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setTimestamp(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMethod());
            preparedStatement.setInt(7, order.getOrderId());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUERY)) {
            
            preparedStatement.setInt(1, orderId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
