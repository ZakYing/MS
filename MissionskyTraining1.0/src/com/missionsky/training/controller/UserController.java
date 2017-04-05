package com.missionsky.training.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.missionsky.training.dao.MenuDao;
import com.missionsky.training.dao.UserDao;
import com.missionsky.training.dao.UserMenuDao;
import com.missionsky.training.domain.Menu;
import com.missionsky.training.domain.User;
import com.missionsky.training.domain.UserMenu;

@Controller
public class UserController {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private UserMenuDao userMenuDao;
	
	//定向到登录页面
	@RequestMapping("/index")
	public String to_login()
	{
		return "login";
	}
	
	
    //验证登录
	@RequestMapping("/login")
	public String login(@RequestParam(value=("userName"),required=false,defaultValue="")String userName,@RequestParam(value=("password"),required=false,defaultValue="")String password,HttpServletRequest request)
	{
		if(userName.equals("")&&password.equals(""))
		{
			User user_session=(User) request.getSession().getAttribute("user");
			if(user_session==null)
				return "login";
			else
				return "index";
		}else
		{
		User user=new User();
		user.setUserName(userName);
		user.setPassword(password);
		User u=userDao.login(user);
		if(u!=null)
		{
	    List<Menu> menuList=new ArrayList<Menu>();
	    if(u.getAdmin_flag()==1)
	    {
	    menuList=menuDao.getMenuList();
	    }else
	    {
	    	//获取用户菜单列表
	    	List<UserMenu> userMenuList=userMenuDao.getUserMenuList();
	    	for(UserMenu um:userMenuList)
	    	{
	    		menuList.add(menuDao.getMenuById(um.getMenuId()));
	    	}
	    }
	    /*
	     * 将用户和菜单列表存到session
	     */
	    request.getSession().setAttribute("user", u);
	    request.getSession().setAttribute("menuList", menuList);
		return "index";
		}
		else
		return "login";
		}
	}
	
	//添加用户
	@RequestMapping("/addUser")
	@Transactional
	public void adUser(@RequestParam("userName")String userName,@RequestParam("password")String password,HttpServletResponse response) throws IOException
	{
		User user=new User();
		user.setUserName(userName);
		user.setPassword(password);
		userDao.addUser(user);
		
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print("添加成功!");
	}
	
	//退出登录
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request)
	{
		//销毁session
		request.getSession().invalidate();
		return "login";
	}
	
	//验证用户名是否已存在
	@RequestMapping("/validaeUser")
	public void validateUser(@RequestParam("userName")String userName,HttpServletResponse response) throws IOException
	{
		response.setContentType("text/html;charset=utf-8"); 
		User user=userDao.validateUser(userName);
		if(user!=null)
		{
			response.getWriter().print("该用户名已存在!");
		}
	}
}
