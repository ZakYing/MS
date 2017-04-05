<%@ page language="java" import="java.util.*,com.missionsky.training.domain.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>missionsky_training_attachment_detail</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
	<link rel="stylesheet" href="layui/css/layui.css" media="all" />
	
    <script type="text/javascript" src="js/jquery-1.8.3.js"></script> 
    <script type="text/javascript" src="layui/lay/dest/layui.all.js"></script> 
	
	
	
    <script type="text/javascript">
      function attachment_download(attachmentName)
      {
          $.ajax({
            url:"attachment_download.do",
            type:"post",
            data:{attachmentName:attachmentName},
            success:function(data){
               layer.alert(data);
            }
         });
      }
    </script>
	
	</head>
	  <%
        List<AttachmentInfo> result=(ArrayList)request.getAttribute("result");
        int pageIndex=Integer.parseInt(request.getAttribute("pageIndex").toString());
        int pageCount=Integer.parseInt(request.getAttribute("pageCount").toString());
     %>

	<body style="margin: 20px;">

		<div class="layui-form">
			<div class="layui-form-item">
				<form action="attachment_query.do" method="post" style="float: right;">
					<div class="layui-inline">
						<input name="QueryName" lay-verify="required" placeholder="请输入关键字" autocomplete="off" class="layui-input" type="text">
					</div>
					<input type="hidden" name="pageIndex" value=${pageIndex} >
					<input type="hidden" name="flag" value=${flag} >
					<input type="submit" class="layui-btn" value="搜索"style="margin-top:-6px" />
				</form>
			</div>

           <form id="formlist" name="formlist" action="attachment_op.do" method="post">
           <input type="hidden" name="flag" value=${flag}>
			<table class="layui-table">
				<colgroup>
					<col width="150">
					<col width="200">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>文件名</th>
						<th>文件大小</th>
						<th>上传日期</th>
						<th>上传者</th>
						<th>下载</th>
					</tr>
				</thead>
				<tbody>
	  <%
        for(AttachmentInfo a:result)
        {
         String date_updatedate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(a.getUploadDate()); 
       %>
					<tr>
						<td><%=a.getAttachmentName() %></td>
						<td><%=a.getAttachmentSize() %></td>
						<td><%=date_updatedate %></td>
						<td><%=a.getUser().getUserName() %></td>
						<td>
							<a href="javascript:attachment_download('<%=a.getAttachmentName() %>')">下载</a>
						</td>
					</tr>
	  <%
        }
       %>
				</tbody>
			</table>
			
			  <div class="layui-form" style="text-align: center;">
				  <%
				    if(pageIndex!=1)
				    {
				      if(request.getAttribute("QueryName")==null)
				      {
				   %>
				   <a class="layui-btn layui-btn-small" href="attachment_op.do?pageIndex=<%=pageIndex-1 %>&flag=${flag}"><i class="layui-icon"> </i></a>
				   <%
				      }else
				      { 
				   %>
				    <a class="layui-btn layui-btn-small" href="attachment_query.do?pageIndex=<%=pageIndex-1 %>&QueryName=${QueryName}&flag=${flag}"><i class="layui-icon"></i></a> 
				   <%
				      }
				     }
				  %>
				 <label class="lbl">共<strong style="letter-spacing: 0;">${rowCount }</strong>条记录</label>
			     <label class="lbl">共<strong style="letter-spacing: 0;">${pageCount }</strong>页</label>
			     <label class="lbl">当前第<strong style="letter-spacing: 0;">${pageIndex }</strong>页</label>
			     <%
				   if(request.getAttribute("QueryName")==null)
				   {
				  %>
				 <label class="lbl">转到第<strong style="letter-spacing: 0;"><a href="javascript:document.formlist.submit();"><input style="width:30px;" name="pageIndex" value="1"/></a></strong>页</label>
				 <%
				   }
				  %>
				   <%
				    if(pageIndex!=pageCount)
				    {
				      if(request.getAttribute("QueryName")==null)
				      {
				   %>
				   <a class="layui-btn layui-btn-small" href="attachment_op.do?pageIndex=<%=pageIndex+1 %>&flag=${flag}"><i class="layui-icon"></i></a>
				  <%
				      }else
				      { 
				   %>
				     <a class="layui-btn layui-btn-small" href="attachment_query.do?pageIndex=<%=pageIndex+1 %>&QueryName=${QueryName}&flag=${flag}"><i class="layui-icon"></i></a> 
				   <%
				      }
				     }
				  %>
			</div>

			</form>	
		</div>
	 
	</body>
</html>
