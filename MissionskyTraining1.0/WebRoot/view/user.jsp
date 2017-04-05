<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_user</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	/*用于记录输入合法与否返回结果集*/
    var error_array=new Array();
	 $(function(){
	    
	      $("#addUser").click(function(){  
	          $("#addU").show();
	     });
	       $("#exit_addU").click(function(){
	        
	          $("#addU").hide();
	     });
	     
	     $("#userName").keyup(function(){
	        var userName=$("#userName").val();
	        if(userName!='')
	        {
	        $.ajax({
            url:"validaeUser.do",
            type:"post",
            data:{userName:userName},
            success:function(returndata){
               if(returndata!='')
               {
               $("#userName_msg").css({"color":"red","font-size":"13px"});
			   $("#userName_msg").html("该用户名已存在!");
			   error_array[0]="false";
               }else
               {
               var patten= new RegExp(/^[a-zA-Z][a-zA-Z0-9_]{2,19}$/)
               if(patten.test(userName))
               {
                   error_array[0]="true";
                   $("#userName_msg").html("");
               }else
               {
                   $("#userName_msg").css({"color":"red","font-size":"13px"});
			       $("#userName_msg").html("以字母开头,3-20位组成");
			       error_array[0]="false";
               }
               }
             }
             });
	        }else
	        {
	           $("#userName_msg").html("");  
	        }
	          
	     });

	     $("#password").keyup(function(){
	         
	        var content=$("#password").val();
	        var patten= new RegExp(/^[a-zA-Z0-9_]{6,15}$/);
	        if(patten.test(content)||content=="")
		    {
		    if(patten.test(content))
			{
			   error_array[1]="true";
			}
			 $("#password_msg").html("");
		   }else	
		   {
			$("#password_msg").css({"color":"red","font-size":"13px"});
			$("#password_msg").html("密码必须为6-15位");
			   error_array[1]="false";
		   }
	     });
	  });
	 
	 function addUser()
	 {
	     if($("#userName").val()==''||$("#password").val()=='')
	     {
	        if($("#userName").val()=='')
	        {
	           $("#userName_msg").css({"color":"red","font-size":"13px"});
			   $("#userName_msg").html("请输入用户名!");
			   error_array[0]="false";
	        }
	        else if($("#password").val()=='')
	        {
	           $("#password_msg").css({"color":"red","font-size":"13px"});
			   $("#password_msg").html("请输入密码!");
			   error_array[1]="false";
	        }
	       
	        return false;
	     }else
	     {
			if(error_array[0]=="true"&&error_array[1]=="true")
			{
		    $.ajax({
              url:"addUser.do",
              type:"post",
              data:{userName:$("#userName").val(),password:$("#password").val()},
              success:function(returndata){
                alert(returndata);
            }
            });
             $("#addU").hide();
			}else
			{
			   return false;
			}
         }
	 }
	</script>  
	
    <style type="text/css">
	#addU{width:300px;height:150px;display:none;border:1px solid gray;position:absolute;top:100px;left:200px;background-color:#D0D0D0;border-radius:6px;}
	#exit_addU{position:absolute;top:2px;right:2px;cursor:pointer;}
	</style>
	
	<link rel="stylesheet" href="layui/css/layui.css" media="all" />

  </head>
  
  <body>
    <button id="addUser" class="layui-btn">添加用户</button>
    <div id="addU">
    <button id="exit_addU">X</button>
    <table>
  <tr><td>用户名</td><td><input type="text" id="userName" name="userName"/></td></tr>
  <tr><td colspan=2><span id="userName_msg"></span></td></tr>
  <tr><td>密码</td><td><input type="password" id="password" name="password"/></td></tr>
  <tr><td colspan=2><span id="password_msg"></span></td></tr>
  <tr><td colspan=2><button onclick="return addUser();" class="layui-btn-small">添加</button></td></tr>
    </table>
    </div>
  </body>
</html>
