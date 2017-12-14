package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.dao.RoomDao;
import net.proselyte.springsecurityapp.model.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomDao roomDao;

    @Override
    public List<Room> listRooms() {
        return roomDao.findAll();
    }

    @Override
    public Room findById(Long id) {
        return roomDao.findOne(id);
    }

    @Override
    public Set<Room> listFreeRooms() {
        Set<Room> listFreeRooms = new HashSet<>();
        Iterator<Room> crunchifyIterator = roomDao.findAll().iterator();
        while (crunchifyIterator.hasNext()){
            for (Room room : roomDao.findAll()){
                room.getCurrent_count();
                if(room.getCurrent_count() == room.getFull_count()){
                    crunchifyIterator.next();
                }
                else {
                    listFreeRooms.add(room);
                    crunchifyIterator.next();
                }
            }
        }
        return listFreeRooms;
    }

    @Override
    public Long getCountFreeRooms() {
        Iterator<Room> crunchifyIterator = listFreeRooms().iterator();
        Long count = 0L;
        while (crunchifyIterator.hasNext()){
            for (Room room : listFreeRooms()){
                count = count + room.getFull_count() - room.getCurrent_count();
                crunchifyIterator.next();
            }
        }
        return count;
    }

}
