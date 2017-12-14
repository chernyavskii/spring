package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.PayDao;
import net.proselyte.springsecurityapp.dao.UserDao;
import net.proselyte.springsecurityapp.model.Pay;
import net.proselyte.springsecurityapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class PayServiceImpl implements PayService {

    @Autowired
    private PayDao payDao;

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public void save(Pay pay, User user) {
        pay.setStatus_pay(false);
        Set<User> userSet = new HashSet<>();
        userSet.add(user);
        pay.setUsers(userSet);

        Set<Pay> paySet = user.getPays();
        paySet.add(pay);

        payDao.save(pay);
        userDao.save(user);

      /*  Set<User> userSet = new HashSet<>();
        userSet.add(user);
        Set<Pay> paySet = new HashSet<>();
        paySet.add(pay);

        user.setPays(paySet);
        pay.setStatus_pay(false);
        pay.setUsers(userSet);

        payDao.save(pay);
        userDao.save(user);*/
    }

    @Override
    public List<Pay> listPays() {
        return payDao.findAll();
    }

    @Override
    public void setToSuccess(Long id) {
        Pay pay = payDao.findOne(id);
        pay.setStatus_pay(true);

        payDao.save(pay);
    }

    @Override
    public void setToFail(Long id) {
        Pay pay = payDao.findOne(id);
        pay.setStatus_pay(false);

        payDao.save(pay);
    }
}
