package cn.jboa.action;

import cn.jboa.biz.LeaveBiz;
import cn.jboa.biz.Sys_EmployeeBiz;
import cn.jboa.entity.Leave;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.Date;

@Controller
public class LeaveAction extends ActionSupport {

    @Resource
    private LeaveBiz leaveBiz;
    @Resource
    private Sys_EmployeeBiz sys_employeeBiz;
    private Leave leave;   //请假对象
    private Sys_Employee sys_employee;  //下一个处理者
    private Page page=new Page();
    private String index;   //当前页数
    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public Sys_Employee getSys_employee() {

        return sys_employee;
    }

    public void setSys_employee(Sys_Employee sys_employee) {
        this.sys_employee = sys_employee;
    }

    public Leave getLeave() {
        return leave;
    }

    public void setLeave(Leave leave) {
        this.leave = leave;
    }

    /**
     * 到添加请假单页面
     * @return
     */
    public String toSave(){
        //因为是普通员工，添加请假单，所以应该给同部门的部门经理职位，1表示：职位的编号加 1
        sys_employee=sys_employeeBiz.getNextEmp(1);
        return "toSuccess";
    }


    /**
     * 添加请假单方法
     * @return
     */
    public String save(){
        //当前登录的员工
        Sys_Employee employee = (Sys_Employee) ServletActionContext.getRequest().getSession().getAttribute("employee");
        leave.setCreateTime(new Date());
        leave.setStatus("待审批");
        leave.setSys_employee(new Sys_Employee(employee.getSn()));
        return leaveBiz.addLeave(leave)>0?"addSuccess":"addFail";
    }

    /**
     * 到请假的查询页面
     * @return
     */
    public String toSearch(){
        return "toLeaveSuccess";
    }

    /**
     * 获得请假集合
     * @return
     */
    public String queryPage(){
        page.setPageSize(3);
        page.setCurrentPageNo(Integer.parseInt(index));
        //获得登录的用户
        Sys_Employee employee = (Sys_Employee)(ServletActionContext.getRequest().getSession()).getAttribute("employee");
        page=leaveBiz.getLeavesByPage(leave,page,employee);
        return "successPage";
    }

    /**
     * 查询请假内容
     * @return
     */
    public String search(){
        leave = leaveBiz.findLeave(new Leave(Integer.parseInt(index)));
       return leave==null?"searchFail":"searchSuccess";
    }

    /**
     * 审核
     * @return
     */
    public String toCheck(){
        leave = leaveBiz.findLeave(new Leave(Integer.parseInt(index)));
        return leave==null?"toCheckFail":"toCheckSuccess";
    }

    /**
     * 审核请假
     * @return
     */
    public String check(){
        //修改
        return leaveBiz.updateLeaveProperty(leave)>0?"checkSuccess":"checkFail";
    }
}
