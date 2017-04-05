<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_register</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

  </head>
  
  <body>
    <h3>注册</h3>
    <form action="addUser.do" method="post">
    <table>
    <tr>
    <td>用户名:</td>
    <td><input type="text" id="userName" name="userName"/></td>
    </tr>
    <tr>
    <td>密码</td>
    <td><input type="password" id="password" name="password"/></td>
    </tr>
    <tr>
    <td>确认密码</td>
    <td><input type="password" id="password_confirm" name="password_confirm"/></td>
    </tr>
    <tr>
    <td><input type="submit" value="注册"/></td>
    <td><a href="view/login.jsp">去登录</a></td>
    </tr>
    </table>
    </form>
  </body>
</html>
