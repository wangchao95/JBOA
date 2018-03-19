package cn.jboa.entity;

import javax.persistence.*;

/**
 * 职位
 */
@Entity
@Table
public class Sys_Position {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_position")
    @SequenceGenerator(name = "seq_position",sequenceName = "seq_position",allocationSize = 1,initialValue = 1)
    @Column
    private int  id;
    @Column(name = "name_cn")
    private String nameCn;

    @Column(name = "name_en")
    private String nameEn;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }
}
