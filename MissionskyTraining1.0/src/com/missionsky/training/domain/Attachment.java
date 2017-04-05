package com.missionsky.training.domain;

import java.io.Serializable;
import java.util.Date;

public class Attachment implements Serializable{
	
	private int attachmentId;
	private String attachmentName;
	private String attachmentSize;
	private java.util.Date uploadDate;
	private int uploadUser;
	private int articleId;
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
	public int getUploadUser() {
		return uploadUser;
	}
	public void setUploadUser(int uploadUser) {
		this.uploadUser = uploadUser;
	}
	public int getArticleId() {
		return articleId;
	}
	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}
	public Attachment() {
		super();
	}
	public Attachment(int attachmentId, String attachmentName,
			String attachmentSize, Date uploadDate, int uploadUser,
			int articleId) {
		super();
		this.attachmentId = attachmentId;
		this.attachmentName = attachmentName;
		this.attachmentSize = attachmentSize;
		this.uploadDate = uploadDate;
		this.uploadUser = uploadUser;
		this.articleId = articleId;
	}
	

}
