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
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            //许彩开   模板制作跳转
            $("#startMaking").click(function(){
                $("#searchForm").attr("action","${ctx}/graduate/graduate/startMaking");
                $("#searchForm").attr("target","_blank");
                $("#searchForm").submit();
            });
        });
    </script>
</head>
<body>
<form:form id="searchForm" action="${ctx}/graduate/graduate/" method="post" class="breadcrumb form-search">
    <%--<a href="${ctx}/graduate/graduate/startMaking" target="_blank">开始制作</a>--%>
    <input id="startMaking" class="btn btn-primary" type="button" value="制作模板"/>
</form:form>
</body>
</html>
