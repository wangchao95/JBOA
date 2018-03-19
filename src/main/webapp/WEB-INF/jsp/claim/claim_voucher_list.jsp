<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonCalim.js"></script>
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
	<div class="t">报销单列表</div>
	<div class="pages">
		<div class="forms">
				 <form action="" id="queryForm" name="queryForm">
					 <div style="margin-bottom: 10px">
						 <P style="float: left;margin-left: 10px">报销单状态</P>
						 <input type="hidden" value="${sessionScope.employee.name}" id="employeeId"/>
						 <input type="hidden" value="${sessionScope.employee.sys_position.nameCn}" id="positionName"/>
						 <input type="hidden" value="" id="claimId"/>
						 <select style="float: left;margin-left: 10px" name="biz_claim.status">
						 <option value="全部">全部</option>
						 <option value="新创建">新创建</option>
						 <option value="已打回">已打回</option>
						 <option value="已提交">已提交</option>
						 <option value="已付款">已付款</option>
						 <option value="待审批">待审批</option>
						 <option value="已审批">已审批</option>
						 </select>
						 <p style="float: left;margin-left: 10px">开始时间</p>
						 <P style="float: left;margin-left: 10px"><s:textfield name="biz_claim.beginTime" id="startDate" cssClass="nwinput"></s:textfield></P>
						 <p style="float: left;margin-left: 10px">结束时间</p>
						 <P style="float: left;margin-left: 10px"><s:textfield name="biz_claim.endTime" id="endDate" cssClass="nwinput"></s:textfield></P>
						 <P style="float: left;margin-left: 10px;margin-bottom: 15px"><input type="button" id="search" class="submit_01" value="查   询"/></P>
					 </div>
				 </form>

	     </div>

	<!--增加报销单 区域 开始-->
	<s:form action="" name="claimVoucherForm">
		<table width="90%" border="0" cellspacing="0" cellpadding="0" id="tableInfo" class="list items">
	      <tr class="even">
	        <td>编号</td>
	        <td>填报日期</td>
	        <td>填报人</td>
	        <td>总金额</td>
	        <td>状态</td>
	        <td>待处理人</td>
	        <td>操作</td>
	      </tr>

			<tr class="content">
				<%--内容--%>

			</tr>

	    </table>
	   </s:form>


		<div class='page'>

			<%--显示下一页，上一页	--%>

		</div>

       </div>
      </div>