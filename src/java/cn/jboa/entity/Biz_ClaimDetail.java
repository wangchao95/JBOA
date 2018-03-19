package cn.jboa.entity;

import javax.persistence.*;

/**
 * 报销详情类
 */
@Entity
@Table(name = "biz_claim_voucher_detail")
public class Biz_ClaimDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_claimDetail")
    @SequenceGenerator(name = "seq_claimDetail",sequenceName = "SEQ_VOUCHER_DETAIL",allocationSize = 100,initialValue = 1)
    @Column
    private int id;   //编号


    @Column(name = "MAIN_ID")
    private int mainId;  //报销类的id


    private String item;  //报销项目
    private float account;  //金额
    private String des;  //说明


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMainId() {
        return mainId;
    }

    public void setMainId(int mainId) {
        this.mainId = mainId;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public float getAccount() {
        return account;
    }

    public void setAccount(float account) {
        this.account = account;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}
