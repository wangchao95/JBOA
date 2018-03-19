package cn.jboa.entity;

import javax.persistence.*;

/**
 * 部门
 */
@Entity
@Table
public class Sys_Department {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_department")
    @SequenceGenerator(name = "seq_department",sequenceName = "seq_department",allocationSize = 1,initialValue = 1)
    @Column
    private int id;  //编号
    private String name; //名称


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Sys_Department() {
    }

    public Sys_Department(int id) {
        this.id = id;
    }
}
