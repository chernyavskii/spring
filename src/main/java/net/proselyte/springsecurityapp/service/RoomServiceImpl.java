package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.RoomDao;
import net.proselyte.springsecurityapp.model.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomDao roomDao;

    @Override//////////
    @ModelAttribute("roles")
    public List<Room> listRooms() {
        return roomDao.findAll();
    }

    @Override
    public Room findById(Long id) {
        return roomDao.findOne(id);
    }

}
