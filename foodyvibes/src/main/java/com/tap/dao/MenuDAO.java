package com.tap.dao;

import com.tap.model.Menu;
import java.util.List;

public interface MenuDAO {
    void addMenu(Menu menu);
    Menu getMenu(int menuId);
    List<Menu> getAllMenus();
    List<Menu> getMenusByRestaurant(int restaurantId);
    void updateMenu(Menu menu);
    void deleteMenu(int menuId);
}
