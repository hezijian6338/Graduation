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
    <title>个人信息</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/graduate/graduate/info">个人详细信息</a></li>
    <li><a href="${ctx}/graduate/graduate/modifyPwd">修改密码</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="student" action="${ctx}/graduate/graduate/info" method="post" class="form-horizontal">
    <div class="row-fluid" style="margin: 50px; font-size: 6px; line-height: 40px;">
        <div class="row">

            <div class="span4">学习形式：<span id="learningForm">&nbsp;${student.learningForm}</span></div>
            <div class="span4">名(英文)：<span id="firstNameEn">&nbsp;${student.firstNameEn}</span></div>

        </div>
        <div class="row">
            <div class="span4">姓名：<span id="stuName">&nbsp;${student.stuName}</span></div>
            <div class="span4">层次：<span id="arrangement">&nbsp;${student.arrangement}</span></div>
            <div class="span4">性别(英文)：<span id="sexEn">&nbsp;${student.sexEn}</span></div>

        </div>
        <div class="row">

            <div class="span4">学号：<span id="stuNo">&nbsp;${student.stuNo}</span></div>
            <div class="span4">学制：<span id="eduSystem">&nbsp;${student.eduSystem}</span></div>
            <div class="span4">出生日期(英文)：<span id="birthdayEn">&nbsp;${student.birthdayEn}</span></div>

        </div>
        <div class="row">
            <div class="span4" >性别：<span id="sex">&nbsp;
                <c:choose>
                    <c:when test="${student.sex=='1'}">
                        <c:out value="男"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="女"/>
                    </c:otherwise>
                </c:choose>
            </span></div>
            <div class="span4">届别：<span id="session">&nbsp;${student.session}</span></div>
            <div class="span4">专业名称(英文)：<span id="majorNameEn">&nbsp;${student.majorNameEn}</span></div>

        </div>
        <div class="row">
            <div class="span4">出生日期：<span id="birthday">&nbsp;${student.birthday}</span></div>
            <div class="span4">入学日期：<span id="acceptanceDate">&nbsp;${student.acceptanceDate}</span></div>
            <div class="span4">学士学位(英文)：<span id="degreeNameEn">&nbsp;${student.degreeNameEn}</span></div>


        </div>
        <div class="row">
            <div class="span4">身份证号：<span id="idcardNo">&nbsp;${student.idcardNo}</span></div>
            <div class="span4">毕业日期：<span id="graduationDate">&nbsp;${student.graduationDate}</span></div>
            <div class="span4">备注： <span id="remarks">&nbsp;${student.remarks}</span></div>

        </div>
        <div class="row">
            <div class="span4">院系名称：<span id="collegeName">&nbsp;${student.collegeName}</span></div>
            <div class="span4">毕结业结论：<span id="graConclusion">&nbsp;${student.graConclusion}</span></div>


        </div>
        <div class="row">
            <div class="span4">院系代码：<span id="collegeId">&nbsp;${student.collegeId}</span></div>
            <div class="span4">毕业证书编号：<span id="graCertificateNo">${student.graCertificateNo}</span></div>


        </div>
        <div class="row">
            <div class="span4">学院：<span id="orgName">&nbsp;${student.orgName}</span></div>
            <div class="span4">学位证书编号：<span id="degreeCertificateNo">&nbsp;${student.degreeCertificateNo}</span></div>


        </div>
        <div class="row">
            <div class="span4">专业名称：<span id="majorName">&nbsp;${student.majorName}</span></div>
            <div class="span4">学士学位名称：<span id="degreeName">&nbsp;${student.degreeName}</span></div>




        </div>
        <div class="row">
            <div class="span4">专业代码：<span id="major">&nbsp;${student.major}</span></div>
            <div class="span4">姓(英文)：<span id="lastNameEn">&nbsp;${student.lastNameEn}</span></div>

        </div>


    </div>
</form:form>
</body>
</html>