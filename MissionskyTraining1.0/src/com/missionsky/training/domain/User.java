package com.missionsky.training.domain;

import java.io.Serializable;

public class User implements Serializable{

	private int userId;
	private String userName;
	private String password;
	private int admin_flag;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAdmin_flag() {
		return admin_flag;
	}
	public void setAdmin_flag(int adminFlag) {
		admin_flag = adminFlag;
	}
	public User() {
		super();
	}
	public User(int userId, String userName, String password, int adminFlag) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.password = password;
		admin_flag = adminFlag;
	}

	
}
