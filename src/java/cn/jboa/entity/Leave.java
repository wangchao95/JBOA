package cn.jboa.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * 请假类
 */
@Entity
@Table(name = "BIZ_LEAVE")
public class Leave {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_leave")
    @SequenceGenerator(name = "seq_leave",sequenceName = "SEQ_LEAVE",allocationSize = 100,initialValue = 1)
    @Column
    private int  id; //编号

    @ManyToOne(targetEntity = Sys_Employee.class)
    @JoinColumn(name = "employee_sn")
    private Sys_Employee   sys_employee;  //员工编号


    private Date startTime;   //开始时间
    private Date endTime;  //结束时间
    private int leaveDay;  //离开多久
    private String  reason;   //事由
    private String  status;  //状态
    private String  leaveType;  ;  //请假类型
    private String next_Deal_Sn;  //下一个执行者
    private String approve_opinion;  //
    private Date createTime;  //创建时间
    private Date modifyTime;  //修改时间

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Sys_Employee getSys_employee() {
        return sys_employee;
    }

    public void setSys_employee(Sys_Employee sys_employee) {
        this.sys_employee = sys_employee;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getLeaveDay() {
        return leaveDay;
    }

    public void setLeaveDay(int leaveDay) {
        this.leaveDay = leaveDay;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getNext_Deal_Sn() {
        return next_Deal_Sn;
    }

    public void setNext_Deal_Sn(String next_Deal_Sn) {
        this.next_Deal_Sn = next_Deal_Sn;
    }

    public String getApprove_opinion() {
        return approve_opinion;
    }

    public void setApprove_opinion(String approve_opinion) {
        this.approve_opinion = approve_opinion;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }


    public Leave() {
    }


    public Leave(int id) {
        this.id = id;
    }
}
