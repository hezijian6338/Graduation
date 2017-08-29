<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017\8\29 0029
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>模板制作</title>

</head>
<body>
<form:form id="searchForm" action="${ctx}/graduate/graduate/" method="post" class="breadcrumb form-search">
    <a href="${ctx}/graduate/graduate/startMaking" target="_blank">开始制作</a>
</form:form>
</body>
</html>
