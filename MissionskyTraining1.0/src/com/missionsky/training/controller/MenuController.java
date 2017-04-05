package com.missionsky.training.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.missionsky.training.dao.MenuDao;
import com.missionsky.training.dao.UserMenuDao;
import com.missionsky.training.domain.Menu;
import com.missionsky.training.domain.User;
import com.missionsky.training.domain.UserMenu;


@Controller
public class MenuController {
	
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private UserMenuDao userMenuDao;
	
	@RequestMapping("/addMenu")
	@Transactional
	public void addMenu(@RequestParam("menuImg") CommonsMultipartFile menuImg,@RequestParam(value=("parentId"),required=false,defaultValue="0")int parentId,@RequestParam(value=("menuName"),required=true)String menuName,@RequestParam(value=("url"),required=false,defaultValue="")String url,HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		
		if(!menuImg.isEmpty())
		{
			 String path=request.getSession().getServletContext().getRealPath("/menuImg");
			 File file=new File(path);
			 if(!file.exists())
				 file.mkdir();
			 
			 try {
					FileOutputStream fo=new FileOutputStream(path+"/"+menuImg.getOriginalFilename());  
					InputStream is=menuImg.getInputStream(); 
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
		}
		
		Menu menu=new Menu();
		menu.setParentId(parentId);
		menu.setmenuName(menuName);
		if(!menuImg.isEmpty())
		menu.setmenuImg(menuImg.getOriginalFilename());
		else
	    menu.setmenuImg("");	
		menu.setUrl(url);
		
		menuDao.addMenu(menu);
		
		/*
		 * 更新session中的menuList
		 */ 
		List<Menu> menuList=new ArrayList<Menu>();
		User u=(User) request.getSession().getAttribute("user");
		if(u.getAdmin_flag()==1)
		{
		request.getSession().setAttribute("menuList", menuDao.getMenuList());
		}else
		{
			//获取用户菜单列表
	    	List<UserMenu> userMenuList=userMenuDao.getUserMenuList();
	    	for(UserMenu um:userMenuList)
	    	{
	    		menuList.add(menuDao.getMenuById(um.getMenuId()));
	    	}
	    	
	    request.getSession().setAttribute("menuList", menuList);
		}
		
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print("添加成功!");
		
	}

	//获取菜单列表
	@RequestMapping("/getMenuList")
	public void getMenuList(@RequestParam("flag")String flag,@RequestParam(value=("menuId"),required=false,defaultValue="0")int menuId,HttpServletResponse response) throws IOException
	{
		List<Menu> result=new ArrayList<Menu>();
		if(flag.equals("Lev12"))
		{
	     List<Menu> menuLev1List=menuDao.getMenuLev1List();
	     List<Menu> menuLev2List=null;
	     for(Menu m1:menuLev1List)
	     {
	    	     result.add(m1);
	 
		    	 menuLev2List=menuDao.getMenuListByParentId(m1.getmenuId());
		    	 for(Menu m2:menuLev2List)
		    	 {
		    		 result.add(m2);
		    	 }
	    	 
	     }
		}else if(flag.equals("Lev1"))
		{
			result=menuDao.getMenuLev1List();
		}else if(flag.equals("Lev2")||flag.equals("Lev3"))
		{
			result=menuDao.getMenuListByParentId(menuId);
		}
		
		 response.setContentType("text/html;charset=utf-8");    
		 JSONArray menuList=JSONArray.fromObject(result);
	
		 response.getWriter().print(menuList);
		
	}
	
	
	//修改菜单信息
	@RequestMapping("/updateMenu")
	@Transactional
	public void updateMenu(@RequestParam("menuImg") CommonsMultipartFile menuImg,@RequestParam(value=("menuId"),required=true)int menuId,@RequestParam(value=("menuName"),required=true)String menuName,@RequestParam(value=("url"),required=false,defaultValue="")String url,HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		if(!menuImg.isEmpty())
		{
			 String path=request.getSession().getServletContext().getRealPath("/menuImg");
			 File file=new File(path);
			 if(!file.exists())
				 file.mkdir();
			 
			 try {
					FileOutputStream fo=new FileOutputStream(path+"/"+menuImg.getOriginalFilename());  
					InputStream is=menuImg.getInputStream(); 
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
		}
		
		Menu menu=new Menu();
		menu.setmenuId(menuId);
		menu.setmenuName(menuName);
		if(!menuImg.isEmpty())
		menu.setmenuImg(menuImg.getOriginalFilename());
		menu.setUrl(url);
		
		if(!menuImg.isEmpty())
		menuDao.updateMenu(menu);
		else
		menuDao.updateMenu2(menu);
		
		/*
		 * 更新session中的menuList
		 */ 
		List<Menu> menuList=new ArrayList<Menu>();
		User u=(User) request.getSession().getAttribute("user");
		if(u.getAdmin_flag()==1)
		{
		request.getSession().setAttribute("menuList", menuDao.getMenuList());
		}else
		{
			//获取用户菜单列表
	    	List<UserMenu> userMenuList=userMenuDao.getUserMenuList();
	    	for(UserMenu um:userMenuList)
	    	{
	    		menuList.add(menuDao.getMenuById(um.getMenuId()));
	    	}
	    	
	    request.getSession().setAttribute("menuList", menuList);
		}
		
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print("修改成功!");
	}
	
    //删除菜单
	@RequestMapping("/deleteMenu")
	@Transactional
    public void deleteMenu(@RequestParam("menuId")int menuId,@RequestParam("lev")String lev,HttpServletRequest request,HttpServletResponse response) throws IOException
    {
        if(lev.equals("lev1"))
        {
        	//一级菜单,先删除其下三级菜单,再删除其下二级菜单,最后删除自身
        	List<Menu> lev2MenuList=menuDao.getMenuListByParentId(menuId);
        	for(Menu m:lev2MenuList)
        	{
        		menuDao.deleteMenu2(m.getmenuId());
        		menuDao.deleteMenu(m.getmenuId());
        	}
        	menuDao.deleteMenu(menuId);
        	
        }else if(lev.equals("lev2"))
        {
        	//二级菜单,先删除其下三级菜单，再删除自身
        	menuDao.deleteMenu2(menuId);
        	menuDao.deleteMenu(menuId);
        	
        }else if(lev.equals("lev3"))
        {
        	//三级菜单
        	menuDao.deleteMenu(menuId);
        }
        
        /*
		 * 更新session中的menuList
		 */ 
		List<Menu> menuList=new ArrayList<Menu>();
		User u=(User) request.getSession().getAttribute("user");
		if(u.getAdmin_flag()==1)
		{
		request.getSession().setAttribute("menuList", menuDao.getMenuList());
		}else
		{
			//获取用户菜单列表
	    	List<UserMenu> userMenuList=userMenuDao.getUserMenuList();
	    	for(UserMenu um:userMenuList)
	    	{
	    		menuList.add(menuDao.getMenuById(um.getMenuId()));
	    	}
	    	
	    request.getSession().setAttribute("menuList", menuList);
		}
		
    	response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print("删除成功!");
    	
    }
 
}
