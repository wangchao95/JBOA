package cn.jboa.dao;


import cn.jboa.entity.Biz_CheckResult;

/**
 * 审核记过dao
 */
public interface CheckResultDao {

    /**
     * @param checkResult
     * @return
     * 添加审核结果
     */
    int addCheckResult(Biz_CheckResult checkResult);

    /**
     * 获得审核结果对象
     * @param biz_checkResult
     * @return
     */
    Biz_CheckResult getCheckResult(Biz_CheckResult biz_checkResult);
}
