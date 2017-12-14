package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.Pay;
import net.proselyte.springsecurityapp.model.User;

public interface PayService {
    void save(Pay pay, User user);

}
