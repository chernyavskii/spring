package net.proselyte.springsecurityapp.service;

import net.proselyte.springsecurityapp.model.Room;

import java.util.List;

public interface RoomService {
    List<Room> listRooms();
    Room findById(Long id);
}
