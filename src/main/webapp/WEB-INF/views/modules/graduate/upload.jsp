<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>My JSP 'plupload.jsp' starting page</title>
    <link type="text/css" rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/css/jquery-ui.min.css" media="screen" />
    <link type="text/css" rel="stylesheet" href="static/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css" media="screen" />
    <script type="text/javascript" src="static/plupload/js/jquery.js"></script>
</head>

<body>
<div id="uploader">
    <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
</div>
<button id="toStop">暂停一下</button>
<button id="toStart">再次开始</button>
<div id="result"></div>
<script type="text/javascript">
    $(function() {
        $("#uploader").plupload({
            runtimes : 'html5,flash,silverlight,html4',
            url : "${ctx}/graduate/plupload/plupload",
            // url : "pluploadservlet", //servlet版本
            // Maximum file size
            max_file_size : '1024mb',
            chunk_size : '10mb',
            // Resize images on clientside if we can
            resize : {
                width : 200,
                height : 200,
                quality : 90,
                crop : true
            },
            // Specify what files to browse for
            filters : [ {
                title : "Image files",
                extensions : "jpg,gif,png"
            }, {
                title : "Zip files",
                extensions : "zip,rar"
            } ],
            // Rename files by clicking on their titles
            rename : true,
            // Sort files
            sortable : true,
            // Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
            dragdrop : true,
            // Views to activate
           init:{
               FileUploaded:function(upload,file,info){
                   var response = $.parseJSON(info.response);
                   if(!response.status){
                       $("#result").append($('<div>'+response.stuInfo+'</div>'))
                   }
               },
           },
            //FileUploaded就是接收服务器上返回的数据
            views : {
                list : true,
                thumbs : true, // Show thumbs
                active : 'thumbs'
            },
            // Flash settings
            flash_swf_url : 'static/plupload/js/Moxie.swf',
            // Silverlight settings
            silverlight_xap_url : 'static/plupload/js/Moxie.xap',

        });
        $('#toStop').on('click',function(){
            uploader.stop();
        })
        $('#toStart').on('click',function () {
            uploaded.start();
        })
    });

</script>
<script type="text/javascript" src="static/plupload/js/jquery-ui.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="static/plupload/js/plupload.full.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="static/plupload/js/i18n/zh_CN.js"></script>
<script type="text/javascript" src="static/plupload/js/jquery.ui.plupload/jquery.ui.plupload.min.js" charset="UTF-8"></script>
</body>
</html>
