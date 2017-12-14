package net.proselyte.springsecurityapp.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "rooms")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "level")
    private Long level;

    @Column(name = "current_count")
    private Long current_count;

    @Column(name = "full_count")
    private Long full_count;

    @ManyToMany(mappedBy = "rooms",fetch = FetchType.EAGER)
    private Set<User> users;

    @ManyToMany(mappedBy = "rooms",fetch = FetchType.EAGER)
    private Set<Control> controls;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getLevel() {
        return level;
    }

    public void setLevel(Long level) {
        this.level = level;
    }

    public Long getCurrent_count() {
        return current_count;
    }

    public void setCurrent_count(Long current_count) {
        this.current_count = current_count;
    }

    public Long getFull_count() {
        return full_count;
    }

    public void setFull_count(Long full_count) {
        this.full_count = full_count;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public Set<Control> getControls() {
        return controls;
    }

    public void setControls(Set<Control> controls) {
        this.controls = controls;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id=" + id +
                ", level=" + level +
                ", current_count=" + current_count +
                ", full_count=" + full_count +
                ", users=" + users +
                ", controls=" + controls +
                '}';
    }
}
