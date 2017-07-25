<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>毕业生信息管理</title>
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
		<li class="active"><a href="${ctx}/graduate/graduate/">毕业生信息列表</a></li>
		<shiro:hasPermission name="graduate:graduate:edit"><li><a href="${ctx}/graduate/graduate/form">毕业生信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="graduate" action="${ctx}/graduate/graduate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学号：</label>
				<form:input path="stuNo" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>姓名：</label>
				<form:input path="stuName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>学院名称</th>
				<th>专业名称</th>
				<th>毕结业结论</th>
				<th>届别</th>
				<th>学士学位名称</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="graduate:graduate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="graduate">
			<tr>
				<td><a href="${ctx}/graduate/graduate/form?id=${graduate.id}">
					${graduate.stuNo}
				</a></td>
				<td>
					${graduate.stuName}
				</td>
				<td>
					${fns:getDictLabel(graduate.sex, 'sex', '')}
				</td>
				<td>
					<fmt:formatDate value="${graduate.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${graduate.orgName}
				</td>
				<td>
					${graduate.majorName}
				</td>
				<td>
					${graduate.graConclusion}
				</td>
				<td>
					${graduate.session}
				</td>
				<td>
					${graduate.degreeName}
				</td>
				<td>
					<fmt:formatDate value="${graduate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${graduate.remarks}
				</td>
				<shiro:hasPermission name="graduate:graduate:edit"><td>
				<a href="${ctx}/graduate/graduate/detail?id=${graduate.id}">详情</a>
    				<a href="${ctx}/graduate/graduate/form?id=${graduate.id}">修改</a>
					<a href="${ctx}/graduate/graduate/delete?id=${graduate.id}" onclick="return confirmx('确认要删除该毕业生信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>