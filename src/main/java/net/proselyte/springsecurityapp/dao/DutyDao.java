package net.proselyte.springsecurityapp.dao;

import net.proselyte.springsecurityapp.model.Duty;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DutyDao extends JpaRepository<Duty, Long> {
}
