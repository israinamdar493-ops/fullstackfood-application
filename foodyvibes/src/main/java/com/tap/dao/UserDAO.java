package com.tap.dao;

import com.tap.model.User;
import java.util.List;

public interface UserDAO {
    int addUser(User user);
    User getUser(int userId);
    List<User> getAllUsers();
    void updateUser(User user);
    void deleteUser(int userId);
    User getUserByUsername(String username);
}
