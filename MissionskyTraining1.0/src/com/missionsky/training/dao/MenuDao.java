package com.missionsky.training.dao;

import java.util.List;

import com.missionsky.training.domain.Menu;

public interface MenuDao {
	
	/**
	 * 添加菜单
	 * @param menu
	 */
	public void addMenu(Menu menu);
	
	/**
	 * 获取所有菜单
	 * @return List<Menu>
	 */
	public List<Menu> getMenuList();
	
	/**
	 * 获取所有1级菜单
	 * @return List<Menu>
	 */
	public List<Menu> getMenuLev1List();
	
	/**
	 * 根据父Id获取关联的子菜单列表
	 * @return List<Menu>
	 */
	public List<Menu> getMenuListByParentId(int menuId);
	
	/**
	 * 修改菜单信息
	 * @param menu
	 */
	public void updateMenu(Menu menu);
	public void updateMenu2(Menu menu);
	
	/**
	 * 删除菜单
	 * @param MenuId
	 */
	public void deleteMenu(int menuId);
	public void deleteMenu2(int menuId);
	
	/**
	 * 根据menuId获取menu
	 * @param menuId
	 * @return
	 */
	public Menu getMenuById(int menuId);

}
