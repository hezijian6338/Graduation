<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<title>毕业生信息管理</title>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
<<<<<<< HEAD

		function getDetailId(param, s) {
            getDetail(s);
            $("#btn_detail_modal").modal({
        });
    }

    	$(document).ready(function() {

		});

		function getDetail(id1) {
			$.ajax({
				url:"${ctx}/graduate/graduate/detail/"+id1,
                type:"GET",
                success:function(result){
				    console.log(result);
					var detailData=result.extend.detail;
                    document.getElementById("stuName1").innerText=detailData.stuName;
                    document.getElementById("stuNo1").innerText=detailData.stuNo;
                    document.getElementById("sex1").innerText=detailData.sex==1?"男":"女";

                    document.getElementById("birthday1").innerText=detailData.birthday==undefined?"":detailData.birthday;
                    document.getElementById("idcardNo1").innerText=detailData.idcardNo==undefined?"":detailData.idcardNo;
                    document.getElementById("collegeId1").innerText=detailData.collegeId==undefined?"":detailData.collegeId;

                    document.getElementById("collegeName1").innerText=detailData.collegeName==undefined?"":detailData.collegeName;
                    document.getElementById("major1").innerText=detailData.major==undefined?"":detailData.major;
                    document.getElementById("majorName1").innerText=detailData.majorName==undefined?"":detailData.majorName;

                    document.getElementById("learningForm1").innerText=detailData.learningForm==undefined?"":detailData.learningForm;
                    document.getElementById("eduSystem1").innerText=detailData.eduSystem==undefined?"":detailData.eduSystem;
                    document.getElementById("acceptanceDate1").innerText=detailData.acceptanceDate==undefined?"":detailData.acceptanceDate;

                    document.getElementById("graduationDate1").innerText=detailData.graduationDate==undefined?"":detailData.graduationDate;
                    document.getElementById("arrangement1").innerText=detailData.arrangement==undefined?"":detailData.arrangement;
                    document.getElementById("graConclusion1").innerText=detailData.graConclusion==undefined?"":detailData.graConclusion;

                    document.getElementById("graCertificateNo1").innerText=detailData.graCertificateNo==undefined?"":detailData.graCertificateNo;
                    document.getElementById("degreeCertificateNo1").innerText=detailData.degreeCertificateNo==undefined?"":detailData.degreeCertificateNo;
                    document.getElementById("session1").innerText=detailData.session==undefined?"":detailData.session;

                    document.getElementById("cet41").innerText=detailData.cet4==undefined?"":detailData.cet4;
                    document.getElementById("cet61").innerText=detailData.cet6==undefined?"":detailData.cet6;
                    document.getElementById("lastNameEn1").innerText=detailData.lastNameEn==undefined?"":detailData.lastNameEn;

                    document.getElementById("cet4CertificateNo1").innerText=detailData.cet4CertificateNo==undefined?"":detailData.cet4CertificateNo;
                    document.getElementById("cet6CertificateNo1").innerText=detailData.cet6CertificateNo==undefined?"":detailData.cet6CertificateNo;
                    document.getElementById("firstNameEn1").innerText=detailData.firstNameEn==undefined?"":detailData.firstNameEn;

                    document.getElementById("sexEn1").innerText=detailData.sexEn==undefined?"":detailData.sexEn;
                    document.getElementById("birthdayEn1").innerText=detailData.birthdayEn==undefined?"":detailData.birthdayEn;
                    document.getElementById("degreeName1").innerText=detailData.degreeName==undefined?"":detailData.degreeName;

                    document.getElementById("majorNameEn1").innerText=detailData.majorNameEn==undefined?"":detailData.majorNameEn;
                    document.getElementById("degreeNameEn1").innerText=detailData.degreeNameEn==undefined?"":detailData.degreeNameEn;
                    document.getElementById("remarks1").innerText=detailData.remarks==undefined?"":detailData.remarks;

				}
			});
        };

=======
		$(function(){
            /**
			 * 给全选添加click事件
             */
            $("#selectAll").click(function(){
                /*
                获取全选的状态
                 */
                var bool = $("#selectAll").attr("checked");
                /*
                让所有条目的复选框与全选的状态同步
                 */
                if (bool == "checked"){
                    setItemCheckBox(bool);
				}else{
                    setItemCheckBox(false);
				}


			});
            /**
             * 给所有的条目的复选框添加click事件
             */
            $(":checkbox[name=ids]").click(function(){
                var all = $(":checkbox[name=ids]").length;//所有信息条目的个数
                var select = $(":checkbox[name=ids][checked=checked]").length;//获取所有被选择条目的个数

                if(all==select){//全都选中了
                    $("#selectAll").attr("checked",true);//勾选全选复选框
                }else if(select==0){//一个都没有选
                    $("#selectAll").attr("checked",false);//取消全选
                }else{
                    $("#selectAll").attr("checked",false);//取消全选
                }
            });
		});

