package net.proselyte.springsecurityapp.model;


import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "controls")
public class Control {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "cleanliness")
    private Long cleanliness;

    @Column(name = "tidiness")
    private Long tidiness;

    @Column(name = "date_control")
    private String date_control;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "room_controls", joinColumns = @JoinColumn(name = "control_id"),
            inverseJoinColumns = @JoinColumn(name = "room_id"))
    private Set<Room> rooms;


    public Long getControl_id() {
        return id;
    }

    public void setControl_id(Long control_id) {
        this.id = control_id;
    }

    public Long getCleanliness() {
        return cleanliness;
    }

    public void setCleanliness(Long cleanliness) {
        this.cleanliness = cleanliness;
    }

    public Long getTidiness() {
        return tidiness;
    }

    public void setTidiness(Long tidiness) {
        this.tidiness = tidiness;
    }

    public String getDate_control() {
        return date_control;
    }

    public void setDate_control(String date_control) {
        this.date_control = date_control;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Set<Room> getRooms() {
        return rooms;
    }

    public void setRooms(Set<Room> rooms) {
        this.rooms = rooms;
    }

    @Override
    public String toString() {
        return "Control{" +
                "id=" + id +
                ", cleanliness=" + cleanliness +
                ", tidiness=" + tidiness +
                ", date_control='" + date_control + '\'' +
                ", rooms=" + rooms +
                '}';
    }
}
