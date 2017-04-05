<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_menu</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	 $(function(){
	    
	      $("#addMenu").click(function(){  
	          getMenuList();
	          $("#addM").show();
	     });
	       $("#exit_addM").click(function(){
	        
	          $("#addM").hide();
	     });
	 });
	 	
	 function getMenuList()
     {
          $.ajax({
            url:"getMenuList.do",
            type:"post",
            dataType:"json",
            data:{flag:"Lev12"},
            success:function(MenuList){
                 $("#parentId").empty();
                   var str="<option value=''>---请选择---</option>";
                   $("#parentId").append(str);
                 $.each(MenuList,function(key,obj){
                    var str=null;
                    if(obj.parentId==0)
                    str="<option value="+obj.menuId+">"+obj.menuName+"</option>";
                    else
                    str="<option value="+obj.menuId+">--"+obj.menuName+"</option>";
                    $("#parentId").append(str);
                 });
            }
         });
      }
      
      function addMenu()
      {
        if($("#menuName_add").val()=='')
        {
          alert("菜单名称不能为空!");
          return false;
        }else
        {
          var formData = new FormData($( "#addForm" )[0]);
         $.ajax({
                  url:"addMenu.do",
                  type:"post",
                  data: formData,
                  async: false,  
                  cache: false,  
                  contentType: false,  
                  processData: false, 
                  success:function(returndata){
                  alert(returndata);
                  },error: function (returndata){  
                    alert(returndata);  
                 }   
                });
        }
      }
      
      function onload_data()
      {
         $("#menuLev2").empty();
         $("#menuLev3").empty();
         var str="<option value='-1'>---请选择---</option>";
         $("#menuLev2").append(str);
         $("#menuLev3").append(str);
         
         $.ajax({
            url:"getMenuList.do",
            type:"post",
            dataType:"json",
            data:{flag:"Lev1"},
            success:function(MenuList){
                 $("#menuLev1").empty();
                 var str="<option value='-1'>---请选择---</option>";
                 $("#menuLev1").append(str);
                 $.each(MenuList,function(key,obj){
                    str="<option value="+obj.menuId+">"+obj.menuName+"("+obj.url+")</option>";
                    $("#menuLev1").append(str);
                 });
            }
         });
      }
      
      function ChangeMenuLev1()
      {
          var text=$("#menuLev1").find("option:selected").text();
          var arr=text.split('(');
          $("#getID1").val($("#menuLev1").val());
          if($("#menuLev1").val()!='-1')
          {
          $("#getLev1").val(arr[0]);
          $("#getUrl1").val(arr[1].substring(0,arr[1].length-1));
          }else
          {
             $("#getLev1").val("");
             $("#getUrl1").val("");
          }
          
           $.ajax({
            url:"getMenuList.do",
            type:"post",
            dataType:"json",
            data:{flag:"Lev2",menuId:$("#menuLev1").val()},
            success:function(MenuList){
                 $("#menuLev2").empty();
                 var str="<option value='-1'>---请选择---</option>";
                 $("#menuLev2").append(str);
                 $.each(MenuList,function(key,obj){
                    str="<option value="+obj.menuId+">"+obj.menuName+"("+obj.url+")</option>";
                    $("#menuLev2").append(str);
                 });
            }
         });
      }
      
      function ChangeMenuLev2()
      {
        var text=$("#menuLev2").find("option:selected").text();
          var arr=text.split('(');
          $("#getID2").val($("#menuLev2").val());
          if($("#menuLev2").val()!='-1')
          {
          $("#getLev2").val(arr[0]);
          $("#getUrl2").val(arr[1].substring(0,arr[1].length-1));
          }else
          {
             $("#getLev2").val("");
             $("#getUrl2").val("");
          }
          
           $.ajax({
            url:"getMenuList.do",
            type:"post",
            dataType:"json",
            data:{flag:"Lev3",menuId:$("#menuLev2").val()},
            success:function(MenuList){
                 $("#menuLev3").empty();
                 var str="<option value='-1'>---请选择---</option>";
                 $("#menuLev3").append(str);
                 $.each(MenuList,function(key,obj){
                    str="<option value="+obj.menuId+">"+obj.menuName+"("+obj.url+")</option>";
                    $("#menuLev3").append(str);
                 });
            }
         });
      }
      
      function ChangeMenuLev3()
      {
          var text=$("#menuLev3").find("option:selected").text();
          var arr=text.split('(');
          $("#getID3").val($("#menuLev3").val());
          if($("#menuLev3").val()!='-1')
          {
          $("#getLev3").val(arr[0]);
          $("#getUrl3").val(arr[1].substring(0,arr[1].length-1));
          }else
          {
             $("#getLev3").val("");
             $("#getUrl3").val("");
          }
      }
      
      function op(flag)
      {
          if(flag=='update1')
          {
              var menuName=(($("#menuLev1").find("option:selected").text()).split('('))[0];
              if(menuName=='菜单管理')
              alert('菜单管理不可编辑');
              else if($("#menuLev1").val()=='-1')
              alert('请先选择菜单!');
              else if($("#getLev1").val()=='')
              alert("菜单名称不能为空!");
              else
              {
               var formData = new FormData($( "#formLev1" )[0]);                    
               menuUpdateAjax(formData);
              }
          }else if(flag=='update2')
          {
                 if($("#menuLev2").val()=='-1')
                 alert('请先选择菜单!');
                 else if($("#getLev2").val()=='')
                 alert("菜单名称不能为空!");
                 else
                 {
                 var formData = new FormData($( "#formLev2" )[0]);                    
                 menuUpdateAjax(formData);
                 }
          }
          else if(flag=='update3')
          {
                 if($("#menuLev3").val()=='-1')
                 alert('请先选择菜单!');
                 else if($("#getLev3").val()=='')
                 alert("菜单名称不能为空!");
                 else
                 {
                 var formData = new FormData($( "#formLev3" )[0]);                    
                 menuUpdateAjax(formData);
                 }
          }else if(flag=='delete1')
          {
              var menuName=(($("#menuLev1").find("option:selected").text()).split('('))[0];
              if(menuName=='菜单管理')
              alert('菜单管理不可删除');
              else if($("#menuLev1").val()=='-1')
              alert('请先选择菜单!')
              else
              {
              if(confirm('删除此菜单,其子菜单会被一同删除,确认删除吗?'))
              {
                  menuDelete($("#getID1").val(),'lev1');
              }
              }
          }else if(flag=='delete2')
          {
              if($("#menuLev2").val()=='-1')
              alert('请先选择菜单!')
              else
              {
              if(confirm('删除此菜单,其子菜单会被一同删除,确认删除吗?'))
              {
                 menuDelete($("#getID2").val(),'lev2');
              }
              }
          }else if(flag=='delete3')
          {
              if($("#menuLev3").val()=='-1')
              alert('请先选择菜单!')
              else
              {
              if(confirm('确认删除吗?'))
              {
                 menuDelete($("#getID3").val(),'lev3');
              }
              }
          }
      }
      
      function menuUpdateAjax(formData)
      {         
                 $.ajax({
                  url:"updateMenu.do",
                  type:"post",
                  data: formData,
                  async: false,  
                  cache: false,  
                  contentType: false,  
                  processData: false, 
                  success:function(returndata){
                  alert(returndata);
                  },error: function (returndata){  
                    alert(returndata);  
                 }   
                });
      }
      
      function menuDelete(menuId,lev)
      {
           $.ajax({
            url:"deleteMenu.do",
            type:"post",
            data:{menuId:menuId,lev:lev},
            success:function(returndata){
                alert(returndata);
            }
         });
      }
	</script>
	
	<style type="text/css">
	#addM{width:350px;height:150px;display:none;border:1px solid gray;position:absolute;top:100px;left:200px;background-color:#D0D0D0;border-radius:6px;}
	#exit_addM{position:absolute;top:2px;right:2px;cursor:pointer;}
	</style>
  </head>
  
  <body>
      <button id="addMenu">添加菜单</button><button onclick="onload_data();">加载数据</button>
      <div id="addM">
      <button id="exit_addM">X</button>
      <form id="addForm">
      <table>
      <tr>
      <td>菜单名称</td>
       <td><input type="text" id="menuName_add" name="menuName"></td>
      </tr>
        <tr>
      <td>上一级</td>
       <td><select id="parentId" name="parentId"></select></td>
      </tr>
        <tr>
      <td>菜单图标</td>
       <td><input type="file" name="menuImg"></td>
      </tr>
        <tr>
      <td>URL</td>
       <td><input type="text" name="url"></td>
      </tr>
        <tr>
       <td colspan=2><button onclick="return addMenu();">添加</button></td>
      </tr>
      </table>
      </form>
      </div>
      
     <div id="menu_eidt">
        <table>
        <tr>
        <td>一级菜单</td>
        <td>二级菜单</td>
        <td>三级菜单</td>
        </tr>
         <tr>
        <td><select id="menuLev1" onchange="ChangeMenuLev1();"><option value='-1'>---请选择---</option></select></td>
        <td><select id="menuLev2" onchange="ChangeMenuLev2();"><option value='-1'>---请选择---</option></select></td>
        <td><select id="menuLev3" onchange="ChangeMenuLev3();"><option value='-1'>---请选择---</option></select></td>
        </tr>
         <tr>
        <td>
        <form id="formLev1">
        <input type="hidden" id="getID1" name="menuId"/>
        <table>
        <tr>
        <td>菜单名称</td> <td><input type="text" id="getLev1" name="menuName"/></td>
        </tr>
         <tr>
        <td>URL</td><td><input type="text" id="getUrl1" name="url"/></td>
        </tr>
         <tr>
        <td>菜单图标</td><td><input type="file" name="menuImg"/></td>
        </tr>
        </table>
        </form>
        </td>
        <td>
        <form id="formLev2">
         <input type="hidden" id="getID2" name="menuId"/>
        <table>
        <tr>
        <td>菜单名称</td> <td><input type="text" id="getLev2" name="menuName"/></td>
        </tr>
         <tr>
        <td>URL</td><td><input type="text" id="getUrl2" name="url"/></td>
        </tr>
         <tr>
        <td>菜单图标</td><td><input type="file" name="menuImg"/></td>
        </tr>
        </table>
        </form>
        </td>
        <td>
        <form id="formLev3">
         <input type="hidden" id="getID3" name="menuId"/>
        <table>
        <tr>
        <td>菜单名称</td> <td><input type="text" id="getLev3" name="menuName"/></td>
        </tr>
         <tr>
        <td>URL</td><td><input type="text" id="getUrl3" name="url"/></td>
        </tr>
         <tr>
        <td>菜单图标</td><td><input type="file" name="menuImg"/></td>
        </tr>
        </table>
        </form>
        </td>
        </tr>
        <tr>
        <td><button onclick="op('update1');">修改</button><button onclick="op('delete1');">删除</button></td>
        <td><button onclick="op('update2');">修改</button><button onclick="op('delete2');">删除</button></td>
        <td><button onclick="op('update3');">修改</button><button onclick="op('delete3');">删除</button></td>
        </tr>
        </table>
     </div>
      
  </body>
</html>
