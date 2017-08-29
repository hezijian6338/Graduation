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
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnDownload").click(function(){
                location = "${ctx}/graduate/graduate/graduationCertificate/download?";
//                myrefresh();
            });
        });
        function myrefresh()
        {
            window.location.reload();
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/graduate/graduate/graduationCertificate ">我的毕业证书</a></li>
    <li><a href="${ctx}/graduate/graduate/degreeCertificate ">我的学位证书</a></li>
</ul><br/>
<input id="btnDownload" class="btn btn-primary" type="button" value="下载"/><br/><br/>
<img src="F:\graduation\graduation\Graduation\pic\140202011026.jpg" style="width: 700px;height: 600px">
</body>
</html>

