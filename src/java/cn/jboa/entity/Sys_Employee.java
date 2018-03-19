package cn.jboa.entity;

import javax.persistence.*;
import java.util.List;

/**
 * 员工类
 */
@Entity
@Table
public class Sys_Employee {

    @Id
    private String sn;  //编号


    @ManyToOne(fetch = FetchType.EAGER,targetEntity = Sys_Position.class)
    @JoinColumn(name = "POSITION_ID")
    private Sys_Position sys_position;  //职位


    @ManyToOne(fetch = FetchType.EAGER,targetEntity = Sys_Department.class)
    @JoinColumn(name = "DEPARTMENT_ID")
    private Sys_Department sys_department;  //部门

    private String name;   //名字
    private String password;   //密码
    private String status;  //状态


    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public Sys_Position getSys_position() {
        return sys_position;
    }

    public void setSys_position(Sys_Position sys_position) {
        this.sys_position = sys_position;
    }

    public Sys_Department getSys_department() {
        return sys_department;
    }

    public void setSys_department(Sys_Department sys_department) {
        this.sys_department = sys_department;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public Sys_Employee() {
    }

    public Sys_Employee(String sn) {
        this.sn = sn;
    }


    public Sys_Employee(Sys_Department sys_department) {
        this.sys_department = sys_department;
    }
}
