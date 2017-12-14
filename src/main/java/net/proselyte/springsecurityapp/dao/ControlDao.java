package net.proselyte.springsecurityapp.dao;

import net.proselyte.springsecurityapp.model.Control;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ControlDao extends JpaRepository<Control, Long> {
}
