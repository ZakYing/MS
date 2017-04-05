package com.missionsky.training.domain;

import java.io.Serializable;
import java.util.Date;

public class AttachmentInfo implements Serializable{
	
	private int attachmentId;
	private String attachmentName;
	private String attachmentSize;
	private java.util.Date uploadDate;
	private User user;
	private Article article;
	public int getAttachmentId() {
		return attachmentId;
	}
	public void setAttachmentId(int attachmentId) {
		this.attachmentId = attachmentId;
	}
	public String getAttachmentName() {
		return attachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}
	public String getAttachmentSize() {
		return attachmentSize;
	}
	public void setAttachmentSize(String attachmentSize) {
		this.attachmentSize = attachmentSize;
	}
	public java.util.Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(java.util.Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Article getArticle() {
		return article;
	}
	public void setArticle(Article article) {
		this.article = article;
	}
	public AttachmentInfo() {
		super();
	}
	public AttachmentInfo(int attachmentId, String attachmentName,
			String attachmentSize, Date uploadDate, User user, Article article) {
		super();
		this.attachmentId = attachmentId;
		this.attachmentName = attachmentName;
		this.attachmentSize = attachmentSize;
		this.uploadDate = uploadDate;
		this.user = user;
		this.article = article;
	}

}
