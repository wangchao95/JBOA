<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonLeave.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script>
	$(function(){
			 //日期选择控件
		 	$("#startDate").click(function(){
				WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',isShowClear:true, readOnly:true });
			});
			$("#endDate").click(function(){
				WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',isShowClear:true, readOnly:true });
			});
		});
</script>
<div class="action  divaction">
	<div class="t">请假列表</div>
	<div class="pages">
		<div class="forms" style="margin-top: 15px;margin-bottom: 15px">
		<s:form action="" method="POST" id="queryForm" name="queryForm">
			<input type="hidden" value="${employee.name}" id="empName"/>
			<input type="hidden" value="${employee.sys_position.nameCn}" id="positionName"/>
	       <p style="float: left">开始时间</p>
			<p style="float: left;margin-left: 20px"><input name="leave.startTime" id="startDate" class="nwinput"/></p>
			<p style="float: left;margin-left: 20px">结束时间</p>
			<p style="float: left;margin-left: 20px"> <input type="text" name="leave.startTime" id="endDate" class="nwinput"/></p>
	       <input type="hidden" name="pageNo" value="1"/>
		   <input type="hidden" name="pageSize" value="5"/>
			<p style="float: left;margin-left: 30px"><input value="查   询" type="button" id="search" class="submit_01"/></p>
	     </s:form>
	     </div>
	<!--增加报销单 区域 开始-->
		<table width="90%" border="0" id="tableInfo" cellspacing="0" cellpadding="0" class="list items">
	      <tr class="even">
	        <td>编号</td>
	        <td>名称</td>
	        <td>发起时间</td>
	        <td>审批时间</td>
	        <td>审批意见</td>
	        <td>审批状态</td>
	        <td>操作</td>
	      </tr>

			<tr class="content">
				<%--内容--%>

			</tr>


	      <%--<s:iterator value="pageSupport.items" id="leave"  status="s">--%>
	      <%--<tr>--%>
	        <%--<td><a href="leave_getLeaveById.action?leave.id=<s:property value="#leave.id"/>"><s:property value="#leave.id"/></a></td>--%>
	        <%--<td><s:property value="#leave.creator.name"/>请假<s:property value="#leave.leaveDay"/>天</td>--%>
	        <%--<td><s:date name="#leave.createTime" format="yyyy-MM-dd HH:mm"/></td>--%>
	        <%--<td><s:date name="#leave.ModifyTime" format="yyyy-MM-dd HH:mm"/></td>--%>
	        <%--<td><s:property value="#leave.approveOpinion"/></td>--%>
	        <%--<td><s:property value="#leave.status"/></td>--%>
	        <%--<td>--%>
	       	 <%--<a href="leave_getLeaveById.action?leave.id=<s:property value="#leave.id"/>"><img src="${images}/search.gif" width="16" height="15" /></a>--%>
	       	  <%--<s:if test="#leave.nextDeal.name == #session.employee.name">--%>
		        <%--<s:if test="#leave.status == '待审批'">--%>
	       	 		<%--<a href="leave_toCheck.action?leave.id=<s:property value="#leave.id"/>">--%>
	       	 		<%--<img src="${images}/sub.gif" width="16" height="16" /></a> --%>
	       	 	<%--</s:if>--%>
	       	 <%--</s:if>--%>
	        <%--</td>--%>
	      <%--</tr>--%>
	      <%--</s:iterator>--%>
	      <%--<tr>--%>
	        <%--<td colspan="7" align="center">--%>
		      	<%--<c:import url="../common/rollPage.jsp" charEncoding="UTF-8">--%>
				<%--<c:param name="formName" value="document.forms[0]"/>--%>
				<%--<c:param name="totalRecordCount" value="${pageSupport.totalCount}"/>--%>
				<%--<c:param name="totalPageCount" value="${pageSupport.totalPageCount}"/>--%>
				<%--<c:param name="currentPageNo" value="${pageSupport.currPageNo}"/>--%>
  			<%--</c:import> --%>
  		  	<%--</td>--%>
  		  <%--</tr>--%>
	    </table>

		<div class='page'>

			<%--显示下一页，上一页	--%>

		</div>

       </div>
      </div>