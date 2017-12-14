package net.proselyte.springsecurityapp.dao;

import net.proselyte.springsecurityapp.model.Pay;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PayDao extends JpaRepository<Pay, Long> {
}
