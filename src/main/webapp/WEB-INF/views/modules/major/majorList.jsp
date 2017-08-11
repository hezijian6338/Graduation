<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业信息管理</title>
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
		<li class="active"><a href="${ctx}/major/major/">专业信息列表</a></li>
		<shiro:hasPermission name="major:major:edit"><li><a href="${ctx}/major/major/form">专业信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="major" action="${ctx}/major/major/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>专业代码：</label>
				<form:input path="majorNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>专业名称：</label>
				<form:input path="majorName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>专业代码</th>
				<th>专业名称</th>
				<th>所属学院</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="major:major:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="major">
			<tr>
				<td><a href="${ctx}/major/major/form?id=${major.id}">
					${major.majorNo}
				</a></td>
				<td>
					${major.majorName}
				</td>
				<td>
					${major.orgName}
				</td>
				<td>
					<fmt:formatDate value="${major.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${major.remarks}
				</td>
				<shiro:hasPermission name="major:major:edit"><td>
    				<a href="${ctx}/major/major/form?id=${major.id}">修改</a>
					<a href="${ctx}/major/major/delete?id=${major.id}" onclick="return confirmx('确认要删除该专业信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>