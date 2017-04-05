package com.missionsky.training.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.missionsky.training.dao.UserMenuDao;
import com.missionsky.training.domain.UserMenu;

@Controller
public class UserMenuController {
	
	@Autowired
	private UserMenuDao userMenuDao;
	
	//用户授权
	@RequestMapping("/userPermit")
	@Transactional
	public void addUserMenu(@RequestParam("checkMenus")int[] checkMenus,HttpServletResponse response) throws IOException
	{
		//授权前,先清除原始除用户权限记录
		userMenuDao.deleteUserMenu();
		
		UserMenu userMenu=new UserMenu();
		for(int i=0;i<checkMenus.length;i++)
		{
			userMenu.setMenuId(checkMenus[i]);
			userMenuDao.addUserMenu(userMenu);
		}
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print("授权成功!");
	}

}
