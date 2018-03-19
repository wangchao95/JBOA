package cn.jboa.entity;

import java.util.Date;

/**
 * 消息类
 */
public class Message {

    private Date startDate;  //开始时间
    private Date endDate;   //结束时间

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
