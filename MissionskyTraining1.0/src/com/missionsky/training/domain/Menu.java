package com.missionsky.training.domain;

import java.io.Serializable;

public class Menu implements Serializable{
	
	private int menuId;
	private int parentId;
	private String menuName;
	private String menuImg;
	private String url;
	public int getmenuId() {
		return menuId;
	}
	public void setmenuId(int menuId) {
		this.menuId = menuId;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getmenuName() {
		return menuName;
	}
	public void setmenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getmenuImg() {
		return menuImg;
	}
	public void setmenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Menu() {
		super();
	}
	public Menu(int menuId, int parentId, String menuName, String menuImg,
			String url) {
		super();
		this.menuId = menuId;
		this.parentId = parentId;
		this.menuName = menuName;
		this.menuImg = menuImg;
		this.url = url;
	}

}
