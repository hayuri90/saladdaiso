package com.proj.salad.notice.vo;

import java.util.Date;

public class Notice_imageVO {
	private int nt_imgNO;					//이미지파일 번호(기본키)
	private int articleNO;					//공지게시판 게시물 번호(참조키)
	private String userId;					//작성자(참조키)
	private String storedFileName;		//저장된 이미지파일 이름
	private String originalFileName;	//원래 이미지파일 이름
	private int fileSize;						//이미지파일 크기
	private Date imageDate;				//이미지파일 등록일자
	
	//getter, setter
	public int getNt_imgNO() {
		return nt_imgNO;
	}
	public void setNt_imgNO(int nt_imgNO) {
		this.nt_imgNO = nt_imgNO;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getStoredFileName() {
		return storedFileName;
	}
	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public Date getImageDate() {
		return imageDate;
	}
	public void setImageDate(Date imageDate) {
		this.imageDate = imageDate;
	}
	
	//toString
	@Override
	public String toString() {
		return "Notice_imageVO [nt_imgNO=" + nt_imgNO + ", articleNO=" + articleNO + ", userId=" + userId
				+ ", storedFileName=" + storedFileName + ", originalFileName=" + originalFileName + ", fileSize="
				+ fileSize + ", imageDate=" + imageDate + "]";
	}	
	
}