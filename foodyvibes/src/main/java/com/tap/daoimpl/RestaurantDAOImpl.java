package com.tap.daoimpl;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    private static final String INSERT_QUERY = "INSERT INTO Restaurant (Name, CuisineType, DeliveryTime, Address, Rating, IsActive, ImagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM Restaurant WHERE RestaurantID = ?";
    private static final String SELECT_ALL_QUERY = "SELECT * FROM Restaurant";
    private static final String UPDATE_QUERY = "UPDATE Restaurant SET Name = ?, CuisineType = ?, DeliveryTime = ?, Address = ?, Rating = ?, IsActive = ?, ImagePath = ? WHERE RestaurantID = ?";
    private static final String DELETE_QUERY = "DELETE FROM Restaurant WHERE RestaurantID = ?";

    @Override
    public void addRestaurant(Restaurant restaurant) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUERY)) {
            
            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getCuisineType());
            preparedStatement.setInt(3, restaurant.getDeliveryTime());
            preparedStatement.setString(4, restaurant.getAddress());
            preparedStatement.setDouble(5, restaurant.getRating());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setString(7, restaurant.getImagePath());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        Restaurant restaurant = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID_QUERY)) {
            
            preparedStatement.setInt(1, restaurantId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                restaurant = new Restaurant(
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("Name"),
                        resultSet.getString("CuisineType"),
                        resultSet.getInt("DeliveryTime"),
                        resultSet.getString("Address"),
                        resultSet.getDouble("Rating"),
                        resultSet.getBoolean("IsActive"),
                        resultSet.getString("ImagePath")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_QUERY)) {
            
            while (resultSet.next()) {
                Restaurant restaurant = new Restaurant(
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("Name"),
                        resultSet.getString("CuisineType"),
                        resultSet.getInt("DeliveryTime"),
                        resultSet.getString("Address"),
                        resultSet.getDouble("Rating"),
                        resultSet.getBoolean("IsActive"),
                        resultSet.getString("ImagePath")
                );
                restaurants.add(restaurant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUERY)) {
            
            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getCuisineType());
            preparedStatement.setInt(3, restaurant.getDeliveryTime());
            preparedStatement.setString(4, restaurant.getAddress());
            preparedStatement.setDouble(5, restaurant.getRating());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setString(7, restaurant.getImagePath());
            preparedStatement.setInt(8, restaurant.getRestaurantId());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUERY)) {
            
            preparedStatement.setInt(1, restaurantId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
