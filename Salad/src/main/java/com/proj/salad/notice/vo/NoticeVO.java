package com.proj.salad.notice.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

@Component("noticeVO")
public class NoticeVO {

	private int level;
	private int articleNO;
	private int parentNO;
	private String userId;
	private String title;
	private String content;
	private Date writeDate;
	private int viewCnt;
	private List<Notice_imageVO> imageFileList;
	
	//getter, setter
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public int getParentNO() {
		return parentNO;
	}
	public void setParentNO(int parentNO) {
		this.parentNO = parentNO;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	
	public List<Notice_imageVO> getImageFileList() {
		return imageFileList;
	}
	public void setImageFileList(List<Notice_imageVO> imageFileList) {
		this.imageFileList = imageFileList;
	}
	//toString
	@Override
	public String toString() {
		return "NoticeVO [level=" + level + ", articleNO=" + articleNO + ", parentNO=" + parentNO + ", userId=" + userId
				+ ", title=" + title + ", content=" + content + ", writeDate=" + writeDate + ", viewCnt=" + viewCnt
				+ ", imageFileList=" + imageFileList + "]";
	}
	
	
	
}