<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.jspsmart.upload.*" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>消息提示</title>
  </head>
  <body onLoad="TimeClose();">

  	<%
  		request.setCharacterEncoding("GBK");
  	%>
	<%
		SmartUpload smart = new SmartUpload();
		smart.setCharset("UTF-8");
		pageContext.setAttribute("image",request.getAttribute("image"));
		smart.initialize(pageContext);
		smart.upload();
		String imageId = smart.getRequest().getParameter("id");
		String ext = smart.getFiles().getFile(0).getFileExt();
		String fileName = imageId + "." + ext ;
		smart.getFiles().getFile(0).saveAs("E:"+"//"+"upload"+java.io.File.separator+fileName);
	 %>
	 <center>
		 <img src="./upload/<%=fileName%>">
		 <h1><%=imageId%></h1>
		 <h1>上传成功！返回页面！</h1>
		 <div id="ShowTime">倒计时10秒后关闭当前窗口</div>
	 </center>
	   	<script>
	     var cTime=5 ;//这个变量是倒计时的秒数设置为5就是5秒
	     function TimeClose(){
				window.setTimeout('TimeClose()',1000);//让程序每秒重复执行当前函数。
	            if(cTime<=0)//判断秒数如果为0
	            {
	            	CloseWindow_Click();//执行关闭网页的操作
	            }
	            this.ShowTime.innerHTML="倒计时"+cTime+"秒后关闭当前窗口";//显示倒计时时间
	            cTime--;//减少秒数
	     }
	    function CloseWindow_Click(){
	        	window.close();
	    }
	 </script>
  </body>
</html>