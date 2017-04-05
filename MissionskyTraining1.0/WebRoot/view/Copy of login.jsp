<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Missionsky_training_login</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

  </head>
  
  <body>
<h3>用户登录</h3>
<form action="login.do" method="post">
 <table>
 <tr>
<td>用户名</td>
<td><input type="text" id="userName" name="userName"/></td>
</tr>
<tr>
<td>密码</td>
<td><input type="password" id="password" name="password"/></td>
</tr>
<tr>
<td><input type="submit" value="登录"/></td>
<td><a href="view/register.jsp">注册</a></td>
</tr>
</table>
</form>
  </body>
</html>
