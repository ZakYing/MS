<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_index_top</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
  <style type="text/css">
			 a{
			    cursor: pointer;
				text-decoration: none;
			}
			.tab .img{
				color: #000000;
			}
			img{
				width: 61px;
				height: 36px;
				object-fit: cover;
			}
			.top{
				padding-left: 200px;
				display: inline;
			}
		</style>
	</head>
	<body style="background-color: aqua;">
			<div class="top">
				<a href=""> <img src="img/ms.png" class="img" /></a>
				<span><a href="#" target="_self">MissionSky Inc.</a></span>
				<span style="width: 100px; display: inline-block;"></span>
				<center style="display: inline-block; font-size: 24px;"><a href="#"><strong>凌云新创信息科技培训网站</strong></a></center>
				<a href="logout.do" target="_parent" style="float: right;">退出</a>
			</div>
			<div>
					<span style="float:right"> 欢迎您,<strong style="color:red">${user.userName}</strong></span>		
			</div>
	</body>
</html>

