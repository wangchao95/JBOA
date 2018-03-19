package cn.jboa.biz.impl;

import cn.jboa.biz.Biz_ClaimBiz;
import cn.jboa.dao.Biz_ClaimDao;
import cn.jboa.dao.Biz_ClaimDetailDao;
import cn.jboa.dao.Sys_EmployeeDao;
import cn.jboa.entity.Biz_Claim;
import cn.jboa.entity.Biz_ClaimDetail;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class Biz_ClaimBizImpl implements Biz_ClaimBiz {

    @Resource
    private Biz_ClaimDao biz_claimDao;

    @Resource
    private Biz_ClaimDetailDao biz_claimDetailDao;

    @Resource
    private Sys_EmployeeDao sys_employeeDao;

    /**
     * 添加报销单
     * @param biz_claim
     * @return
     */
    @Transactional
    public int addBiz_Claim(Biz_Claim biz_claim) {
      int mainId= biz_claimDao.insertClaim(biz_claim);
       for (int i=0;i<biz_claim.getClaimDetailList().size();i++){
           biz_claim.getClaimDetailList().get(i).setMainId(mainId);
           biz_claimDetailDao.addClaimDetail(biz_claim.getClaimDetailList().get(i));
       }
       return 1;
    }

    /**
     * 员工/部门经理/财务  分页获得数据
     * @param biz_claim
     * @param page
     */
    public void findPageClaim(Biz_Claim biz_claim, Page page) {
        List<Sys_Employee> employeeByDept=null;
        int position=1;  //表示员工
        //如果不是普通员，就不需要获得创建者是登录者的报销单，部门经理
        if("部门经理".equals(biz_claim.getSys_empCreate().getSys_position().getNameCn())){
            //如果不是普通员，就不需要获得创建者是登录者的报销单
            biz_claim.setSys_empCreate(new Sys_Employee(biz_claim.getSys_empCreate().getSys_department()));
            position=2;
            //获得当前部门下面的员工
           employeeByDept = sys_employeeDao.getEmployeeByDept(biz_claim.getSys_empCreate().getSys_department());
        }else if("员工".equals(biz_claim.getSys_empCreate().getSys_position().getNameCn())){
            biz_claim.setSys_empCreate(new Sys_Employee(biz_claim.getSys_empCreate().getSn()));
            position=1;
            //如果登录用户是总经理
        }else if("总经理".equals(biz_claim.getSys_empCreate().getSys_position().getNameCn())){
            biz_claim.setSys_empNext(new Sys_Employee(biz_claim.getSys_empCreate().getSn()));
            position=3;
        }else if("财务".equals(biz_claim.getSys_empCreate().getSys_position().getNameCn())){
            biz_claim.setSys_empNext(new Sys_Employee(biz_claim.getSys_empCreate().getSn()));
            position=4;
        }
        biz_claimDao.getPageClaim(biz_claim,page,position,employeeByDept);
    }

    /**
     * 禅熏报销单
     * @param biz_claim
     * @return
     */
    public Biz_Claim queryClaimById(Biz_Claim biz_claim) {
        return biz_claimDao.findClaimById(biz_claim);
    }

    /**
     * 修改报销单
     * @param biz_claim
     * @return
     */
    @Transactional
    public int mergeClaim(Biz_Claim biz_claim) {

        //首先根据action拿到的这个不完整的报销对象的id，查询一下这个报销对象的全部属性值，
//        然后在吧页面修改的值替换一下，再修改
        Biz_Claim claimById = biz_claimDao.findClaimById(biz_claim);
        claimById.setEvent(biz_claim.getEvent());
        claimById.setStatus(biz_claim.getStatus());  //修改状态。可能变成了提交状态，有可能还是新创建状态
        claimById.setTotalAccount(biz_claim.getTotalAccount());
        claimById.setClaimDetailList(biz_claim.getClaimDetailList());   //重新设置一下报销详情集合，有可能增加了，减少了
        biz_claimDao.updateClaim(claimById);
        for (int i=0;i<biz_claim.getClaimDetailList().size();i++){
            //修改详情
            biz_claim.getClaimDetailList().get(i).setMainId(claimById.getId());
            biz_claimDetailDao.updateClaimDetail(biz_claim.getClaimDetailList().get(i));
        }
        return 1;
    }

    /**
     * 删除报销单和详情
     * @param biz_claim
     */
    @Transactional
    public int removeClaimAndDetail(Biz_Claim biz_claim) {
        try {
            Biz_Claim claimById = biz_claimDao.findClaimById(biz_claim);
            List<Biz_ClaimDetail> claimDetailList = claimById.getClaimDetailList();
            for(int i=0;i<claimDetailList.size();i++){
                biz_claimDetailDao.delClaimDetail(claimDetailList.get(i));
            }
            biz_claimDao.delClaim(claimById);
            return 1;
        }catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }
}
