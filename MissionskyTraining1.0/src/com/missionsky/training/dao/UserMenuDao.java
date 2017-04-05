package com.missionsky.training.dao;

import java.util.List;

import com.missionsky.training.domain.UserMenu;

public interface UserMenuDao {

	/**
	 * 添加用户菜单项
	 * @param userMenu
	 */
	public void addUserMenu(UserMenu userMenu);
	/**
	 * 删除所有用户菜单记录
	 */
	public void deleteUserMenu();
	/**
	 * 获取用户菜单列表
	 * @return List<UserMenu>
	 */
	public List<UserMenu> getUserMenuList();
}
