<%@ page language="java" import="java.util.*,com.missionsky.training.domain.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_userPermit</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	 <script type="text/javascript" src="js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	  function permit_give()
	  {
	    var checkList=document.getElementsByName("checkMenus");
		for(var i=0;i<checkList.length;i++)
		{
			var isSelected=false;
			if(checkList[i].checked==true)
			{
				isSelected=true;
				break;
			}			
		}
		
		if(isSelected==true)
		{
		    if(confirm("确定授权吗?"))
			{
				$.ajax({  
                url : "userPermit.do",  
                type : "post",  
                data : $("#permitForm").serialize(),  
                success : function(returndata) {  
                  alert(returndata);
                 },  
                error : function(returndata) {  
                 alert(returndata);
                 }  
             });
			}
		}
		else
		{
			alert("您还没有选择任何项！");
			return false;
		}
	  }
	  
	  function checkedAll()
	  {
	    var checkList=document.getElementsByName("checkMenus");
	    var flag=false;
		for(var i=0;i<checkList.length;i++)
		{
		    if(checkList[i].checked==true)
			{
			   flag=true;
			   break;
			}	
		}
		  
		   if(flag==false)
		   {
			   $("#checkAll").text("全不选");
			   for(var i=0;i<checkList.length;i++)
			   {
			   checkList[i].checked=true;
			   }
			}else
			{
			   $("#checkAll").text("全选");
			   for(var i=0;i<checkList.length;i++)
			   {
			   checkList[i].checked=false;
			   }
			}	
	  }
	  
	  function checked_one(parentId,gfId)
	  {
	     if(parentId!=0)
	     $("#"+parentId+"").attr("checked","checked");
	     if(gfId!=0)
	     $("#"+gfId+"").attr("checked","checked");
	  }
	</script>
	
	<style type="text/css">
	 #userPermit{border:1px solid #C6C4D6;border-radius:6px;margin-top:15px;padding-top:15px;}
	 #lev1{font-size:17px;color:#0F0539;text-align:left;}
	 #lev2{font-size:15px;color:#4831C1;text-align:center;}
	 #lev3{font-size:13px;color:#74717E;text-align:right;}
	</style>
	
  </head>
    <%
        List<Menu> menuList=(List<Menu>)request.getSession().getAttribute("menuList");
     %>
  <body>
   <button id="checkAll" onclick="checkedAll();">全选</button> <button onclick="permit_give();">确认授权</button>
     <div id="userPermit">
      <form id="permitForm">
          <table id="lev1">
          <%
             //先获取一级菜单
             for(Menu m:menuList)
             {
                if(m.getParentId()==0)
                {         
           %>
             <tr><td>-<input type="checkbox" onchange="checked_one(0,0);" id=<%=m.getmenuId() %> name="checkMenus" value=<%=m.getmenuId() %>><%=m.getmenuName() %>
              <table id="lev2">
              <tr>
              <%
                  //再获取二级菜单
                   for(Menu m2:menuList)
                   {
                      if(m2.getParentId()==m.getmenuId())
                      {
               %>
                  <td>--<input type="checkbox" onchange="checked_one(<%=m.getmenuId() %>,0);" id=<%=m2.getmenuId() %> name="checkMenus" value=<%=m2.getmenuId() %>><%=m2.getmenuName() %>
                  <table id="lev3">
                  <tr>
                  <%
                      //最后获取三级菜单
                      for(Menu m3:menuList)
                      {
                         if(m3.getParentId()==m2.getmenuId())
                         {
                   %>
                     <td>---<input type="checkbox" onchange="checked_one(<%=m2.getmenuId() %>,<%=m.getmenuId() %>);" id=<%=m3.getmenuId() %> name="checkMenus" value=<%=m3.getmenuId() %>><%=m3.getmenuName() %>
                   <%
                         }
                      }
                    %>
                    </td>
                  </tr>
                  </table>
                  </td>
               <%
                      }
                   }
                %>
                </tr>
                </table>
             </td>
             </tr>
             <tr><td><span style="color:#C4C1C6;">-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span></td></tr>
           <% 
                }
             }
            %>
            </table>
            </form>
     </div>       
  </body>
</html>
