package com.tap.daoimpl;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    private static final String INSERT_QUERY = "INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM Menu WHERE MenuID = ?";
    private static final String SELECT_ALL_QUERY = "SELECT * FROM Menu";
    private static final String SELECT_BY_RESTAURANT_QUERY = "SELECT * FROM Menu WHERE RestaurantID = ?";
    private static final String UPDATE_QUERY = "UPDATE Menu SET RestaurantID = ?, ItemName = ?, Description = ?, Price = ?, IsAvailable = ?, ImagePath = ? WHERE MenuID = ?";
    private static final String DELETE_QUERY = "DELETE FROM Menu WHERE MenuID = ?";

    @Override
    public void addMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUERY)) {
            
            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setDouble(4, menu.getPrice());
            preparedStatement.setBoolean(5, menu.isAvailable());
            preparedStatement.setString(6, menu.getImagePath());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        Menu menu = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID_QUERY)) {
            
            preparedStatement.setInt(1, menuId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                menu = new Menu(
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("ItemName"),
                        resultSet.getString("Description"),
                        resultSet.getDouble("Price"),
                        resultSet.getBoolean("IsAvailable"),
                        resultSet.getString("ImagePath")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    @Override
    public List<Menu> getAllMenus() {
        List<Menu> menus = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_QUERY)) {
            
            while (resultSet.next()) {
                Menu menu = new Menu(
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("ItemName"),
                        resultSet.getString("Description"),
                        resultSet.getDouble("Price"),
                        resultSet.getBoolean("IsAvailable"),
                        resultSet.getString("ImagePath")
                );
                menus.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_RESTAURANT_QUERY)) {
            
            preparedStatement.setInt(1, restaurantId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                Menu menu = new Menu(
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("ItemName"),
                        resultSet.getString("Description"),
                        resultSet.getDouble("Price"),
                        resultSet.getBoolean("IsAvailable"),
                        resultSet.getString("ImagePath")
                );
                menus.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public void updateMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUERY)) {
            
            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setDouble(4, menu.getPrice());
            preparedStatement.setBoolean(5, menu.isAvailable());
            preparedStatement.setString(6, menu.getImagePath());
            preparedStatement.setInt(7, menu.getMenuId());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUERY)) {
            
            preparedStatement.setInt(1, menuId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
