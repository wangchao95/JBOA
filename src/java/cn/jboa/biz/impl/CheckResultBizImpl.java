package cn.jboa.biz.impl;

import cn.jboa.biz.Biz_ClaimBiz;
import cn.jboa.biz.CheckResultBiz;
import cn.jboa.biz.Sys_EmployeeBiz;
import cn.jboa.dao.Biz_ClaimDao;
import cn.jboa.dao.CheckResultDao;
import cn.jboa.entity.Biz_CheckResult;
import cn.jboa.entity.Biz_Claim;
import cn.jboa.entity.Sys_Employee;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.persistence.Transient;
import java.util.Date;

@Service
public class CheckResultBizImpl implements CheckResultBiz {

    @Resource
    private CheckResultDao checkResultDao;
    @Resource
    private Biz_ClaimDao biz_claimDao;

    @Resource
    private Sys_EmployeeBiz sys_employeeBiz;


    /**
     * 部门经理 添加审核结果 和 修改报销单
     *
     * @param checkResult
     * @return
     */
//    支持事务处理
    @Transactional
    public int addCheckResultByDM(Biz_CheckResult checkResult) {
        //通过报销编号，获得报销对象,设置到审核结果对象里面
        checkResult.setBiz_claim(biz_claimDao.findClaimById(new Biz_Claim(checkResult.getBiz_claim().getId())));
        checkResult.getBiz_claim().setModifyTime(new Date());
        //如果点击是审批通过按钮
        if (checkResult.getResult().equals("通过")) {
            if (checkResult.getBiz_claim().getTotalAccount() >= 5000) {
                //获得当前登录用户的下一个处理者
                Sys_Employee nextEmp = sys_employeeBiz.getNextEmp(1);
                checkResult.getBiz_claim().setSys_empNext(nextEmp);
                checkResult.getBiz_claim().setStatus("待审批");
            } else {
                //修改报销单的待处理人是财务部，状态是已审批
                //获得当前登录用户的下一个处理者的下一个，也就是财务
                Sys_Employee nextEmp = sys_employeeBiz.getNextEmp(2);
                checkResult.getBiz_claim().setSys_empNext(nextEmp);
                checkResult.getBiz_claim().setStatus("已审批");
            }
            //如果审批点击为拒绝
        } else if (checkResult.getResult().equals("拒绝")) {
            checkResult.getBiz_claim().setStatus("已终止");
            checkResult.getBiz_claim().setSys_empNext(new Sys_Employee());
            //如果点击打回按钮
        } else if (checkResult.getResult().equals("打回")) {
            checkResult.getBiz_claim().setStatus("已打回");
            //设置下一个处理者是创建者
            checkResult.getBiz_claim().setSys_empNext(checkResult.getBiz_claim().getSys_empCreate());
        }
        //修改报销单
        biz_claimDao.updateClaimProperty(checkResult.getBiz_claim());
        //插入审核结果
        return checkResultDao.addCheckResult(checkResult);
    }

    /**
     * 总经理 添加审核结果 和 修改报销单
     *
     * @param checkResult
     * @return
     */
    @Transactional
    public int addCheckResultByGM(Biz_CheckResult checkResult) {
        //通过报销编号，获得报销对象,设置到审核结果对象里面
        checkResult.setBiz_claim(biz_claimDao.findClaimById(new Biz_Claim(checkResult.getBiz_claim().getId())));
        checkResult.getBiz_claim().setModifyTime(new Date());
        //如果点击是审批通过按钮
        if (checkResult.getResult().equals("通过")) {
            //修改报销单的待处理人是财务部，状态是已审批
            //获得当前登录用户的下一个处理者的下一个，也就是财务
            Sys_Employee nextEmp = sys_employeeBiz.getNextEmp(1);
            checkResult.getBiz_claim().setSys_empNext(nextEmp);
            checkResult.getBiz_claim().setStatus("已审批");
            //如果审批点击为拒绝
        } else if (checkResult.getResult().equals("拒绝")) {
            checkResult.getBiz_claim().setStatus("已终止");
            checkResult.getBiz_claim().setSys_empNext(new Sys_Employee());
            //如果点击打回按钮
        } else if (checkResult.getResult().equals("打回")) {
            checkResult.getBiz_claim().setStatus("已打回");
            //设置下一个处理者是创建者
            checkResult.getBiz_claim().setSys_empNext(checkResult.getBiz_claim().getSys_empCreate());
        }
        //修改报销单
        biz_claimDao.updateClaimProperty(checkResult.getBiz_claim());
        //插入审核结果
        return checkResultDao.addCheckResult(checkResult);
    }

    /**
     * 财务  修改报销单和添加审核结果方法
     * @param  checkResult
     * @return
     */
    @Transactional
    public int addCheckResultByFinance(Biz_CheckResult checkResult) {
        //通过报销编号，获得报销对象,设置到审核结果对象里面
        checkResult.setBiz_claim(biz_claimDao.findClaimById(new Biz_Claim(checkResult.getBiz_claim().getId())));
        checkResult.getBiz_claim().setModifyTime(new Date());
            //设置下一个处理人是空，所以设置一个空对象
            checkResult.getBiz_claim().setSys_empNext(new Sys_Employee());
            checkResult.getBiz_claim().setStatus("已付款");
        //修改报销单
        biz_claimDao.updateClaimProperty(checkResult.getBiz_claim());
        //插入审核结果
        return checkResultDao.addCheckResult(checkResult);
    }
}
