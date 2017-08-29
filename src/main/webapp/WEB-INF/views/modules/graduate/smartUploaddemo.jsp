<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.jspsmart.upload.*" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>消息提示</title>
  </head>
  <body>
  	<% 
  		request.setCharacterEncoding("GBK");
  	%>
	<%
	
		SmartUpload smart = new SmartUpload();
		smart.setCharset("UTF-8");
		smart.initialize(pageContext);
		smart.upload();
		String imageId = smart.getRequest().getParameter("id");
		String ext = smart.getFiles().getFile(0).getFileExt();
		String fileName = imageId + "." + ext ;
		System.out.print(this.getServletContext().getRealPath("/"));
		application.setAttribute("path",this.getServletContext().getRealPath("/")+"upload");
		smart.getFiles().getFile(0).saveAs(this.getServletContext().getRealPath("/")+"upload"+java.io.File.separator+fileName);

	 %>
  </body>
</html>