>>>>>>> 58eb931482f9515055d9d7de9576a2f439ad8e89
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
<<<<<<< HEAD
        };
=======
        }
        /**
         * 统一设置所有学生信息条目的复选按钮
         *
         */
		function setItemCheckBox(bool) {
			$(":checkbox[name=ids]").attr("checked",bool);
        }

        /**
		 * 批量删除
         */
        function batchDelete(){
            /*
            获取所有被勾选的条目的复选框,创建一数组把被选中的复选框的值加到数组中
             */
            var graduateIds = new Array();
            $(":checkbox[name=ids][checked=checked]").each(function(){
                graduateIds.push($(this).val());//把复选框的值加到数组中
			});
            if(graduateIds.length==0){
                alert("请选择要删除的学生！");
                return;
			}
            location = "${ctx}/graduate/graduate/batchDelete?ids="+graduateIds;
		}
>>>>>>> 58eb931482f9515055d9d7de9576a2f439ad8e89
	</script>
	<style type="text/css">
		.bg-primary {
			color: #fff;
			background-color: #337ab7;
		}
		a.bg-primary:hover,
		a.bg-primary:focus {
			background-color: #286090;
		}

		.bg-info {
			background-color: #d9edf7;
		}

		@media (min-width: 992px) {
			.modal-lg {
				width: 900px;
			}
		}
	</style>
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
				<th><input type="checkbox" id="selectAll"/>全选</th>
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
<<<<<<< HEAD

=======
				<td>
					<input type="checkbox" name="ids" value="${graduate.id}">
				</td>
>>>>>>> 58eb931482f9515055d9d7de9576a2f439ad8e89
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
				<%--href="${ctx}/graduate/graduate/detail?id=${graduate.id}"--%>
					<a id="btn_detail" data-toggle="modal" data-target="#myModal" onclick="getDetailId(this,'${graduate.id}')">详情</a>
    				<a href="${ctx}/graduate/graduate/form?id=${graduate.id}">修改</a>
					<a href="${ctx}/graduate/graduate/delete?id=${graduate.id}" onclick="return confirmx('确认要删除该毕业生信息吗？', this.href)">删除</a>
					</shiro:hasPermission>
					<span id="id" style="display: none" name="idName">${graduate.id}</span></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a href="javascript:batchDelete();" onclick="return confirmx('确认要删除该毕业生信息吗？', this.href)">批量删除</a>
	<div class="pagination">${page}</div>
	<!-- 学生基本信息详情模态框 -->
	<div class="modal fade bs-example-modal-lg" id="btn_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header bg-primary">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" style="color: #0d0d0d">学生基本信息详情</h4>
				</div>
				<div class="modal-body bg-info">
					<hr style="margin: 0"><br>
					&nbsp;<br>
					<table class="table bg-info">

						<tbody>

						<tr>
							<div class="col-md-4"><td>姓名：<span id="stuName1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>学号：<span id="stuNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>性别：<span id="sex1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"><td>出生日期：<span id="birthday1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>身份证号：<span id="idcardNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 院系代码：<span id="collegeId1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"><td>院系名称：<span id="collegeName1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>专业代码：<span id="major1">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 专业名称：<span id="majorName1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"> <td>学习形式：<span id="learningForm1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>学制：<span id="eduSystem1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>入学日期：<span id="acceptanceDate1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"> <td>毕业日期：<span id="graduationDate1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>层次：<span id="arrangement1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>毕结业结论：<span id="graConclusion1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"> <td>毕业证书编号：<span id="graCertificateNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>学位证书编号：<span id="degreeCertificateNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 届别：<span id="session1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"><td>四级成绩：<span id="cet41">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 六级成绩：<span id="cet61">&nbsp;</span></td></div>
							<div class="col-md-4"><td>姓(英文)：<span id="lastNameEn1">&nbsp;</span></td></div>
						</tr> <tr>
							<div class="col-md-4"> <td> 四级证书编号：<span id="cet4CertificateNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>六级证书编号：<span id="cet6CertificateNo1">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 名(英文)：<span id="firstNameEn1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"> <td> 性别(英文)：<span id="sexEn1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>出生日期(英文)：<span id="birthdayEn1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>学士学位名称：<span id="degreeName1">&nbsp;</span></td></div>
						</tr>
						<tr>
							<div class="col-md-4"> <td>专业名称(英文)：<span id="majorNameEn1">&nbsp;</span></td></div>
							<div class="col-md-4"><td>学士学位(英文)：<span id="degreeNameEn1">&nbsp;</span></td></div>
							<div class="col-md-4"><td> 备注： <span id="remarks1">&nbsp;</span></td></div>
						</tr>

						</tbody>


					</table>
				</div>

			</div>
		</div>
	</div>
</body>
</html>