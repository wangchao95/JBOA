package cn.jboa.dao;

import cn.jboa.entity.Sys_Department;
import cn.jboa.entity.Sys_Employee;

import java.util.List;

/**
 * 员工dao
 */
public interface Sys_EmployeeDao  {

    /**
     * 获得用户对象
     * @param sys_employee
     * @return
     */
    Sys_Employee getEmployee(Sys_Employee sys_employee);

    /**
     * 获得部门下的员工
     * @return
     */
    List<Sys_Employee> getEmployeeByDept(Sys_Department sys_department);



}
