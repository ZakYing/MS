<%@ page language="java" import="java.util.*,com.missionsky.training.domain.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_index_menu</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
    <script type="text/javascript" src="js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	 function op_tb(menuId)
	 {
	     if($("#"+menuId+"").css("display")=='none')
	     {
	        $("#"+menuId+"").css("display","block");
	     }
	     else
	        $("#"+menuId+"").css("display","none");
	 }
	</script>
	
	<style type="text/css">
	 #lev1{list-style:none;font-size:17px;color:black}
	 .lev2{font-size:15px;color:lightgray}
	 .lev3{font-size:13px;color:gray}
	 
	 a{color:#111;text-decoration:none;}
	 a:hover{color:#666}
	</style>
    
  </head>
    <%
	  List<Menu> menuList=(List<Menu>)request.getSession().getAttribute("menuList");
	 %>
  
  <body>
      <ul id="lev1">
        <%
         //先展示一级菜单
          for(Menu m:menuList)
          {
             if(m.getParentId()==0)
             {
                int flag_0=0;
                for(Menu m_temp_0:menuList)
                {
                   if(m_temp_0.getParentId()==m.getmenuId())
                   flag_0++;
                }
                if(flag_0==0)
                {
          %>
            <li>
             <a href="<%=m.getUrl() %>" target="right"><%=m.getmenuName() %></a>
            </li>
               <%
               }else{
                %>
                <li>
              <a href="javascript:op_tb(<%=m.getmenuId() %>);"><%=m.getmenuName() %></a>
              <table id="<%=m.getmenuId() %>" class="lev2">
              <%
                 //显示二级菜单
                   for(Menu m2:menuList)
                   {
                     if(m2.getParentId()==m.getmenuId())
                     {
                       int flag=0;
                       for(Menu m_temp:menuList)
                       {
                         if(m_temp.getParentId()==m2.getmenuId())
                         flag++;
                       }
                     if(flag==0)
                     {
               %>
                    <tr><td><a href="<%=m2.getUrl() %>" target="right">--<%=m2.getmenuName() %></a></td></tr>
                   <%
                     }else
                     {
                    %>
                    <tr><td><a href="javascript:op_tb(<%=m2.getmenuId() %>);">--<%=m2.getmenuName() %></a>
                    <table id="<%=m2.getmenuId() %>" class="lev3">
                    <%
                       //显示三级菜单
                       for(Menu m3:menuList)
                       {
                         if(m3.getParentId()==m2.getmenuId())
                         {
                     %>
                      <tr><td><a href="<%=m3.getUrl() %>" target="right">----<%=m3.getmenuName() %></a></td></tr>
                     <%
                         }
                       }
                      %>
                    </table>
                    </td></tr>
                     <%
                     }
                     %>
               <%
                     }
                   }
                 }
                %>
              </table>
            </li>
          <%
             }
           }
          %>
      </ul>
  </body>
</html>
