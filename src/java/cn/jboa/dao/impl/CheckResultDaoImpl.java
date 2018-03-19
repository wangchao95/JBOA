package cn.jboa.dao.impl;

import cn.jboa.dao.CheckResultDao;
import cn.jboa.entity.Biz_CheckResult;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class CheckResultDaoImpl extends HibernateDaoSupport implements CheckResultDao {


    /**
     * 添加审核结果
     * @param checkResult
     * @return
     */
    public int addCheckResult(Biz_CheckResult checkResult) {
        return (Integer) this.getHibernateTemplate().save(checkResult);
    }

    /**
     * 获得审核结果对象
     * @param biz_checkResult
     * @return
     */
    public Biz_CheckResult getCheckResult(Biz_CheckResult biz_checkResult) {
        return (Biz_CheckResult) this.currentSession().get(Biz_CheckResult.class,biz_checkResult.getId());
    }


}
