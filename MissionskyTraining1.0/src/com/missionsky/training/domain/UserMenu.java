package com.missionsky.training.domain;

import java.io.Serializable;

public class UserMenu implements Serializable{
	
	private int userMenuId;
	private int menuId;
	public int getUserMenuId() {
		return userMenuId;
	}
	public void setUserMenuId(int userMenuId) {
		this.userMenuId = userMenuId;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public UserMenu() {
		super();
	}
	public UserMenu(int userMenuId, int menuId) {
		super();
		this.userMenuId = userMenuId;
		this.menuId = menuId;
	}

}
