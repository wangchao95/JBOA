package cn.jboa.dao.impl;

import cn.jboa.dao.LeaveDao;
import cn.jboa.entity.Leave;
import cn.jboa.entity.Page;
import cn.jboa.entity.Sys_Employee;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LeaveDaoImpl extends HibernateDaoSupport implements LeaveDao {


    /**
     * 添加请假单
     * @param leave
     * @return
     */
    public int addLeave(Leave leave) {
        return (Integer) getHibernateTemplate().save(leave);
    }

    /**
     * 获得   员工或者部门  下的请假集合
     * @param leave
     * @return
     */
    public Page getLeavesByParam(Leave leave,Page page,Object[] objects) {
        Criteria criteria=this.currentSession().createCriteria(Leave.class);
        if(leave!=null){
            //如果开始时间不等于空
            if(leave.getStartTime()!=null){
                criteria.add(Restrictions.ge("startTime",leave.getStartTime()));
            }
            //如果结束时间不等于空
            if(leave.getEndTime()!=null){
                criteria.add(Restrictions.le("endTime",leave.getEndTime()));
            }
            if(objects!=null && objects.length>0){
                criteria.add(Restrictions.in("sys_employee",objects));
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
        return page;
    }

    /**
     * 获得请假对象
     * @param leave
     * @return
     */
    public Leave getByParam(Leave leave) {
        return this.getHibernateTemplate().get(Leave.class,leave.getId());
    }

    /**
     * 修改请假
     * @param leave
     * @return
     */
    public int updataLeavePeoperty(Leave leave) {
        String hql="update Leave set status=?,next_Deal_Sn=?,approve_opinion=?,modifyTime=? where id=?";
        return super.getHibernateTemplate().bulkUpdate(hql, new Object[]{leave.getStatus(),
                leave.getNext_Deal_Sn(),leave.getApprove_opinion(),leave.getModifyTime(),leave.getId()});
    }


}
