<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title>Moudle Demo</title></head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">	

<script type="text/javascript" src="${ctxStatic}/js/html2canvas.js"></script>
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-v1.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-v1-ui.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/jquery-ui.css"/>
<!--图片相关的js代码-->
<script type="text/javascript" src="${ctxStatic}/js/images.js"></script>
<!--生成PDF的相关js代码-->
<script type="text/javascript" src="${ctxStatic}/js/jspdf.debug.js"></script>


<style>
	#trash { width: 1500px; height: 1000px; padding: 0.5em; float: right; margin: 10px; background-color: transparent; }
	#printf { position: relative; float:right; width: 1500px; height: 920px; border:1px solid #000;}
	#products { float:left; width: 400px;}
	.printComponents { /* position: relative; background: red; */z-index:3;width:500px;border:1px solid #000000;cursor:move;  } 
	.components{ cursor:pointer; }
	.hr{ size:20px;weight:100px;border:none;border-top:3px double white; }
	.horizontallineStyle{ position: relative;height:5px;width:200px;border-bottom: 2px solid #000000;cursor:move; }
	.verticallineStyle{ position:relative; height:200px;width:5px;border-right:10px solid #000000;cursor:move; }
	.textarea{ background:transparent;border:1px solid #000; }
	.FormAcount{ width:30px;height:20px; }
	.printfTitle{  float:right;background-color: transparent;margin-top:30px;width:1500px;}
</style>
<script>

	$(function() {
    $( "#catalog").accordion();
	$( ".components").draggable({
      appendTo: "body",
      helper: "clone"
    });
	
    $("#printf").droppable({
		activeClass: "ui-state-default",
		hoverClass: "ui-state-hover",
		accept: ".components",
		drop: function( event, ui ) {
		
			<!--第一个拖拉组件文本框的生成-->
			
			if(ui.helper.attr("id") == "Text" ){
			
				var el = $("<div class='printComponents textComponents' onclick='checkClick(this)'  tabindex='0' onmousedown='setIndex(event,this)' ></div>");
				el.append("<textarea class='textarea' style='width:490px;resize:none;list-style:none;' onchange='wirteText(this)'></textarea>");
				var id = (new Date()).getMilliseconds();
				el.attr("id", "new" + id);
				el.draggable({
					containment:"#printf"
				}).resizable({
					stop:function(e,ui){
					    var hereDrag = this;
                        var width = parseInt($(hereDrag).css("width"));
                        var height = parseInt($(hereDrag).css("height"));           	                                                        	
                        $(hereDrag).find('textarea').css('width', width-10);                      	
                        $(hereDrag).find('textarea').css('height', height-10);
					},
					containment:"#printf"
				}).appendTo("#printf");	
			
			}else if(ui.helper.attr("id") == "radiobutton"){	
			
				<!--第二个拖拉组件单选按钮的生成-->
				
				var RadiostyleChoice = document.getElementById("RadiostyleChoice").value;
				var radioAcount = document.getElementById("radioAcount").value;			
				var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
				var id = (new Date()).getMilliseconds();
				el.attr("id", "new" + id);
				var radio = Math.random();
				
				//当用户没有输入按钮数量的时候 默认生成一个按钮
				if(radioAcount == null || radioAcount == 0){
					function prom(){
						var content = prompt("请输入你按钮的内容","");
						return content ;
					}
					var content = prom();
					el.append("<input type='radio' class='input' id='"+content+"' name='"+radio+"'><label for='"+content+"'>"+content+"</label>");
					el.resizable({
						stop:function(e,ui){
							var hereDrag = this;
							var width = parseInt($(hereDrag).css("width"));
							var height = parseInt($(hereDrag).css("height"));					
	                        $(hereDrag).find('input').css('width',width/2);                                         	
	                        $(hereDrag).find('input').css('height',height/2);					
						},
						containment:"#printf"	
					}).draggable({
						containment:"#printf",
						cancel:"#input"
					}).appendTo("#printf");
					
				}else{
				
					//当用户输入了所需要的单选按钮数量的时候 生成相对应的单选按钮数量
					for(var i = 0 ; i < radioAcount ; i++){
						function prom(){
							var content = prompt("请输入你按钮的内容","");
							return content ;
						}
						var content = prom();
						el.append("<input type='radio' class='input' id='"+content+"' name='"+radio+"'><label for='"+content+"'>"+content+"</label>");
						el.resizable({
							stop:function(e,ui){
								var hereDrag = this;
								var width = parseInt($(hereDrag).css("width"));
								var height = parseInt($(hereDrag).css("height"));
								if(RadiostyleChoice== 1){
	                        		$(hereDrag).find('input').css('width',width/2);                                         	
	                        		$(hereDrag).find('input').css('height',height/(radioAcount*2));
								}else{
	                        		$(hereDrag).find('input').css('width',width/radioAcount*2);                                         	
	                        		$(hereDrag).find('input').css('height',height/2);
								}						
							},	
							containment:"#printf"
						}).draggable({
							containment:"#printf",
							cancel:"#input"
						}).appendTo("#printf");
						if(RadiostyleChoice == 1){
							el.append("<br />");
						}
					}
				}

			}else if(ui.helper.attr("id") == "check box"){					
			
				<!--第三个拖拉组件 多选按钮的生成-->
				
				var CheckBoxstyleChoice = document.getElementById("CheckBoxstyleChoice").value;
				var checkAcount = document.getElementById("checkAcount").value;
				var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
				var id = (new Date()).getMilliseconds();
				el.attr("id", "new" + id);
				
				//当用户没有输入如何数组的时候 默认生成一个多选按钮
				if(checkAcount == null || checkAcount == 0){
					function prom(){
						var content = prompt("请输入你按钮的内容","");
						return content ;
					}
					var content = prom();
					el.append("<input type='checkbox' class='input' id='"+content+"'><label for='"+content+"'>"+content+"</label>");
					el.resizable({
						stop:function(){
							var hereDrag = this;
							var width = parseInt($(hereDrag).css("width"));
							var height = parseInt($(hereDrag).css("height"));
	                       	$(hereDrag).find('input').css('width',width/2);                                         	
	                       	$(hereDrag).find('input').css('height',height/2);					
						},
						containment:"#printf"
					}).draggable({
						containment:"#printf",
						cancel:"#input"
					}).appendTo("#printf");
					
				}else{
				
					//生成用户输入所需要的多选按钮数量
					for(var i = 0 ; i < checkAcount ; i++){
						function prom(){
							var content = prompt("请输入你按钮的内容","");
							return content ;
						}
						var content = prom();
						el.append("<input type='checkbox' class='input' id='"+content+"'><label for='"+content+"'>"+content+"</label>");
						el.resizable({
							stop:function(){
								var hereDrag = this;
								var width = parseInt($(hereDrag).css("width"));
								var height = parseInt($(hereDrag).css("height"));
								if(CheckBoxstyleChoice == 1){
	                    			$(hereDrag).find('input').css('width',width/2);                 	                               
	                        		$(hereDrag).find('input').css('height',height/(2*checkAcount));                                         	
								}else{
	                        		$(hereDrag).find('input').css('width',width/(checkAcount*2));                                         	
	                        		$(hereDrag).find('input').css('height',height/2);
								}						
							},
							containment:"#printf"	
						}).draggable({
							containment:"#printf",
							cancel:"#input"
						}).appendTo("#printf");
						if(CheckBoxstyleChoice == 1){
							el.append("<br />");
						}
					}
				}
				
			}else if(ui.helper.attr("id") == "line"){
			
				<!--第四个拖拉组件的生成 直线 有横竖供用户选择-->
				
				var lineStylechoice = document.getElementById("lineStylechoice").value;
				if(lineStylechoice == 1){
					var el = $("<div class='verticallineStyle' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
					var id = (new Date()).getMilliseconds();
					el.attr("id","new" + id);
					el.resizable({
						containment:"#printf",
						maxWidth:5
					}).draggable({
						containment:"#printf"
					}).appendTo("#printf");
				}else{
					var el = $("<div class='horizontallineStyle' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>" );
					var id = (new Date()).getMilliseconds();
					el.attr("id", "new" + id);
					el.resizable({
						containment:"#printf",
						maxHeight:5
					}).draggable({
						containment:"#printf"
					}).appendTo("#printf");	
				}
				
			}else if(ui.helper.hasClass("Elements")){
			
					<!--第五个组件 生成只能拖拉一次的关键拖拉组件 供以后可以用java代码寻找到相应的位置 输入相关内容-->
			
					//alert("id" + ui.helper.attr("id"));
					if(document.getElementById("id" + ui.helper.attr("id"))){
						alert("此组件只能拖拉一次！");
					}else{
						var el = $("<div class='printComponents specialElements' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)' style='border:1px solid #000000;'></div>");
						var id = "id" + ui.helper.attr("id");
						el.attr("id", id);
						el.attr("name", id);
						el.text("ID:" + id);
						el.resizable({
							containment:"#printf"
						}).draggable({
							containment:"#printf"
						}).appendTo("#printf");
					}

		
			}else if(ui.helper.attr("id") == "Form"){
			
				<!--第六个组件 表格的生成-->
			
				var lineAcount = document.getElementById("FormLineAcount").value;
				var columnAcount = document.getElementById("FormColumnAcount").value;
				if(lineAcount == 0 || lineAcount == null){ lineAcount = 1 ;}
				if(columnAcount == 0 || columnAcount == null){ columnAcount = 1 ;}
				//alert(lineAcount +" "+ columnAcount);			//确认是否能取得值
				var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
				var id = "id" + ui.helper.attr("id");
				el.attr("id",id);
				for(var x = 0 ; x < lineAcount ; x++){
					for(var y = 0 ; y < columnAcount ; y++){
						el.append("<textarea class='textarea' style='resize: none;' ></textarea>");
					}
				el.append("<br />");
				}
				el.resizable({
					stop:function(e,ui){
						var hereDrag = this;
						var width = parseInt($(hereDrag).css('width'));
						var height = parseInt($(hereDrag).css('height'));
						$(hereDrag).find('textarea').css('width', width/columnAcount-10);
						$(hereDrag).find('textarea').css('height',height/lineAcount-10);		
					},
					containment:"#printf"
				}).draggable({
					containment:"#printf"
				}).appendTo("#printf");
			
			}else if(ui.helper.hasClass("othersElement")){
				
				<!--第七个组件的生成 图片的拖拉-->
				
				var fileName = "./upload/" + ui.helper.attr("id") +".png";
				//alert(fileName);
				var el = $( "<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>" );
				el.append("<img src="+fileName+" class='img' style='width:500px'>");
				var id = (new Date()).getMilliseconds();
				el.attr("id", "new" + id);
				el.resizable({
					stop:function(){
						var hereDrag = this;
						var width = parseInt($(hereDrag).css('width'));
						var height = parseInt($(hereDrag).css('height'));
						$(hereDrag).find('img').css('width', width);
						$(hereDrag).find('img').css('height',height);
					},
					containment:"#printf"
				}).draggable({
					containment:"#printf"
				}).appendTo("#printf");
				
			}else{
				
				<!--第八个组件的生成 一些其他组件的生成-->
				
				var el = $( "<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>" );
				var id = (new Date()).getMilliseconds();
				el.attr("id", "new" + id);
				el.text("ID=new" + id);
				el.draggable({
					containment:"#printf"
				}).resizable({
					containment:"#printf"
				}).appendTo("#printf");
				
			}
		}
    });
  });
  

</script>
<body>
	<div id="products">
	  <h1 class="ui-widget-header">组件</h1>
	  <div id="catalog"> 
		<h2><a href="#">Base Elements</a></h2>
		<div>
		  <ul>
			<div class="components" id="Text">Text</div>
			<div class="components" id="Form">Form</div>
			<div draggable="false">
				<small>Line</small><input class="FormAcount" id="FormLineAcount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				<small>Column</small><input class="FormAcount" id="FormColumnAcount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"> 
			</div>
			<div class="components" id="line">line</div>
			<select id="lineStylechoice">
				<option>horizontal</option>
				<option value="1">vertical</option>
			</select>
		  </ul>
		</div>
		<h2><a href="#">Elements</a></h2>
		<div>
		  <ul>
		  	<div class="components Elements" id="Photo">Photo</div>
			<div class="components Elements" id="Name">Name</div>
			<div class="components Elements" id="EngFamilyName">EngFamilyName</div>
			<div class="components Elements" id="EngName">EngName</div>
			<div class="components Elements" id="Sex">Sex</div>
			<div class="components Elements" id="EngSex">EngSex</div>
			<div class="components Elements" id="GraYear">GraYear</div>
			<div class="components Elements" id="GraMonth">GraMonth</div>
			<div class="components Elements" id="StuYear">StuYear</div>
			<div class="components Elements" id="StuMonth">StuMonth</div>
			<div class="components Elements" id="BirthYear">BirthYearYear</div>
			<div class="components Elements" id="BirthMonth">BirthMonth</div>
			<div class="components Elements" id="BirthDay">BirthDay</div>
			<div class="components Elements" id="MakeYear">MakeYear</div>
			<div class="components Elements" id="MakeMonth">MakeMonth</div>
			<div class="components Elements" id="MakeDay">MakeDay</div>
			<div class="components Elements" id="EngBirthYear">EngBirthYear</div>
			<div class="components Elements" id="EngBirthDay">EngBirthDay</div>
			<div class="components Elements" id="Major">Major</div>
			<div class="components Elements" id="EngMajor">EngMajor</div>
			
		  </ul>
		</div>
		<h2><a href="#">Select</a></h2>
		<div>
		  <ul>
			<div class="components" id="radiobutton"> radio button </div>
			<select id="RadiostyleChoice">
				<option>horizontal</option>
				<option value="1">vertical</option>
			</select>
			<input id="radioAcount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"> 
			
			<div class="components" id="check box"> check box </div>
			<select id="CheckBoxstyleChoice">
				<option>horizontal</option>
				<option value="1">vertical</option>
			</select>
			<input id="checkAcount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
			
			<div class="components" id="singleButton">singleButton</div>
		  </ul>
		</div>
		<h2><a href="#">Others</a></h2>								<!-- 其他组件的插入位置 -->
		<div>
			<ul id="othersElements">
				<!--  获取原来在服务器上面的图片 -->
				<% 
				//	String realpath = request.getRealPath("/upload");
					//System.out.println(realpath);		//成功显示服务器当前的路径
					File d=new File("F:"+"//"+"upload");				//建立当前目录中文件的File对象

					/*
					*	许彩开
					* */
					if(!d.exists()){
					    d.mkdirs();
					}


					File list[]=d.listFiles();				//取得当前文件中所有的文件的file对象数组
					for(int i = 0 ; i < list.length ; i++){			
						String filename = list[i].getName();
						int end = filename.lastIndexOf(".");
						String realName = filename.substring(0,end);
						//System.out.println(realName);		//成功显示当前文件夹的文件名字
						out.println("<div class='components othersElement' id=" + realName + ">" + realName + "</div>");
					}
				%>
			</ul>
		</div>
	  </div>
	</div>
		
		<!-- 设置画布大小 -->
		<div style="width:460px;height:30px;float:right;" >
			<form>
				  设置画布大小
				宽<input id="printfWidth"  size="10" placeholder="width" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
				高<input id="printfHeight" size="10" placeholder="height" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
				<input id="submitPrintf" type="button" value="确认画布大小" onclick="setPrintfSize()" />
			</form>			
		</div>
		
		<!--背景颜色设置透明-->
		<div style="float:right;" >
			<form>
				  设置背景颜色 设置透明
				<select id="backgroundTransparent"  >
					<option value="1" selected="selected">是</option>
					<option value="0">否</option>
				</select>
				<div style="float:right;" style="width:100px;">
					<input type="text" name="color" id="displayColor" onclick="coloropen(event)" /> 
					<input type="button" value="颜色选择" onclick="coloropen(event)" id="backgroundColorSelect" />	
					<div id="colorpane" style="position:absolute;z-index:999;display:none;"></div> 
					<!-- <input id="backgroundColorSelect" type="color" style="height:24px;line-height:20px" disabled /> -->
				</div>	
				<input id="submitColorSelect" onclick="changeBackgroundColor()" type="button" value="确认背景" >
			</form>			
		</div>
		
		<!--提供上传文件-->
		<div style="float:right;" >
			<form action="smartUploaddemo.jsp" enctype="multipart/form-data" method="post" target="_blank">
				 输入图片ID<input name="id" size="10" id="imgid" onkeyup="checkUnique()" placeholder="输入唯一的ID" required>
				<input name="image" type="file" id="imagefile" required >
				<input id="inputSubmit" type="submit" value="submit" onclick="createNewElements()" >
			</form>			
		</div>
		
		<div style="float:right;">
			<input type="button" id="downloadPDF" onclick="print()" value="下载PDF" />
			<input type="button" id="savePrintf" onclick="saveTxt()" value="保存" />		
			<input type="button" id="historicalModle" onclick="jump()" value="查看历史模板" />	
		</div>
		
		<div style="float:right;">
			<!--字体设置工具栏-->
			<input id="bold" type="button" value="加粗"  style="height:24px;line-height:20px" />
			<input id="italic" type="button" value="加斜" style="height:24px;line-height:20px" />
			<input id="underline" type="button" value="下划线" style="height:24px;line-height:20px" />
			<input id="textareaBorder" type="button" value="边框" style="height:24px;line-height:20px" />
			<select id="fontfamily">
				<option value="" selected="selected">字体属性</option>
				<option value="宋体,simsun">宋体</option>
				<option value="楷体,楷体_gb2312,simkai">楷体</option>
				<option value="隶书,simli">隶书</option>
				<option value="黑体,simhei">黑体</option>
				<option value="andale mono,times">andale mono</option>
				<option value="arial,helvetica,sans-serif">arial</option>
				<option value="arial black,avant garde">arial black</option>
				<option value="comic sans ms,sans-serif">comic sans ms</option>
			</select>
			<select id="fontsize">
				<option value="" selected="selected">字体大小</option>
				<option value="1px">1px</option>
				<option value="2px">2px</option>
				<option value="3px">3px</option>
				<option value="4px">4px</option>
				<option value="5px">5px</option>
				<option value="6px">6px</option>
				<option value="7px">7px</option>
				<option value="8px">8px</option>
				<option value="9px">9px</option>
				<option value="10px">10px</option>
				<option value="11px">11px</option>
				<option value="12px">12px</option>
				<option value="13px">13px</option>
				<option value="14px">14px</option>
				<option value="15px">15px</option>
				<option value="16px">16px</option>
				<option value="17px">17px</option>
				<option value="18px">18px</option>
				<option value="19px">19px</option>
				<option value="20px">20px</option>
				<option value="21px">21px</option>
				<option value="22px">22px</option>
				<option value="23px">23px</option>
				<option value="24px">24px</option>
				<option value="25px">25px</option>
				<option value="26px">26px</option>
				<option value="27px">27px</option>
				<option value="28px">28px</option>
				<option value="29px">29px</option>
				<option value="30px">30px</option>
				<option value="31px">31px</option>
				<option value="32px">32px</option>
				<option value="33px">33px</option>
				<option value="34px">34px</option>
				<option value="35px">35px</option>
				<option value="36px">36px</option>
				<option value="37px">37px</option>
				<option value="38px">38px</option>
				<option value="39px">39px</option>
				<option value="40px">40px</option>
				<option value="41px">41px</option>
				<option value="42px">42px</option>
				<option value="43px">43px</option>
				<option value="44px">44px</option>
				<option value="45px">45px</option>
				<option value="46px">46px</option>
				<option value="47px">47px</option>
				<option value="48px">48px</option>
			</select>
			<button onclick="checkTest()" >test</button>
	</div>
	<div style="float:right;" style="width:110px;">
		<input type="text" name="fontColor" id="fontColor" onclick="coloropen1(event)" /> 
		<input type="button" value="颜色选择" onclick="coloropen1(event)" id="colorSelect" />	
		<div id="colorpane1" style="position:absolute;z-index:999;display:none;"></div> 
		<!-- <input id="colorselect" type="color" style="height:24px;line-height:30px" /> -->
	</div>
	
	<div id="printf">
	
	</div>
		
	<script>
		window.onload = function(){					//禁止鼠标右键事件
			document.oncontextmenu = function(e){
				e.preventDefault();
			}
		};
				
		var i ;	//加粗的变量
		var j ;	//加斜的变量
		var k ; //下划线的变量
		var l ; //边框属性的变量
		var index = 2 ;	//控制每个元素的Z-Index
		var inputSubmit = document.getElementById("inputSubmit");
		
		function jump(){				//跳转到第二个页面查看历史模板
 			//window.open("CheckModel.jsp");
            location = "${ctx}/graduate/graduate/CheckModel";
		}
		
		function wirteText(e){			//为每一个文本框输入后自动生成相对应的Html
			//alert(e.value);
			e.innerHTML=e.value;
		}				
		
		function saveTxt(){
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var f = fso.createtextfile("C:\Users\Administrator\Desktop\a.txt",2,true); 
			f.writeLine("wo shi di yi hang");
			f.close();  
		}
		
		function setPrintfSize(){
			var printf = document.getElementById("printf");
			var printfWidth = document.getElementById("printfWidth").value;
			var printfHeight = document.getElementById("printfHeight").value;
			//alert(printfWidth.value);
			if( printfWidth == 0 || printfWidth == "" || printfWidth == null || printfWidth == undefined || printfHeight == 0 || printfHeight == "" || printfHeight == null || printfHeight == undefined){
				alert("老铁 这两个值不能为空啊！我很难做啊！");	 
			}else{
				printf.style.width = printfWidth ;
				printf.style.height = printfHeight ;
			}
		}
		
		function checkUnique(){
			var inputContent = document.getElementById("imgid").value; 
			if(document.getElementById(inputContent)){
				inputSubmit.setAttribute("disabled", true);
			}else{
				$(inputSubmit).removeAttr("disabled");
			}
		}
	
		var backgroundColorSelect = document.getElementById("backgroundColorSelect");
		var backgroundTransparent = document.getElementById("backgroundTransparent");
		backgroundTransparent.onclick = function(){
			var setColorSelect =  backgroundTransparent.value;
			if(setColorSelect == "0"){
				$(backgroundColorSelect).removeAttr("disabled");
			}else{
				backgroundColorSelect.setAttribute("disabled", true);
			}
		}
		
		function changeBackgroundColor(){
			var printf = document.getElementById("printf");
			var backgroundColorSelect = document.getElementById("backgroundColorSelect");		
			var setColorSelect =  backgroundTransparent.value;
			if(setColorSelect == "0"){
				//提取颜色的选择 设置背景为该颜色
				var getbackgroundColor = backgroundColorSelect.value;
				printf.style.backgroundColor = getbackgroundColor;
			}else{
				//背景被设置为透明
				printf.style.backgroundColor = "transparent";
			}
		}
		
		function checkTest(){		//检测画布里的代码
			alert(document.getElementById("printf").innerHTML);
		}
		

		function setIndex(event,e){					//使选中的元素永远在图层的最上面
			var btnNum = event.button;
			//alert(e.button);
			if(e.style.zIndex != 1){
				index = index + 1 ;
				e.style.zIndex = index ;	
			}			
			$(e).find('textarea').css('zIndex',++index);
			if(btnNum == 1){
				//alert("点击鼠标中键");
			}else if(btnNum == 0){
				//alert("点击鼠标左键");
			}else if(btnNum == 2){
				//alert("点击鼠标右键");
				if(confirm("确认此图作为背景？")){
					e.style.zIndex = 1 ;
				}
			}
			
			fontsize = document.getElementById("fontsize");
			fontfamily = document.getElementById("fontfamily");
			fontsize.options[0].selected = true;
			fontfamily.options[0].selected = true;
			
			//让保存的元素重新到画布上后能重新拖拽伸缩编辑功能
			if($(e).hasClass("printComponents")){
				$(e).resizable({
					containment:"#printf"
				}).draggable({
					containment:"#printf"
				});
			}
		}
		
		function checkClick(e){
			//alert(e.getAttribute("id"));
			var thisID = document.getElementById(e.getAttribute("id"));
			document.onkeydown = function(){
				var oEvent = window.event; 
				if (oEvent.keyCode == 46 ) { 
					$(e).remove();
				}
			}

			var bold = document.getElementById("bold");
			bold.onclick = function(){
				if( i == 0 || i == "" || i == null || i == undefined){
					//alert(e.getAttribute("id")+"    yeah get it!");			//是否成功获取属性值
					$(thisID).find('textarea').css('font-weight',"bold");
					$(thisID).find('label').css('font-weight',"bold");
					i = 1 ;
				}else{
					$(thisID).find('textarea').css('font-weight',"normal");
					$(thisID).find('label').css('font-weight',"normal");
					i = 0 ;
				}
			}
			
			var italic = document.getElementById("italic");
			italic.onclick = function(){
				if(j == 0 || j == "" || j== undefined){
					$(thisID).find('textarea').css('font-style',"italic");
					$(thisID).find('label').css('font-style',"italic");
					j = 1 ;
				}else{
					$(thisID).find('textarea').css('font-style',"normal");
					$(thisID).find('label').css('font-style',"normal");
					j = 0;
				}
			}
			
			var underline = document.getElementById("underline");
			underline.onclick = function(){
				if(k == 0 || k == "" || k == undefined){
					$(thisID).find('textarea').css('text-decoration',"underline");
					$(thisID).find('label').css('text-decoration',"underline");	
					k = 1;
				}else{
					$(thisID).find('textarea').css('text-decoration',"none");
					$(thisID).find('label').css('text-decoration',"none");	
					k = 0;					
				}
			}
			
			var textareaBorder = document.getElementById("textareaBorder");
			textareaBorder.onclick = function(){
				if($(thisID).hasClass("textComponents")){
					if(l == 0 || l == "" || l == undefined){
						$(thisID).find('textarea').css('border',"1px solid #000");
						l = 1;
					}else{
						$(thisID).find('textarea').css('border',"none");
						l = 0;
					}
				}
			}
			
			var colorselect = document.getElementById('colorselect');					
			var size = document.getElementById("fontsize");
			var family = document.getElementById("fontfamily");
			colorselect.onchange = function(){
				var fontcolor = colorselect.value;
				$(thisID).find('textarea').css('color',fontcolor);
				$(thisID).find('label').css('color',fontcolor);
				alert(e.getAttribute("id"));
			}
			size.onchange = function(){
				var fontsize = size.value;
				$(thisID).find('textarea').css('font-size',fontsize);
				$(thisID).find('label').css('font-size',fontsize);
			}
			
			family.onchange = function(){
				var fontfamily = family.value;
				$(thisID).find('textarea').css('font-family',fontfamily);
				$(thisID).find('label').css('font-family',fontfamily);
			}
		
			//alert(e.getAttribute("id")+""+fontsize+""+fontfamily);		//是否成功获取属性值
			
			if($(thisID).hasClass("horizontallineStyle") || $(thisID).hasClass("verticallineStyle")){//border-bottom: 2px solid #000000;
				var fontcolor = colorselect.value;
				var display = '2px solid ' + fontcolor;
				if(fontsize != "" && fontsize != undefined && fontsize != 0){
					var display = fontsize + ' solid ' + fontcolor;
					//alert(display);
					//$(e).css('border-bottom',display);
					//alert($(e).css('border-bottom'));
				}
				if($(thisID).hasClass("horizontallineStyle")){
					$(thisID).css('border-bottom',display);
				}else if($(thisID).hasClass("verticallineStyle")){
					$(thisID).css('border-right',display);
				}
			}
			
		}
		
		function createTextField(pdf, TF_Id, TF_Name, posX, posY, posW, posH) {
		
			alert(TF_Id +"       "+ TF_Name+"       "+ posX+"       "+ posY+"       "+ posW+"       "+ posH);
		    var textField = new TextField();
		    textField.Rect = [posX, posY, posW, posH];
		    textField.multiline = false ;
		    //textField.F = '30px serif' ;
		    textField.V = "The quick browe quick brown fox ate the lazy mouse";
		    textField.T = TF_Name;
		    pdf.addField(textField);
		  }
		
		//使当前页面变成图片 然后转换为pdf
		function print(){
			var printfWidth = document.getElementById("printfWidth").value;
			var printfHeight = document.getElementById("printfHeight").value;
			if(printfWidth == 0 || printfWidth == "" || printfWidth == undefined){
				printfWidth = 1500;
			}
			if(printfHeight == 0 || printfHeight == "" || printfHeight == undefined){
				printfHeight = 920;
			}
			var pdf = new jsPDF('l', 'px', [printfWidth,printfHeight]);
			$.each($('.specialElements'),function(){
				var TF_Id = $(this).attr("id");
				var TF_Name = $(this).attr("name");
				var posX = parseInt($(this).css("left"));
				var posY = parseInt($(this).css("top"));
				var posW ;
				var posH ;	
				var width = parseInt($(this).css("width"));
				var height = parseInt($(this).css("height"));
				if(width == 0 || width == "" || width== undefined){
					width = 80;
				}
				posW = width;
				if(height == 0 || height == "" || height == undefined){
					height = 30; 
				}
				posH = height;
				createTextField(pdf, TF_Id, TF_Name, posX, posY, posW, posH);	
				this.remove();
			});	

			html2canvas( $("#printf") ,{     
				onrendered: function(canvas){
					pdf.addImage(canvas, 'PNG', 0, 0,printfWidth,printfHeight);
					pdf.save('content.pdf');
					
				} 
			}); 
			
		}
		
		function createNewElements(){
			var inputContent = document.getElementById("imgid").value; 
			if(document.getElementById(inputContent)){
				$("#imgid").val("");
				$("#imagefile").val("");
			}else{
				var openUl = document.getElementById("othersElements");
				var openDiv = document.createElement("div");
				openDiv.setAttribute('class','components othersElement');
				openDiv.id = document.getElementById("imgid").value;
				openDiv.innerHTML = document.getElementById("imgid").value;
				$(openDiv).draggable({
					appendTo:"body",
					helper:"clone"
				});
				openUl.appendChild(openDiv);
			}
		}			  
	</script>	
	
	<!-- 关于背景颜色选择器的JS代码1-->
	<script type="text/javascript" language="javascript"> 
		var ColorHex1 = new Array('00', '33', '66', '99', 'CC', 'FF')
		var SpColorHex1 = new Array('FF0000', '00FF00', '0000FF', 'FFFF00', '00FFFF', 'FF00FF')
		var current1 = null
		function initcolor(evt)
		 {
		    var colorTable1 = ''
		    for (i = 0; i < 2; i++)
		    {
		        for (j = 0; j < 6; j++)
		        {
		            colorTable1 = colorTable1 + '<tr height=15>'
		            colorTable1 = colorTable1 + '<td width=15 style="background-color:#000000">'
		            if (i == 0) {
		                colorTable1 = colorTable1 + '<td width=15 style="cursor:pointer;background-color:#' + ColorHex1[j] + ColorHex1[j] + ColorHex1[j] + '" onclick="doclick(\'#' + SpColorHex1[j] + '\')">'
		            }
		            else {
		                colorTable1 = colorTable1 + '<td width=15 style="cursor:pointer;background-color:#' + SpColorHex1[j] + '" onclick="doclick(\'#' + SpColorHex1[j] + '\')">'
		            }
		            colorTable1 = colorTable1 + '<td width=15 style="background-color:#000000">'
		            for (k = 0; k < 3; k++)
		            {
		                for (l = 0; l < 6; l++)
		                {
		                    colorTable1 = colorTable1 + '<td width=15 style="cursor:pointer;background-color:#' + ColorHex1[k + i * 3] + ColorHex1[l] + ColorHex1[j] + '" onclick="doclick(\'#' + SpColorHex1[j] + '\')">'
		                }
		            }
		        }
		    }
		    colorTable1 = '<table border="1" cellspacing="0" cellpadding="0" style="text-align:center;cursor:pointer;border-collapse:collapse" bordercolor="000000" bgcolor="#FFFFFF" >'
		    + '<tr><td colspan="21"><span style="float:right;margin-right:5px;cursor:pointer;" onclick="colorclose()">×关闭</span><span style="float:right;margin-right:5px;cursor:pointer;" onclick="defaultColor()">默认颜色</span><span style="float:left;margin-right:5px;">颜色选择</span></td></tr>'
		    + colorTable1 + '</table>';
		    document.getElementById("colorpane").innerHTML = colorTable1;
		    var current_x1 = document.getElementById("backgroundColorSelect").offsetLeft;
		    var current_y1 = document.getElementById("backgroundColorSelect").offsetTop;
		    //alert(current_x + "-" + current_y) 
		    document.getElementById("colorpane").style.left = current_x1 + "px";
		    document.getElementById("colorpane").style.top = current_y1 + "px";
		}
		function doclick(colorValue){
		    //alert(colorValue); 
		    document.getElementById('displayColor').value = colorValue;
		    document.getElementById("colorpane").style.display = "none";
		}
		function defaultColor(){
		    document.getElementById('displayColor').value = '';
		    document.getElementById("colorpane").style.display = "none";
		    //alert("ok"); 
		}
		function colorclose(){
		    document.getElementById("colorpane").style.display = "none";
		    //alert("ok"); 
		}
		//打开第一个颜色选择器
		function coloropen(){
		    document.getElementById("colorpane").style.display = "";
		}
		window.onload = initcolor;
	</script>
	
</body>
</html>