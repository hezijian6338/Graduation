<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/28
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: S400
  Date: 2017/8/14
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>个人证书信息</title>
    <meta name="decorator" content="default"/>
    <script src='static/jquery/jquery-1.8.3.js'></script>
    <script type="text/javascript">
        $(function () {
            $("#btn").trigger("click");
        });
    </script>
    <script type="text/javascript" src="static/pdf/jquery.media.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<c:choose>
    <c:when test="${message==null}">
        <a class="media" href="${fns:getStudent().graCertificate}"><button id="btn" type="button"></button></a>
    </c:when>
    <c:otherwise>
        <sys:message content="${message}" type="warning"/>
    </c:otherwise>
</c:choose>

</body>
</html>

