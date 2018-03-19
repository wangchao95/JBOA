package cn.jboa.dao;


import cn.jboa.entity.Leave;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;

import java.util.List;

public interface LeaveDao {

    /**
     * 添加请假单
     * @param leave
     * @return
     */
    int addLeave(Leave leave);

    /**
     * 获得某用户或者部门下的请假集合
     * @param leave
     * @return
     */
    Page getLeavesByParam(Leave leave,Page page,Object[] objects);

    /**
     * 根据参数获得请假对象
     * @param leave
     * @return
     */
    Leave getByParam(Leave leave);

    /**
     * 修改请假
     * @param leave
     * @return
     */
    int updataLeavePeoperty(Leave leave);

}
