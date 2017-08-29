<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>查看模板</title>
  </head>
  <body>
  	<div>
  		<input id="returnPrintf" type="button" value="返回" onclick="backtoPrintf()" />
  	</div>
				<% 
					//String realpath = request.getRealPath("/Model");
					//System.out.println(realpath);					//成功显示服务器当前的路径
					File d=new File("F:"+"//"+"Model");							//建立当前目录中文件的File对象
					/*许彩开
					* */
					if(!d.exists()){
					    d.mkdirs();
					}

					File list[]=d.listFiles();							//取得当前文件中所有的文件的file对象数组
					for(int i = 0 ; i < list.length ; i++){			
						String filename = list[i].getName();
						int end = filename.lastIndexOf(".");
						String realName = filename.substring(0,end);
						String styleName = filename.substring(end+1,filename.length());
						String imgPath = "./Model/" + realName + "." + styleName;
						System.out.println(realName + "." + styleName);		//成功显示当前文件夹的文件名字
						if(styleName.equals("png")){
							out.println("<center>");
							out.println("<img src="+ imgPath +">");
							out.println("<div class='components othersElement' id=" + realName + ">" + "<h1>" + realName + "</h1>" + "</div>");
							out.println("</center>");
						}
					}
				%>
	 <script>
	 
	 function backtoPrintf(){
	 	//window.open("index.jsp","_self");
         location = "${ctx}/graduate/graduate/startMaking";
	 }
	 
	 </script>
  </body>
</html>