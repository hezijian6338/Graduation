<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>毕业生信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/graduate/graduate/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
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

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
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
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/graduate/graduate/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/graduate/graduate/import/template">下载模板</a>
		</form>
	</div>
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
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
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
				<td>
					<input type="checkbox" name="ids" value="${graduate.id}">
				</td>
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
	<a href="javascript:batchDelete();" onclick="return confirmx('确认要删除该毕业生信息吗？', this.href)">批量删除</a>
	<div class="pagination">${page}</div>
</body>
</html>