<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="com.itextpdf.text.pdf.codec.Base64"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.jspsmart.upload.*" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>消息提示</title>
  </head>
  <body>
  	<% 
  		request.setCharacterEncoding("UTF-8");
  	%>
	<%
	
		SmartUpload smart = new SmartUpload();
		smart.setCharset("UTF-8");
		smart.initialize(pageContext);
		smart.upload();
		String printfTxt = smart.getRequest().getParameter("thePrintfTxt");
		String printfPng = smart.getRequest().getParameter("thePrintfPng");
		String printfId = smart.getRequest().getParameter("thePrintfID");
		System.out.print( printfPng );
		String path = "E:"+"//"+"Model" ;
		System.out.print(path);
		
		String filename = printfId + ".html" ;
		String filename1 = printfId + ".txt" ;

		File fp = new File(path,filename);
		File fp1 = new File(path,filename1);

		FileWriter fwriter = new FileWriter(fp);
		fwriter.write(printfTxt);
		
		FileWriter fwriter1 = new FileWriter(fp1);
		fwriter1.write(printfPng);

		fwriter.close();
		fwriter1.close();

		//application.setAttribute("path",this.getServletContext().getRealPath("/")+"Model");
		//smart.getFiles().getFile(0).saveAs(this.getServletContext().getRealPath("/")+"Model"+java.io.File.separator+printfId);

	 %>
	 <center>
		 <image src="<%=printfPng%>">
		 <h1><%=printfId%></h1>
		 <h1>上传成功！返回页面！</h1>
	 </center>
	</body>
</html>