package cn.jboa.dao.impl;

import cn.jboa.dao.Biz_ClaimDao;
import cn.jboa.entity.Biz_Claim;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;
import com.sun.org.apache.regexp.internal.RE;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.Expression;
import javax.swing.plaf.nimbus.NimbusLookAndFeel;
import java.io.Serializable;
import java.util.List;

@Repository
public class Biz_ClaimDaoImpl extends HibernateDaoSupport implements Biz_ClaimDao {


    /**
     * 添加报销单
     *
     * @param biz_claim
     * @return
     */
    public int insertClaim(Biz_Claim biz_claim) {
        return (Integer) this.getHibernateTemplate().save(biz_claim);
    }

    /**
     * 获得每页显示的数据
     *
     * @param biz_claim
     * @param page
     */
    public void getPageClaim(Biz_Claim biz_claim, Page page, int position, List<Sys_Employee> sys_employeeList) {
        Criteria criteria = this.currentSession().createCriteria(Biz_Claim.class);
        //如果不等于空，就进去
        if (biz_claim != null) {
            if (biz_claim.getStatus() != null && !"全部".equals(biz_claim.getStatus())) {
                criteria.add(Restrictions.eq("status", biz_claim.getStatus()));
            }
            if (biz_claim.getBeginTime() != null) {
                criteria.add(Restrictions.ge("createTime", biz_claim.getBeginTime()));
            }
            if (biz_claim.getEndTime() != null) {
                criteria.add(Restrictions.le("createTime", biz_claim.getEndTime()));
            }
            //普通员工
            if(position==1){
                if (biz_claim.getSys_empCreate() != null && !"".equals(biz_claim.getSys_empCreate().getSn())) {
                    criteria.add(Restrictions.eq("sys_empCreate", biz_claim.getSys_empCreate()));
                }
            }
            //部门经理
            if(position==2){
                //部门经理
                if((biz_claim.getSys_empCreate().getSys_department()!=null)){
                    criteria.add(Restrictions.in("sys_empCreate",sys_employeeList));
                }
                criteria.add(Restrictions.ne("status","新创建"));
            }
            //总经理或者财务都是根据下一个执行者是登录用户查询
            if(position==3||position==4){
                //总经理,如果下一个执行者不等于null，并且报销单的下一个执行者是当前登录的总经理
                if((biz_claim.getSys_empNext()!=null)){
                    criteria.add(Restrictions.eq("sys_empNext",biz_claim.getSys_empNext()));
                }
                criteria.add(Restrictions.ne("status","新创建"));
            }
            criteria.addOrder(Order.desc("createTime"));  //日期降序
        }
        //统计行数
        criteria.setProjection(Projections.count("id"));
        //设置总行数
        page.setTotalCount(((Long) criteria.uniqueResult()).intValue());
        //设置总页数
        page.setTotalPage((page.getTotalCount() + page.getPageSize() - 1) / page.getPageSize());
        //清空查询的那个单列，全部查询
        criteria.setProjection(null);
        criteria.setFirstResult((page.getCurrentPageNo() - 1) * page.getPageSize()).setMaxResults(page.getPageSize());
        //查询每页显示的行数
        page.setPageList(criteria.list());
    }

    /**
     * 查询报销单，根据id
     * @param biz_claim
     * @return
     */
    public Biz_Claim findClaimById(Biz_Claim biz_claim) {
        return (Biz_Claim) this.currentSession().get(Biz_Claim.class,biz_claim.getId());
    }

    /**
     * 修改报销单
     * @param biz_claim
     * @return
     */
    public void updateClaim(Biz_Claim biz_claim) {
         this.currentSession().saveOrUpdate(biz_claim);
    }

    /**
     * 删除报销单
     * @param biz_claim
     */
    public void delClaim(Biz_Claim biz_claim) {
        this.currentSession().delete(biz_claim);
    }

    /**
     * 修改属性值
     * @param biz_claim
     */
    public int updateClaimProperty(Biz_Claim biz_claim) {
        String hql="update Biz_Claim b set b.status=?,b.sys_empNext.sn=? where b.id=?";
        return super.getHibernateTemplate().bulkUpdate(hql, new Object[]{biz_claim.getStatus(),
                biz_claim.getSys_empNext().getSn(),biz_claim.getId()});
    }

}
