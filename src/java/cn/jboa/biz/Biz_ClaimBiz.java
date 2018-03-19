package cn.jboa.biz;

import cn.jboa.entity.Biz_Claim;
import cn.jboa.entity.Page;

public interface Biz_ClaimBiz  {

    /**
     * 添加报销单
     * @param biz_claim
     * @return
     */
    int addBiz_Claim(Biz_Claim biz_claim);

    /**
     * 获得员工、部门经理、财务  每页显示的额数据
     * @param biz_claim
     * @param page
     */
    void findPageClaim(Biz_Claim biz_claim,Page page);


    /**
     * 查询报销单通过id
     * @param biz_claim
     * @return
     */
    Biz_Claim queryClaimById(Biz_Claim biz_claim);

    /**
     * 修改报销单
     * @param biz_claim
     * @return
     */
    int mergeClaim(Biz_Claim biz_claim);


    /**
     * 删除报销单和详情
     * @param biz_claim
     */
    int  removeClaimAndDetail(Biz_Claim biz_claim);

}
