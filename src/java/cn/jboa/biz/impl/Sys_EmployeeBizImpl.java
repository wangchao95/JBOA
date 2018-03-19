package cn.jboa.biz.impl;

import cn.jboa.biz.Sys_EmployeeBiz;
import cn.jboa.dao.Sys_EmployeeDao;
import cn.jboa.entity.Sys_Department;
import cn.jboa.entity.Sys_Employee;
import cn.jboa.entity.Sys_Position;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class Sys_EmployeeBizImpl implements Sys_EmployeeBiz {


    @Resource
    private Sys_EmployeeDao sys_employeeDao;


    /**
     * 登录方法
     * @param sys_employee
     * @return
     */
    public Sys_Employee login(Sys_Employee sys_employee) {
        if(sys_employee!=null && !"".equals(sys_employee.getSn()) && !"".equals(sys_employee.getPassword())){
            return sys_employeeDao.getEmployee(sys_employee);
        }
        return null;
    }

    /**
     * 获得下一个号处理人
     * @param sys_employee
     * @return
     */
    public  Sys_Employee getNextEmployee(Sys_Employee sys_employee){
        if(sys_employee!=null){
            //表示是普通员工，找他的下一个处理人：应该是职位比他大1，然后个部门的
            if(sys_employee.getSys_position().getId()>2){
                sys_employee.setSys_department(new Sys_Department(0));
            }
            return sys_employeeDao.getEmployee(sys_employee);
        }
        return null;
    }



    /**
     * 获得下一个处理者
     * @return
     */
    public  Sys_Employee getNextEmp(int span){
        Sys_EmployeeBiz sys_employeeBiz=new Sys_EmployeeBizImpl();
        Sys_Employee employee = (Sys_Employee) (ServletActionContext.getRequest().getSession().getAttribute("employee"));
        Sys_Employee queryE=new Sys_Employee();
        Sys_Department sys_department=new Sys_Department();
        sys_department.setId(employee.getSys_department().getId());
        queryE.setSys_department(sys_department);
        Sys_Position sys_position=new Sys_Position();
        sys_position.setId(employee.getSys_position().getId()+1);
        if(span==2){
            sys_position.setId(employee.getSys_position().getId()+2);
        }
        queryE.setSys_position(sys_position);
        return this.getNextEmployee(queryE);
    }
}
