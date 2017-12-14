package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.DutyDao;
import net.proselyte.springsecurityapp.dao.UserDao;
import net.proselyte.springsecurityapp.model.Duty;
import net.proselyte.springsecurityapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;


@Service
public class DutyServiceImpl implements DutyService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private DutyDao dutyDao;

    @Override
    @Transactional
    public void save(Duty duty, User user) {
       // duty.setStatus(Long.parseLong(1));
        //ИСПРАВЬ
        Set<User> userSet = new HashSet<>();
        userSet.add(user);
        duty.setUsers(userSet);

        Set<Duty> dutySet = user.getDuties();
        dutySet.add(duty);

        dutyDao.save(duty);
        userDao.save(user);
    }

    @Override
    public void setReceiveStatus(Long id) {
        Duty duty = dutyDao.findOne(id);
        duty.setStatus(1L);

        dutyDao.save(duty);
    }

    @Override
    public void testF(Long id, Duty duty) {
        Duty getDuty = dutyDao.findOne(id);
        getDuty.setStatus(1L);
        getDuty.setReason(duty.getReason());

        dutyDao.save(getDuty);


    }

    /*@Override
    public void setFailStatus(Long id) {
        Duty duty = dutyDao.findOne(id);
        duty.setStatus(1L);

        dutyDao.save(duty);
    }*/

}
