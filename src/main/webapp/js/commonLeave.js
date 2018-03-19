$(document).ready(function() {
    /**
     * 分页的方法
     */

    var currentPageNo;

    function page(pageNo) {
        currentPageNo=pageNo;
        $("#queryForm").ajaxSubmit({
            type: 'post',
            url: "queryPageLeave.action",
            data:{index:pageNo},
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                var leaveList=data.page.pageList;  //获得页的集合
                $("#tableInfo .content").remove();
                $(".page").remove();
                //循环遍历集合
                for(var i=0;i<leaveList.length;i++){
                    var leave=leaveList[i];
                    var name=$("#empName").val();   //请假人
                    $("#tableInfo").append("<tr class='content'><td><a class='lookLeave' leaveId='"+leave.id+"'>"+leave.id+"</a></td>" +
						"<td>"+name+"请假  "+leave.leaveDay+" 天</td><td>"+leave.createTime+"</td><td>"+leave.modifyTime+"</td><td>"+leave.approve_opinion+"</td>" +
						"<td>"+leave.status+"</td><td></td></tr>");

                        //普通员工的操作栏
                        if($("#positionName").val()=="员工"){
                            if(leave.status=="已打回"){
                                $("td:last").append("<a class='updateLeave' leaveId='"+leave.id+"'>" +
                                    "<img src='/images/edit.gif' width='16' height='16'/></a>");
                            }
                        }
                        $("td:last").append("<a class='lookLeave' leaveId='"+leave.id+"'><img src='/images/search.gif' width='16' height='15'/></a>");
                        //部门经理,当前用户为部门经理
                        if ($("#positionName").val()=="部门经理"){
                            if(leave.status=="待审批"){
                                    $("td:last").append("<a class='toCheckLeave' leaveId='"+leave.id+"'>" +
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
     * 查看请假申请
     */
    $(".pages").on("click",".lookLeave",function(){
        location.href="searchLeave.action?index="+$(this).attr("leaveId");
    })

    /**
     * 到啊修改请假申请页面填充数据
     */
    $(".pages").on("click",".updateLeave",function(){
        location.href="updateLeave.action?index="+$(this).attr("leaveId");
    })

    /**
     * 审核填充数据
     */
    $(".pages").on("click",".toCheckLeave",function(){
        location.href="toCheckLeave.action?index="+$(this).attr("leaveId");
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
