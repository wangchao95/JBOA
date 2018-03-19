package cn.jboa.entity;


import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 报销单类
 */
@Entity
@Table(name = "biz_claim_voucher")
public class Biz_Claim {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_claim")
    @SequenceGenerator(name = "seq_claim",sequenceName = "SEQ_VOUCHER",allocationSize = 100,initialValue = 1)
    @Column
    private int id;   //编号

    @ManyToOne(fetch = FetchType.EAGER,targetEntity = Sys_Employee.class)
    @JoinColumn(name = "NEXT_DEAL_SN")
    private Sys_Employee sys_empNext;  //下一个处理者

    @ManyToOne(fetch = FetchType.EAGER,targetEntity = Sys_Employee.class)
    @JoinColumn(name = "CREATE_SN")
    private Sys_Employee sys_empCreate;  //创建者

    @Column(name = "CREATE_TIME")
    private Date createTime;  //创建时间

    @Column(name = "MODIFY_TIME")
    private Date modifyTime;  //修改时间
    private String event;  //结果
    @Column(name = "TOTAL_ACCOUNT")
    private float totalAccount;  //总价
    private String status;   //状态

    @OneToMany(mappedBy = "mainId",targetEntity = Biz_ClaimDetail.class,fetch = FetchType.LAZY)
    private List<Biz_ClaimDetail> claimDetailList;   //报销详情集合


    @OneToMany(mappedBy = "biz_claim",targetEntity = Biz_CheckResult.class,fetch = FetchType.LAZY)
    private List<Biz_CheckResult> biz_checkResultList;   //审核详情集合

    public List<Biz_CheckResult> getBiz_checkResultList() {
        return biz_checkResultList;
    }

    public void setBiz_checkResultList(List<Biz_CheckResult> biz_checkResultList) {
        this.biz_checkResultList = biz_checkResultList;
    }

    @Transient
    private Date beginTime;
    @Transient
    private Date endTime;

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Sys_Employee getSys_empNext() {
        return sys_empNext;
    }

    public void setSys_empNext(Sys_Employee sys_empNext) {
        this.sys_empNext = sys_empNext;
    }

    public Sys_Employee getSys_empCreate() {
        return sys_empCreate;
    }

    public void setSys_empCreate(Sys_Employee sys_empCreate) {
        this.sys_empCreate = sys_empCreate;
    }

    public List<Biz_ClaimDetail> getClaimDetailList() {
        return claimDetailList;
    }

    public void setClaimDetailList(List<Biz_ClaimDetail> claimDetailList) {
        this.claimDetailList = claimDetailList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public float getTotalAccount() {
        return totalAccount;
    }

    public void setTotalAccount(float totalAccount) {
        this.totalAccount = totalAccount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public Biz_Claim() {
    }

    public Biz_Claim(int id) {
        this.id = id;
    }
}
