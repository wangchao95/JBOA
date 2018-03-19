package cn.jboa.biz;

import cn.jboa.entity.Biz_CheckResult;

/**
 * 审核结果业务类
 */
public interface CheckResultBiz {

    /**
     * 部门经理 添加审核结果和修改报销单信息
     * @param checkResult
     * @return
     */
    int addCheckResultByDM(Biz_CheckResult checkResult);

    /**
     * 总经理 添加审核结果和修改报销单信息
     * @param checkResult
     * @return
     */
    int addCheckResultByGM(Biz_CheckResult checkResult);


    /**
     * 财务  添加审核和修改报销单的信息
     * @param biz_checkResult
     * @return
     */
    int addCheckResultByFinance(Biz_CheckResult biz_checkResult);

}
