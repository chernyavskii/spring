package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.Pay;
import net.proselyte.springsecurityapp.model.User;

import java.util.List;

public interface PayService {
    void save(Pay pay, User user);
    List<Pay> listPays();
    void setToSuccess(Long id);
    void setToFail(Long id);
}
