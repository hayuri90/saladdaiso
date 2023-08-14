package com.proj.salad.review.vo;

import java.util.Date;

public class Review_imageVO {
	private int re_imgNO;						//이미지파일 번호(기본키)
	private int re_articleNO;					//리뷰게시판 게시물 번호(참조키)
	private String userId;						//작성자(참조키)
	private String re_storedFileName;		//저장된 이미지파일 이름
	private String re_originalFileName;	//원래 이미지파일 이름
	private int re_fileSize;						//이미지파일 크기
	private Date re_imageDate;				//이미지파일 등록일자
	
	//getter, setter
	public int getRe_imgNO() {
		return re_imgNO;
	}
	public void setRe_imgNO(int re_imgNO) {
		this.re_imgNO = re_imgNO;
	}
	public int getRe_articleNO() {
		return re_articleNO;
	}
	public void setRe_articleNO(int re_articleNO) {
		this.re_articleNO = re_articleNO;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRe_storedFileName() {
		return re_storedFileName;
	}
	public void setRe_storedFileName(String re_storedFileName) {
		this.re_storedFileName = re_storedFileName;
	}
	public String getRe_originalFileName() {
		return re_originalFileName;
	}
	public void setRe_originalFileName(String re_originalFileName) {
		this.re_originalFileName = re_originalFileName;
	}
	public int getRe_fileSize() {
		return re_fileSize;
	}
	public void setRe_fileSize(int re_fileSize) {
		this.re_fileSize = re_fileSize;
	}
	public Date getRe_imageDate() {
		return re_imageDate;
	}
	public void setRe_imageDate(Date re_imageDate) {
		this.re_imageDate = re_imageDate;
	}
	
	//toString
	@Override
	public String toString() {
		return "Review_imageVO [re_imgNO=" + re_imgNO + ", re_articleNO=" + re_articleNO + ", userId=" + userId
				+ ", re_storedFileName=" + re_storedFileName + ", re_originalFileName=" + re_originalFileName
				+ ", re_fileSize=" + re_fileSize + ", re_imageDate=" + re_imageDate + "]";
	}	
}
