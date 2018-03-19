package cn.jboa.biz.impl;

import cn.jboa.biz.LeaveBiz;
import cn.jboa.dao.LeaveDao;
import cn.jboa.dao.Sys_EmployeeDao;
import cn.jboa.entity.Leave;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Department;
import cn.jboa.entity.Sys_Employee;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class LeaveBizImpl implements LeaveBiz {

    @Resource
    private LeaveDao leaveDao;

    @Resource
    private Sys_EmployeeDao sys_employeeDao;

    /**
     * 添加请假单方法
     * @param leave
     * @return
     */
    @Transactional
    public int addLeave(Leave leave) {
        return leaveDao.addLeave(leave);
    }

    /**
     * 获得部门或者员工下的请假集合
     * @param leave
     * @param page
     * @param sys_employee
     * @return
     */
    public Page getLeavesByPage(Leave leave, Page page, Sys_Employee sys_employee) {
        Object[] objects=null;
        //如果登录是员工，就获的此员工下的请假集合
        if(sys_employee.getSys_position().getNameCn().equals("员工")){
            objects=new Object[]{sys_employee};
        }else if(sys_employee.getSys_position().getNameCn().equals("部门经理")){
            //获得此部门下的所有员工对象
            List<Sys_Employee> employeeByDept = sys_employeeDao.getEmployeeByDept(new Sys_Department(sys_employee.getSys_department().getId()));
            objects=new Object[employeeByDept.size()];
            for(int i=0;i<employeeByDept.size();i++){
                objects[i]=new Sys_Employee(employeeByDept.get(i).getSn());
            }
        }
        return leaveDao.getLeavesByParam(leave,page,objects);
    }

    /**
     * 获得请假对象的方法
     * @param leave
     * @return
     */
    public Leave findLeave(Leave leave) {
        return leaveDao.getByParam(leave);
    }

    /**
     * 修改请假对象
     * @param leave
     * @return
     */
    public int updateLeaveProperty(Leave leave) {
        leave.setModifyTime(new Date());
        if(leave.getStatus().equals("已审批")){
            leave.setNext_Deal_Sn(null);
        }else if(leave.getStatus().equals("已打回")){
            leave.setNext_Deal_Sn(leave.getSys_employee().getSn());
        }
        return leaveDao.updataLeavePeoperty(leave);
    }
}
