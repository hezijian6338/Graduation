<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
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
  	<%
		String realpath ="E:"+"//"+"Model";
		System.out.println(realpath);					//成功显示服务器当前的路径
		File d=new File(realpath);							//建立当前目录中文件的File对象

		if(!d.exists()){
			d.mkdirs();
		}

		File list[]=d.listFiles();							//取得当前文件中所有的文件的file对象数组
		for(int i = 0 ; i < list.length ; i++){			
			String filename = list[i].getName();
			int end = filename.lastIndexOf(".");
			String realName = filename.substring(0,end);
			String styleName = filename.substring(end+1,filename.length());

			if(styleName.equals("txt")){
				byte buf[]=new byte[1000000];
				File file = new File(realpath,realName + "." + styleName);
				FileInputStream fistream=new FileInputStream(file);
				int bytesum=fistream.read(buf,0,1000000);
				String str_file=new String(buf,0,bytesum);
				//System.out.print(str_file);
				fistream.close();
				//System.out.println(realName + "." + styleName);		//成功显示当前文件夹的文件名字
				File Htmlfile = new File(realpath,realName + ".html");
				FileReader fr = new FileReader(Htmlfile); 
				BufferedReader br = new BufferedReader(fr);
				String content = br.readLine();							//保存画布html格式获取
				String str = content ;
				while(str!=null){
					str = br.readLine();
					content = content + str ;
				}	
				System.out.print(content);
				fr.close();
				
				request.setAttribute(realName,content);
				out.println("<center>");
				out.println("<img src="+ str_file +" onclick='insertThePrintf("+ realName +")' >");
				out.println("<div onclick='insertThePrintf("+ realName +")' class='components othersElement' id=" + realName + ">" + "<h1>" + realName + "</h1>" + "</div>");
				out.println("</center>");
			}
		}
	%>
  	<script>
  		function insertThePrintf(realName){
			//alert(content);
			window.location.href="index.jsp?printfContent=" + realName; 
  		}
  	</script>
  </body>
</html>