<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/28
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>个人证书信息</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="static/pdf/jquery.media.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnDownload").click(function(){
                <%--var stuNo =${fns:getStudent().stuNo};--%>
                location = "${ctx}/graduate/graduate/degreeCertificate/download?";
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/graduate/graduate/graduationCertificate ">我的毕业证书</a></li>
    <li class="active"><a href="${ctx}/graduate/graduate/degreeCertificate ">我的学位证书</a></li>
</ul><br/>
<input id="btnDownload" class="btn btn-primary" type="button" value="下载"/><br/><br/>
<img src="F:\graduation\graduation\Graduation\pic\140202011026.jpg" style="width: 700px;height: 600px">
</body>
</html>