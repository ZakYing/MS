package com.missionsky.training.domain;

import java.io.Serializable;
import java.util.Date;

public class Article implements Serializable{
	
	private int articleId;
	private String subject;
	private String contentFileName;
	private java.util.Date publishDate;
	private int publishUser;
	private int courseId;
	public int getArticleId() {
		return articleId;
	}
	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContentFileName() {
		return contentFileName;
	}
	public void setContentFileName(String contentFileName) {
		this.contentFileName = contentFileName;
	}
	public java.util.Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(java.util.Date publishDate) {
		this.publishDate = publishDate;
	}
	public int getPublishUser() {
		return publishUser;
	}
	public void setPublishUser(int publishUser) {
		this.publishUser = publishUser;
	}
	public int getCourseId() {
		return courseId;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	public Article() {
		super();
	}
	public Article(int articleId, String subject, String contentFileName,
			Date publishDate, int publishUser, int courseId) {
		super();
		this.articleId = articleId;
		this.subject = subject;
		this.contentFileName = contentFileName;
		this.publishDate = publishDate;
		this.publishUser = publishUser;
		this.courseId = courseId;
	}

}
