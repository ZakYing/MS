package com.missionsky.training.dao;

import com.missionsky.training.domain.User;

public interface UserDao {

	/**
	 * 用户登录验证
	 * @param user
	 * @return
	 */
	public User login(User user);  
    /**
     * 添加用户
     * @param user
     */
	public void addUser(User user);
	/**
	 * 验证用户名是否已存在
	 * @param userName
	 * @return
	 */
    public User validateUser(String userName);
}
