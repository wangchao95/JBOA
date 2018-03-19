package cn.jboa.action;

import cn.jboa.biz.Biz_ClaimBiz;
import cn.jboa.biz.Sys_EmployeeBiz;
import cn.jboa.entity.*;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
public class Biz_ClaimBizAction extends ActionSupport {

    @Resource
    private Biz_ClaimBiz biz_claimBiz;
    @Resource
    private Sys_EmployeeBiz sys_employeeBiz;

    private Biz_Claim biz_claim;   //报销单对象
    private List<Biz_ClaimDetail> detailList;   //报销详情集合
    private Biz_ClaimDetail biz_claimDetail;   //一个报销详情对象
    private Page page=new Page();
    private String index;  //页数 和报销的id  公用一个
    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }
    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public Biz_ClaimDetail getBiz_claimDetail() {
        return biz_claimDetail;
    }

    public void setBiz_claimDetail(Biz_ClaimDetail biz_claimDetail) {
        this.biz_claimDetail = biz_claimDetail;
    }

    private Date date;
    public List<Biz_ClaimDetail> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<Biz_ClaimDetail> detailList) {
        this.detailList = detailList;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Biz_Claim getBiz_claim() {
        return biz_claim;
    }

    public void setBiz_claim(Biz_Claim biz_claim) {
        this.biz_claim = biz_claim;
    }

    /**
     * 到添加报销单页面
     * @return
     */
    public String to(){
        date=new Date(System.currentTimeMillis());
        return "toClaim";
    }


    /**
     * 添加报销单
     * @return
     */
    public  String add(){
        //获得登录的员工
        Sys_Employee employee = (Sys_Employee) (ServletActionContext.getRequest().getSession().getAttribute("employee"));
        biz_claim.setSys_empCreate(employee);
        biz_claim.setCreateTime(new Date());
        if(biz_claim.getStatus().equals("新创建")){
            //下一个处理的人
            biz_claim.setSys_empNext(employee);
        }else{
            //获得下一个处理的人
           biz_claim.setSys_empNext(sys_employeeBiz.getNextEmp(1));
        }
        biz_claim.setClaimDetailList(detailList);
        return biz_claimBiz.addBiz_Claim(biz_claim)>0?"successAdd":"failAdd";
    }


    /**
     * 到查询页面
     * @return
     */
    public String toSearch(){
        return "toSearch";
    }

    /**
     * 分页获得数据
     * @return
     */
    public String findPage(){
        page.setPageSize(3);
        page.setCurrentPageNo(Integer.parseInt(index));
        Sys_Employee employee = (Sys_Employee) (ServletActionContext.getRequest().getSession()).getAttribute("employee");
        //获得用户 如果是普通员工，就设置一个创建者是登录的人，就可以获得该登录用户发布的报销单
        biz_claim.setSys_empCreate(employee);
        biz_claimBiz.findPageClaim(biz_claim,page);
        return "success";
    }

    /**
     * 查询报销申请
     * @return
     */
    public String search(){
        biz_claim = biz_claimBiz.queryClaimById(new Biz_Claim(Integer.parseInt(index)));
        return  biz_claim==null?"failToFind":"successFind";
    }

    /**
     *到 修改报销单页面
     * @return
     */
    public String update(){
        biz_claim = biz_claimBiz.queryClaimById(new Biz_Claim(Integer.parseInt(index)));
        return  biz_claim==null?"failToUpdate":"successToUpdate";
    }


    /**
     * 修改报销单
     * @return
     */
    public String excuteUpdate(){
        if(!biz_claim.getStatus().equals("新创建")) {
            //获得下一个处理的人
            biz_claim.setSys_empNext(sys_employeeBiz.getNextEmp(1));
        }
        biz_claim.setClaimDetailList(detailList);
        return biz_claimBiz.mergeClaim(biz_claim)>0?"updateSuccess":"updateFail";
    }


    /**
     * 删除报销单
     * @return
     */
    public String del(){
        index= biz_claimBiz.removeClaimAndDetail(new Biz_Claim(Integer.parseInt(index)))>0?"删除成功":"删除失败";
        return "delSuccess";
    }

    /**
     * 到审核页面
     * @return
     */
    public String toCheck(){
        biz_claim = biz_claimBiz.queryClaimById(new Biz_Claim(Integer.parseInt(index)));
        return  biz_claim==null?"failToCheck":"successToCheck";
    }
}
