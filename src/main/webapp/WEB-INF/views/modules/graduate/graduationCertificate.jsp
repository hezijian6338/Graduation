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
    <script type="text/javascript" src="static/pdf/jquery.media.js"></script>
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
        $(function() {
            $('a.media').media();
        });
    </script>
    <%--${fns:getStudent().stuName}--%>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a class="media" href="${fns:getStudent().graCertificate}"> 我的毕业证书</a></li>
    <li><a href="${ctx}/graduate/graduate/degreeCertificate ">我的学位证书</a></li>
</ul><br/>
</body>
</html>
