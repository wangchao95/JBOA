package cn.jboa.dao.impl;

import cn.jboa.dao.Biz_ClaimDetailDao;
import cn.jboa.entity.Biz_ClaimDetail;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class Biz_ClaimDetailDaoImpl extends HibernateDaoSupport implements Biz_ClaimDetailDao {


    /**
     * 添加报销详情
     * @param biz_claimDetail
     * @return
     */
    public int addClaimDetail(Biz_ClaimDetail biz_claimDetail) {
        return (Integer)this.currentSession().save(biz_claimDetail);
    }

    /**
     * 修改详情
     * @param biz_claimDetail
     */
    public void updateClaimDetail(Biz_ClaimDetail biz_claimDetail) {
        this.currentSession().merge(biz_claimDetail);
    }

    /**
     * 删除详情
     * @param biz_claimDetail
     * @return
     */
    public void delClaimDetail(Biz_ClaimDetail biz_claimDetail) {
        this.currentSession().delete(biz_claimDetail);
    }

}
