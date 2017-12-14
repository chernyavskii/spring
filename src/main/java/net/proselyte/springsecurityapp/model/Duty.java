package net.proselyte.springsecurityapp.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "duty")
public class Duty {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "status")
    private Long status;

    @Column(name = "date")
    private String date;

    @Column(name = "reason")
    private String reason;

    @Column(name = "time_duty")
    private String time_duty;

    @ManyToMany(mappedBy = "duties")
    private Set<User> users;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public String getTime_duty() {
        return time_duty;
    }

    public void setTime_duty(String time_duty) {
        this.time_duty = time_duty;
    }

    @Override
    public String toString() {
        return "Duty{" +
                "id=" + id +
                ", status=" + status +
                ", date='" + date + '\'' +
                ", reason='" + reason + '\'' +
                ", time_duty='" + time_duty + '\'' +
                ", users=" + users +
                '}';
    }
}
