<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_index</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

  </head>
  
  <frameset border=0 framespacing=0 rows="13%,*"> 
  <frame   frameborder=0 src="view_index/top.jsp" scrolling=no  noresize> 
  <frameset  border=0 framespacing=0 cols="15%,*"> 
  <frame  frameborder=0  src="view_index/menu.jsp"  noresize> 
  <frame  frameborder=0  name="right" src="view_index/content.jsp"  noresize> 
  </frameset>
  </frameset>
 
</html>
