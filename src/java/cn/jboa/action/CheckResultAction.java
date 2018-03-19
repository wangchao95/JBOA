package cn.jboa.action;

import cn.jboa.biz.CheckResultBiz;
import cn.jboa.entity.Biz_CheckResult;
import cn.jboa.entity.Sys_Employee;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.Date;

@Controller
public class CheckResultAction extends ActionSupport {

    @Resource
    private CheckResultBiz checkResultBiz;
    private Biz_CheckResult checkResult;

    public Biz_CheckResult getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(Biz_CheckResult checkResult) {
        this.checkResult = checkResult;
    }

    /**
     * 添加审核结果
     *
     * @return
     */
    public String check() {
        checkResult.setCheckTime(new Date());
        checkResult.setCheck_employee((Sys_Employee) ServletActionContext.getRequest().getSession().getAttribute("employee"));
        //如果当前登录的用户是部门经理，就进入部门经理的审核业务
        if(checkResult.getCheck_employee().getSys_position().getNameCn().equals("部门经理")){
            return checkResultBiz.addCheckResultByDM(checkResult) > 0 ? "success" : "fail";
            //如果当前登录的用户是总经理，就进入总经理的审核业务
        }else if(checkResult.getCheck_employee().getSys_position().getNameCn().equals("总经理")){
            return checkResultBiz.addCheckResultByGM(checkResult) > 0 ? "success" : "fail";
            //登录用户为  财务
        }else{
            return checkResultBiz.addCheckResultByFinance(checkResult) > 0 ? "success" : "fail";
        }
    }


}
