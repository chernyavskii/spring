package net.proselyte.springsecurityapp.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "pays")
public class Pay {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "month_pay")
    private String month_pay;

    @Column(name = "date_pay")
    private String date_pay;

    @Column(name = "cost")
    private Long cost;

    @Column(name = "status_pay")
    private Boolean status_pay;

    @Column(name = "number_pay")
    private String number_pay;

    @ManyToMany(mappedBy = "pays")
    private Set<User> users;

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public String getNumber_pay() {
        return number_pay;
    }

    public void setNumber_pay(String number_pay) {
        this.number_pay = number_pay;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMonth_pay() {
        return month_pay;
    }

    public void setMonth_pay(String month_pay) {
        this.month_pay = month_pay;
    }

    public String getDate_pay() {
        return date_pay;
    }

    public void setDate_pay(String date_pay) {
        this.date_pay = date_pay;
    }

    public Long getCost() {
        return cost;
    }

    public void setCost(Long cost) {
        this.cost = cost;
    }

    public Boolean getStatus_pay() {
        return status_pay;
    }

    public void setStatus_pay(Boolean status_pay) {
        this.status_pay = status_pay;
    }

    @Override
    public String toString() {
        return "Pay{" +
                "id=" + id +
                ", month_pay='" + month_pay + '\'' +
                ", date_pay='" + date_pay + '\'' +
                ", cost=" + cost +
                ", status_pay=" + status_pay +
                ", number_pay=" + number_pay +
                ", users=" + users +
                '}';
    }
}
