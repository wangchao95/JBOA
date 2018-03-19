package cn.jboa.dao;

import cn.jboa.entity.Biz_Claim;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;
import org.hibernate.sql.Update;

import java.util.List;

public interface Biz_ClaimDao {

    /**
     * 添加报销单
     * @param biz_claim
     * @return
     */
    int insertClaim(Biz_Claim biz_claim);


    /**
     * 获得员工每页显示的数据
     * @param biz_claim
     * @param page
     */
    void getPageClaim(Biz_Claim biz_claim, Page page,int position,List<Sys_Employee> sys_employeeList);


    /**
     * 根据id查询报销单
     * @param biz_claim
     * @return
     */
    Biz_Claim findClaimById(Biz_Claim biz_claim);

    /**
     * 修改报销单
     * @param biz_claim
     * @return
     */
    void updateClaim(Biz_Claim biz_claim);

    /**
     * 删除报销单
     * @param biz_claim
     */
    void delClaim(Biz_Claim biz_claim);

    /**
     * 修改其中的属性值
     * @param biz_claim
     */
    int updateClaimProperty(Biz_Claim biz_claim);

}
