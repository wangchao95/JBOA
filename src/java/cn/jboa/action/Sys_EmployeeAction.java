package cn.jboa.action;

import cn.jboa.biz.Sys_EmployeeBiz;
import cn.jboa.entity.Sys_Employee;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
public class Sys_EmployeeAction extends ActionSupport {

    @Resource
    private Sys_EmployeeBiz sys_employeeBiz;
    private Sys_Employee employee;

    public Sys_Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Sys_Employee employee) {
        this.employee = employee;
    }

    /**
     * 登录方法
     * @return
     */
    public  String login(){
        employee = sys_employeeBiz.login(employee);
        if(employee!=null){
           ServletActionContext.getRequest().getSession().setAttribute("employee",employee);
            return "success";
        }
        return "fail";
    }

    /**
     * 到主页面
     * @return
     */
    public String toIndex(){
        return "successIndex";
    }

}
