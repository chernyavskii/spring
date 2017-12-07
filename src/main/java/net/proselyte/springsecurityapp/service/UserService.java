package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.User;

import java.util.List;

public interface UserService {

    void save(User user);
    List<User> listUsers();
    User findByUsername(String username);
    void remove(Long id);
    User findById(Long id);
}
