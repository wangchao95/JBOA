package cn.jboa.entity;

import java.util.ArrayList;
import java.util.List;


public class Page<T> {

//    此处使用T泛型，表示如果new什么类型的对象，下面的集合就是什么类型的

    private int pageSize;  //每页数量
    private int currentPageNo;  //第几页
    private int totalPage;  //总页数
    private int  totalCount;  //总行数
    private List<T>  pageList=new ArrayList<T>();   //当前页的集合数

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        if(pageSize>0)
            this.pageSize = pageSize;
        else
           this.pageSize=5;
    }

    public int getCurrentPageNo() {
        return currentPageNo;
    }

    public void setCurrentPageNo(int currentPageNo) {
        if(currentPageNo>0)
            this.currentPageNo = currentPageNo;
        else
            this.currentPageNo=1;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        if(totalPage>0)
            this.totalPage = totalPage;
        else
            this.totalPage=1;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        if (totalCount>=0)
            this.totalCount = totalCount;
        else
            this.totalCount=0;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }
}
