<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学院信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/institute/institute/">学院信息列表</a></li>
		<shiro:hasPermission name="institute:institute:edit"><li><a href="${ctx}/institute/institute/form">学院信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="institute" action="${ctx}/institute/institute/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学院名称：</label>
				<form:input path="instituteName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学院编号</th>
				<th>学院名称</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="institute:institute:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="institute">
			<tr>
				<td><a href="${ctx}/institute/institute/form?id=${institute.id}">
					${institute.instituteNo}
				</a></td>
				<td>
					${institute.instituteName}
				</td>
				<td>
					<fmt:formatDate value="${institute.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${institute.remarks}
				</td>
				<shiro:hasPermission name="institute:institute:edit"><td>
    				<a href="${ctx}/institute/institute/form?id=${institute.id}">修改</a>
					<a href="${ctx}/institute/institute/delete?id=${institute.id}" onclick="return confirmx('确认要删除该学院信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>