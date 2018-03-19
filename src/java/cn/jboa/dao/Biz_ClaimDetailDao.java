package cn.jboa.dao;

import cn.jboa.entity.Biz_ClaimDetail;

public interface Biz_ClaimDetailDao{

    /**
     * 保存详情对象
     * @param biz_claimDetail
     * @return
     */
    int addClaimDetail(Biz_ClaimDetail biz_claimDetail);


    /**
     * 修改详情
     * @param biz_claimDetail
     */
    void updateClaimDetail(Biz_ClaimDetail biz_claimDetail);

    /**
     * 删除详情
     * @param biz_claimDetail
     * @return
     */
    void delClaimDetail(Biz_ClaimDetail biz_claimDetail);

}
