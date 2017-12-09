package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.RoleDao;
import net.proselyte.springsecurityapp.dao.RoomDao;
import net.proselyte.springsecurityapp.dao.UserDao;
import net.proselyte.springsecurityapp.model.Role;
import net.proselyte.springsecurityapp.model.Room;
import net.proselyte.springsecurityapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private RoomDao roomDao;

    @Autowired
    private RoleDao roleDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    @Transactional
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        Set<Role> roles = new HashSet<>();
        roles.add(roleDao.getOne(1L));
        user.setRoles(roles);

        Set<Room> roomSet = new HashSet<>();
        roomSet = user.getRooms();
        for(Room room : roomSet){
            if(room.getFull_count() >= room.getCurrent_count()){
                room.setCurrent_count(room.getCurrent_count()+1);
                roomDao.save(room);
            }
            else {
                System.out.print("OR");
            }
        }
        userDao.save(user);
    }
    @Override
    @Transactional
    public List<User> listUsers() {
        return userDao.findAll();
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    @Transactional
    public void remove(Long id) {
        userDao.delete(id);
    }

    @Override
    public User findById(Long id) {
        return userDao.findOne(id);
    }

}
