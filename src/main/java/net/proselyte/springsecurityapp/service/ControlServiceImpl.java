package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.ControlDao;
import net.proselyte.springsecurityapp.dao.RoomDao;
import net.proselyte.springsecurityapp.model.Control;
import net.proselyte.springsecurityapp.model.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class ControlServiceImpl implements ControlService {

    @Autowired
    private ControlDao controlDao;

    @Autowired
    private RoomDao roomDao;

    @Override
    public void addNewControl(Control control) {
        Set<Room> roomSet = control.getRooms();
        Set<Control> controlSet = new HashSet<>();
        controlSet.add(control);
        controlDao.save(control);

        for(Room room : roomSet){
            Set<Control> controlSetRoom = room.getControls();
            controlSetRoom.add(control);
            roomDao.save(room);
        }
    }
}
