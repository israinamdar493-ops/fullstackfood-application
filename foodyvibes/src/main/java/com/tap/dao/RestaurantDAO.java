package com.tap.dao;

import com.tap.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    void addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    List<Restaurant> getAllRestaurants();
    void updateRestaurant(Restaurant restaurant);
    void deleteRestaurant(int restaurantId);
}
