package cn.jboa.dao.impl;

import cn.jboa.dao.Sys_EmployeeDao;
import cn.jboa.entity.Sys_Department;
import cn.jboa.entity.Sys_Employee;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class Sys_EmployeeDaoImpl extends HibernateDaoSupport implements Sys_EmployeeDao {


    /**
     * 获得用户对象
     * @param sys_employee
     * @return
     */
    public Sys_Employee getEmployee(Sys_Employee sys_employee) {
        Criteria criteria = this.currentSession().createCriteria(Sys_Employee.class);
        if(sys_employee!= null){
            if(!"".equals(sys_employee.getSn()) && sys_employee.getSn() != null ){
                criteria.add(Restrictions.eq("sn",sys_employee.getSn()));
            }
            if(sys_employee.getPassword() != null && !"".equals(sys_employee.getPassword())){
                criteria.add(Restrictions.eq("password",sys_employee.getPassword()));
            }
            if(sys_employee.getSys_department() !=null && sys_employee.getSys_department().getId() > 0){
                criteria.add(Restrictions.eq("sys_department",sys_employee.getSys_department()));
            }
            if(sys_employee.getSys_position()!=null && sys_employee.getSys_position().getId() > 0){
                criteria.add(Restrictions.eq("sys_position",sys_employee.getSys_position()));
            }
        }
        return (Sys_Employee) criteria.uniqueResult();
    }

    /**
     * 获得部门下的员工集合
     * @param sys_department
     * @return
     */
    public List<Sys_Employee> getEmployeeByDept(Sys_Department sys_department) {
        String hql="from Sys_Employee e where e.sys_department.id=:id";
       return  this.currentSession().createQuery(hql).setProperties(sys_department).list();
    }

}
