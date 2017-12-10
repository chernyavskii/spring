package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.Room;

import java.util.List;
import java.util.Set;

public interface RoomService {
    List<Room> listRooms();
    Room findById(Long id);
    Set<Room> listFreeRooms();
}
