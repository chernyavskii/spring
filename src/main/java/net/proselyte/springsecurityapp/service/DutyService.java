package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.Duty;
import net.proselyte.springsecurityapp.model.User;

public interface DutyService {
    /*public*/ void save(Duty duty, User user);
    void setReceiveStatus(Long id);
   // void setFailStatus(Long id);
    void testF(Long id, Duty duty);
}
