package cn.jboa.biz;

import cn.jboa.biz.impl.Sys_EmployeeBizImpl;
import cn.jboa.entity.Sys_Department;
import cn.jboa.entity.Sys_Employee;
import cn.jboa.entity.Sys_Position;
import org.apache.struts2.ServletActionContext;

public interface Sys_EmployeeBiz {

    /**
     * 登录方法
     * @param sys_employee
     * @return
     */
    Sys_Employee login(Sys_Employee sys_employee);

    /**
     * 获得下一个处理人
     * @param sys_employee
     * @return
     */
     Sys_Employee getNextEmployee(Sys_Employee sys_employee);


    /**
     * 获得下一个处理者
     * @return
     */
    public  Sys_Employee getNextEmp(int span);

}
