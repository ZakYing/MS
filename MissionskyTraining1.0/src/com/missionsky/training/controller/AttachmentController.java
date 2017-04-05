package com.missionsky.training.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Time;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.missionsky.training.dao.AttachmentDao;
import com.missionsky.training.domain.Attachment;
import com.missionsky.training.domain.AttachmentInfo;
import com.missionsky.training.domain.PageData;
import com.missionsky.training.domain.User;
import com.missionsky.training.util.ByteSwitchUtil;
import com.missionsky.training.util.GetPageIndex;

@Controller
public class AttachmentController {
	
	@Autowired
	private AttachmentDao attachmentDao;

	//进入附件操作页面(分页查询,设置每页显示10条记录，首次进入默认pageIndex=1)
	@RequestMapping("/attachment_op")
	public String to_attach_op(@RequestParam("pageIndex")int pageIndex,@RequestParam("flag")String flag,Model model)
	{	
		 int rowCount=attachmentDao.getRowcount();
	   	 int pageCount=(rowCount-1)/10+1;
	   	 PageData pd=GetPageIndex.getData(pageIndex, 10);
	   	 
	   	 List<AttachmentInfo> result=attachmentDao.getAttachmentByPage(pd);
	   	
	   	 model.addAttribute("result", result);
	   	 model.addAttribute("pageIndex", pageIndex);
	   	 model.addAttribute("rowCount", rowCount);
	   	 model.addAttribute("pageCount", pageCount);
	   	 model.addAttribute("flag", flag);
	   	 
		if(flag.equals("detail"))
		return "attachment_detail";
		else
		return "attachment_manage";
	}
	
	//上传附件
	@RequestMapping("/attachment_upload")
	@Transactional
	public String attachment_upload(@RequestParam("attachment") CommonsMultipartFile attachment,@RequestParam("pageIndex")int pageIndex,@RequestParam("flag")String flag,Model model,HttpServletRequest request)
	{
		if(!attachment.isEmpty())
		{
			//获得服务器下附件文件夹路径
			String path=request.getSession().getServletContext().getRealPath("/attachment");
			 File file=new File(path);
			 if(!file.exists())
				 file.mkdir();
			 
			try {
				FileOutputStream fo=new FileOutputStream(path+"/"+attachment.getOriginalFilename());
				InputStream is=attachment.getInputStream(); 
				int n=0;
				byte[] b=new byte[1024];
				while((n=is.read(b))!=-1)
				{
					fo.write(b);
				}
				fo.flush();
				is.close();
				fo.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			Attachment ath=new Attachment();
			User user=(User) request.getSession().getAttribute("user");
		    Calendar now=Calendar.getInstance();
		    ath.setAttachmentName(attachment.getOriginalFilename());
		    ath.setAttachmentSize(ByteSwitchUtil.getPrintSize(attachment.getSize()));
		    ath.setUploadDate(new Time(now.getTimeInMillis()));
		    ath.setUploadUser(user.getUserId());
		    attachmentDao.addAttachment(ath);
			
		}
		
		//附件上传成功，并同步数据到数据库成功,最后完成页面回发
		String res=to_attach_op(pageIndex,flag,model);
		
		return res;
	}
	
	//下载附件
	@RequestMapping("/attachment_download")
	public void attachment_download(@RequestParam("attachmentName") String attachmentName,HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		//path_download为PC机默认downloads文件夹路径,path_from为需要下载的文件在服务器下的路径
		String path_from=request.getSession().getServletContext().getRealPath("/attachment")+"/"+attachmentName;
		//获取计算机用户名
		Map<String, String> map = System.getenv();
		// 获取用户名
		String userName = map.get("USERNAME");
	    //形如 "C:\Users\andy.li\Downloads";
		String path_download="C:\\Users\\"+userName+"\\Downloads"+"\\"+attachmentName;
	
		response.setContentType("text/html;charset=utf-8");    
		File f=new File(path_from);
		if(f.exists())
		{
		try {
			FileOutputStream fo=new FileOutputStream(path_download);
			FileInputStream is=new FileInputStream(path_from);
			int n=0;
			byte[] b=new byte[1024];
			while((n=is.read(b))!=-1)
			{
				fo.write(b);
			}
			fo.flush();
			is.close();
			fo.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		 response.getWriter().print("下载成功!");
		}else
		{
			response.getWriter().print("服务器下该文件已失效或已不存在!");
		}
		
	}
	
	
	//模糊分页查询附件
	@RequestMapping("/attachment_query")
	public String attachment_query(@RequestParam("QueryName") String QueryName,@RequestParam("pageIndex")int pageIndex,@RequestParam("flag")String flag,Model model)
	{
		 int rowCount=attachmentDao.getRowcountByCondition(QueryName);
	   	 int pageCount=(rowCount-1)/10+1;
	   	 PageData pd=GetPageIndex.getData(pageIndex, 10);
	   	 pd.setQueryName(QueryName);
	   	 
	   	 List<AttachmentInfo> result=attachmentDao.queryAttachmentByPage(pd);
	   	
	   	 model.addAttribute("result", result);
	   	 model.addAttribute("pageIndex", pageIndex);
	   	 model.addAttribute("rowCount", rowCount);
	   	 model.addAttribute("pageCount", pageCount);
	   	 if(!QueryName.equals(""))
	   	 model.addAttribute("QueryName", QueryName);
	     model.addAttribute("flag", flag);

	   	if(flag.equals("detail"))
		return "attachment_detail";
		else
		return "attachment_manage";
		
	}
	
	//删除附件
	@RequestMapping("/attachment_delete")
	@Transactional
	public String deleteAttachment(@RequestParam("checkedAttachment")String[] checkedAttachment,@RequestParam("pageIndex")int pageIndex,@RequestParam("flag")String flag,Model model,HttpServletRequest request)
	{
		
		if(checkedAttachment.length==2)
		{
			if(checkedAttachment[0].indexOf(",")==-1)
			{
				//只选择了一个删除项
				attachmentDao.deleteAttachment(Integer.parseInt(checkedAttachment[0]));
				 String path=request.getSession().getServletContext().getRealPath("/attachment")+"/"+checkedAttachment[1];
				 File f=new File(path);
				 f.delete();
				
			}else
			{
				//选择了多个删除项
				String[] temp=null;
				for(int i=0;i<checkedAttachment.length;i++)
				{
					temp=checkedAttachment[i].split(",");
					//清除数据库记录
					attachmentDao.deleteAttachment(Integer.parseInt(temp[0]));
					//清除服务器下该文件
				    String path=request.getSession().getServletContext().getRealPath("/attachment")+"/"+temp[1];
				    File f=new File(path);
				    f.delete();
				}
			}
		}else
		{
			//选择了多个删除项
			String[] temp=null;
			for(int i=0;i<checkedAttachment.length;i++)
			{
				temp=checkedAttachment[i].split(",");
				//清除数据库记录
				attachmentDao.deleteAttachment(Integer.parseInt(temp[0]));
				//清除服务器下该文件
			    String path=request.getSession().getServletContext().getRealPath("/attachment")+"/"+temp[1];
			    File f=new File(path);
			    f.delete();
			}
		}
		
	    //删除附件成功,最后完成页面回发
	    String res=to_attach_op(pageIndex,flag,model);
	  		
	    return res;
		
	}
	
}
