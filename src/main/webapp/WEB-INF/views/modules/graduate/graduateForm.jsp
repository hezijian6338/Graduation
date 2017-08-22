<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>毕业生信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});

		/*
		ajax根据学院id查询出专业
		 */
		function findMajor(){
		    //获取学院的id
			var orgId = $("#orgId").val();
			$.ajax({
				async:true,
				cache:false,
                type: "POST",
                url: "${ctx}/major/major/findMajor",
                data: { //发送给数据库的数据
                    id:orgId
                },
                dataType: 'json',
				success:function(data){

                    $("#majorSelect").empty();
                    //$("#majorSelect").append($("<option selected=selected>请选择专业</option>"));
					//var option1 = $("<option></option>").append("请选择专业").attr("selected","selected");
					//option1.appendTo($("#majorSelect"));

					$.each(data.majors,function (index,item) {

						//alert(item.orgName);

						/*$("#majorSelect").append("<option valu>");*/


                        var optionEle = $("<option></option>").append(item.orgName).attr("value",item.orgName);

                        optionEle.appendTo($("#majorSelect"));
                    });
                    //$("#majorSelect").val(data.majors[0].orgName);
                }
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/graduate/graduate/">毕业生信息列表</a></li>
		<li class="active"><a href="${ctx}/graduate/graduate/form?id=${graduate.id}">毕业生信息<shiro:hasPermission name="graduate:graduate:edit">${not empty graduate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="graduate:graduate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<%--@elvariable id="graduate" type=""--%>
	<form:form id="inputForm" modelAttribute="graduate" action="${ctx}/graduate/graduate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">姓名：</label>
						<div class="controls">
							<form:input path="stuName" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">入学日期：</label>
						<div class="controls">
							<input name="acceptanceDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${graduate.acceptanceDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">学号：</label>
						<div class="controls">
							<form:input path="stuNo" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">毕业日期：</label>
						<div class="controls">
							<input name="graduationDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${graduate.graduationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">

							<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">毕结业结论：</label>
						<div class="controls">
							<form:input path="graConclusion" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="birthday" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${graduate.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">毕业证书编号：</label>
						<div class="controls">
							<form:input path="graCertificateNo" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
							<form:input path="idcardNo" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">学位证书编号：</label>
						<div class="controls">
							<form:input path="degreeCertificateNo" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">院系名称：</label>
						<div class="controls">
							<form:input path="collegeName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">学士学位名称：</label>
						<div class="controls">
							<form:input path="degreeName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>


			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">院系代码：</label>
						<div class="controls">
							<form:input path="collegeId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">姓(英文)：</label>
						<div class="controls">
							<form:input path="lastNameEn" htmlEscape="false" maxlength="10" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">学院：</label>
						<div class="controls">
							<form:select path="orgId" onchange="findMajor();" style="width:150px;">
								<form:options items="${institutes}" itemLabel="instituteName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">名(英文)：</label>
						<div class="controls">
							<form:input path="firstNameEn" htmlEscape="false" maxlength="10" class="input-xlarge "/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">专业名称：</label>
						<div class="controls">
								<%--<form:input path="majorName" htmlEscape="false" maxlength="64" class="input-xlarge "/>--%>
								<%--<form:select path="majorName" id="major">

                                </form:select>--%>
							<select id="majorSelect" name="majorName" style="width:150px;">
								<c:forEach var="major" items="${majors}">
									<option value="${major.majorName}">${major.majorName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">性别(英文)：</label>
						<div class="controls">
							<form:input path="sexEn" htmlEscape="false" maxlength="10" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">专业代码：</label>
						<div class="controls">
							<form:input path="major" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">生日(英文)：</label>
						<div class="controls">
							<form:input path="birthdayEn" htmlEscape="false" maxlength="20" class="input-xlarge "/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">学习形式：</label>
						<div class="controls">
							<form:input path="learningForm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">专业名称(英文)：</label>
						<div class="controls">
							<form:input path="majorNameEn" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td><div class="control-group">
					<label class="control-label">层次：</label>
					<div class="controls">
						<form:input path="arrangement" htmlEscape="false" maxlength="64" class="input-xlarge "/>
					</div>
				</div>
				</td>

				<td>
					<div class="control-group">
						<label class="control-label">学士学位(英文)：</label>
						<div class="controls">
							<form:input path="degreeNameEn" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>


			</tr>
			<tr>
				<td></td>
				<td ROWSPAN="3">
					<div class="control-group">
						<label class="control-label">备注：</label>
						<div class="controls">
							<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
						</div>
					</div>
				</td>

			</tr>

			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">学制：</label>
						<div class="controls">
							<form:input path="eduSystem" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
				<div class="control-group">
					<label class="control-label">届别：</label>
					<div class="controls">
						<form:input path="session" htmlEscape="false" maxlength="32" class="input-xlarge "/>
					</div>
				</div>
			</td>
			</tr>

		</table>

		<div class="form-actions">
			<shiro:hasPermission name="graduate:graduate:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>