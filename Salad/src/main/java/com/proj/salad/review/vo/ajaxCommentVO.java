package com.proj.salad.review.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("ajaxCommentVO")
public class ajaxCommentVO {

	private int level;
	private int re_articleNO;
	private int ac_commentNO;
	private int ac_parentNO;
	private String userId;
	private String ac_content;


	private Date ac_writeDate;
	
	
	public int getRe_articleNO() {
		return re_articleNO;
	}
	public void setRe_articleNO(int re_articleNO) {
		this.re_articleNO = re_articleNO;
	}
	public int getAc_commentNO() {
		return ac_commentNO;
	}
	public void setAc_commentNO(int ac_commentNO) {
		this.ac_commentNO = ac_commentNO;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAc_content() {
		return ac_content;
	}
	public void setAc_content(String ac_content) {
		this.ac_content = ac_content;
	}
	public Date getAc_writeDate() {
		return ac_writeDate;
	}
	public void setAc_writeDate(Date ac_writeDate) {
		this.ac_writeDate = ac_writeDate;
	}

	public int getAc_parentNO() {
		return ac_parentNO;
	}

	public void setAc_parentNO(int ac_parentNO) {
		this.ac_parentNO = ac_parentNO;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "ajaxCommentVO{" +
				"level=" + level +
				", re_articleNO=" + re_articleNO +
				", ac_commentNO=" + ac_commentNO +
				", ac_parentNO=" + ac_parentNO +
				", userId='" + userId + '\'' +
				", ac_content='" + ac_content + '\'' +
				", ac_writeDate=" + ac_writeDate +
				'}';
	}

}
