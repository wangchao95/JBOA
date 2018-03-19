$(document).ready(function() {
    /**
     * 分页的方法
     */

    var currentPageNo;

    function page(pageNo) {
        currentPageNo=pageNo;
        $("#queryForm").ajaxSubmit({
            type: 'post',
            url: "findPageClaim.action",
            data:{index:pageNo},
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                var claimList=data.page.pageList;  //获得页的集合
                $("#tableInfo .content").remove();
                $(".page").remove();
                //循环遍历集合
                for(var i=0;i<claimList.length;i++){
                    var claim=claimList[i];
                    var nextName=claim.sys_empNext==null?"无":claim.sys_empNext.name;
                    $("#tableInfo").append("<tr class='content'><td><a class='lookCalim' calimId='"+claim.id+"'>"+claim.id+"</a></td>" +
						"<td>"+claim.createTime+"</td><td>"+claim.sys_empCreate.name+"</td><td>"+claim.totalAccount+"</td><td>"+claim.status+"</td>" +
						"<td>"+nextName+"</td><td></td></tr>");

                        //普通员工的操作栏
                        if($("#positionName").val()=="员工"){
                            if(claim.status=="新创建"||claim.status=="已打回"){
                                $("td:last").append("<a class='updateCalim' calimId='"+claim.id+"'>" +
                                    "<img src='/images/edit.gif' width='16' height='16'/></a><a class='delCalim' calimId='"+claim.id+"'>" +
                                    "<img src='/images/delete.gif' width='16' height='16'/></a>");
                            }
                            $("td:last").append("<img src='/images/save.gif' width='16' height='16'/><a class='lookCalim' calimId='"+claim.id+"'><img src='/images/search.gif' width='16' height='15'/></a>");
                        }

                        //部门经理,当前用户为部门经理
                        if ($("#positionName").val()=="部门经理"){
                            $("td:last").append("<a class='lookCalim' calimId='"+claim.id+"'><img src='/images/search.gif' width='16' height='15'/></a>");
                            if((nextName!="无" && claim.sys_empNext.name==$("#employeeId").val())&&(claim.status=="已提交" ||claim.status=="待审批")){
                                    $("td:last").append("<a class='toCheckCalim' calimId='"+claim.id+"'>" +
                                        "<img src='/images/sub.gif' width='16' height='16'/></a>");
                            }
                        }
                    //总经理,当前用户为总经理
                    if ($("#positionName").val()=="总经理"){
                        $("td:last").append("<a class='lookCalim' calimId='"+claim.id+"'><img src='/images/search.gif' width='16' height='15'/></a>");
                        if(claim.status=="待审批"){
                            $("td:last").append("<a class='toCheckCalim' calimId='"+claim.id+"'>" +
                                "<img src='/images/sub.gif' width='16' height='16'/></a>");
                        }
                    }
                    //财务,当前用户为财务
                    if ($("#positionName").val()=="财务"){
                        $("td:last").append("<a class='lookCalim' calimId='"+claim.id+"'><img src='/images/search.gif' width='16' height='15'/></a>");
                        if(claim.status=="已审批"){
                            $("td:last").append("<a class='toCheckCalim' calimId='"+claim.id+"'>" +
                                "<img src='/images/sub.gif' width='16' height='16'/></a>");
                        }
                    }
                }
                var $div=$("<div class='page'></div>").appendTo($(".pages"));
                var $operArea=$("<p align='center'>共"+data.page.totalCount+"条记录&nbsp;&nbsp;&nbsp;当前页数:["+data.page.currentPageNo+"/"+data.page.totalPage+"]&nbsp;</p>").appendTo($div);
                if(data.page.currentPageNo>1){
                    var $first=$("<a href=\"javascript:;\" id='1' class=\"first\" >首页</a>");
                    var $perv=$("<a href=\"javascript:;\" class='pre' id='"+(data.page.currentPageNo-1)+"'>上一页</a>");
                    $div.append($first).append("&nbsp;").append($perv);   //添加到元素里面
                }
                //如果当前页数小于总页数
                if(data.page.currentPageNo<data.page.totalPage){
                    var $thred=$("<a href=\"javascript:;\" class='next'  id='"+(data.page.currentPageNo+1)+"'>下一页</a>");
                    var $last=$("<a href=\"javascript:;\" class='last'  id='"+data.page.totalPage+"'>末页</a>");
                    $div.append($thred).append("&nbsp;").append($last);   //添加到元素里面
                }
                var $go=$("<span style='float: right'><label>跳转至</label>\n" +
                    "\t<input type=\"text\" name=\"inputPage\" totalPage='"+data.page.totalPage+"' id=\"inputPage\" value='' class=\"page-key\" />页\n" +
                    "\t<button type=\"button\" class=\"page-btn\">GO</button>\n" +
                    "\t\t</span>");
                $div.append($go);
            }
        });
    }
    page(1);  //初始化页面的用户


    /**
     * 查看报销申请
     */
    $(".pages").on("click",".lookCalim",function(){
        location.href="searchClaim.action?index="+$(this).attr("calimId");
    })

    /**
     * 到啊修改报销申请页面填充数据
     */
    $(".pages").on("click",".updateCalim",function(){
        location.href="updateClaim.action?index="+$(this).attr("calimId");
    })


    /**
     * 删除
     * @param id
     */

    $(".pages").on("click",".delCalim",function(){
        if(!confirm('确定删除报单吗')) return;
        $.post("delClaim.action","index="+$(this).attr("calimId"),function(data){
            alert(data.index);
            page(currentPageNo);
        });
    })

    /**
     * 审核填充数据
     */
    $(".pages").on("click",".toCheckCalim",function(){
        location.href="toCheckClaim.action?index="+$(this).attr("calimId");
    })

    /**
     * 点击上下页来显示列表
     */
    $(".pages").on("click",".last,.first,.pre,.next",function(){
        var pageNo=this.id;
        page(pageNo);
    })

    /**
     * 搜索的方法
     */
    $("#search").click(function(){
        page(1);
    })


    //点击go去的页面
    $(".pages").on("click",".page-btn",function(){
        var inputPage=$("#inputPage").val();
        var tatalPage= $("#inputPage").attr("totalPage");
        jump_to(inputPage,tatalPage);
    });

    //验证输入的是否合法
    function jump_to(num,totalPage){
        //alert(num);
        //验证用户的输入
        var regexp=/^[1-9]\d*$/;
        if(!regexp.test(num)){
            alert("请输入大于0的正整数！");
            return false;
        }else if((num-totalPage) > 0){
            alert("请输入小于总页数的页码");
            return false;
        }else{
            page(num);
        }
    }
})
