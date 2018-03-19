package cn.jboa.biz;

import cn.jboa.entity.Leave;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;

public interface LeaveBiz {

    /**
     * 添加请假单
     * @param leave
     * @return
     */
    int addLeave(Leave leave);

    /**
     * 获得部门或者 员工下面的请假集合
     * @param leave
     * @param page
     * @param sys_employee
     * @return
     */
    Page getLeavesByPage(Leave leave, Page page, Sys_Employee sys_employee);


    /**
     * 获得请假对象
     * @param leave
     * @return
     */
    Leave findLeave(Leave leave);

    /**
     * 修改请假对象
     * @param leave
     * @return
     */
    int updateLeaveProperty(Leave leave);

}
