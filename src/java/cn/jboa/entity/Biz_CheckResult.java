package cn.jboa.entity;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Date;

/**
 * 核实结果类
 */
@Entity
@Table(name = "biz_check_result")
public class Biz_CheckResult {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_checkResult")
    @SequenceGenerator(name = "seq_checkResult",sequenceName = "SEQ_CHECK_RESULT",allocationSize = 100,initialValue = 1)
    @Column
    private int  id;

    @ManyToOne(targetEntity = Biz_Claim.class)
    @JoinColumn(name = "CLAIM_ID")
    private Biz_Claim biz_claim;


    @Column(name = "CHECK_TIME")
    private Date checkTime;

    @ManyToOne(fetch = FetchType.EAGER,targetEntity = Sys_Employee.class)
    @JoinColumn(name = "CHECKER_SN")
    private Sys_Employee check_employee;

    private String result;
    private String comm;

    public Biz_Claim getBiz_claim() {
        return biz_claim;
    }

    public void setBiz_claim(Biz_Claim biz_claim) {
        this.biz_claim = biz_claim;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Date checkTime) {
        this.checkTime = checkTime;
    }

    public Sys_Employee getCheck_employee() {
        return check_employee;
    }

    public void setCheck_employee(Sys_Employee check_employee) {
        this.check_employee = check_employee;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getComm() {
        return comm;
    }

    public void setComm(String comm) {
        this.comm = comm;
    }



}
