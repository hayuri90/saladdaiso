package com.proj.salad.user.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

/*CREATE TABLE shop_user (
		userId			varchar2(20)		NOT NULL  PRIMARY KEY, --유저아이디(기본키)
		userPwd			varchar2(200)		NOT NULL,   --유저비밀번호
		userName		varchar2(50)		NOT NULL, --유저이름
		userBirth		varchar2(20)		NOT NULL, --유저탄생일
		userGender	varchar2(20)		NOT NULL, --유저성별
		userEmail		varchar2(50)		NOT NULL, --유저이메일 
		userPhone		varchar2(20)		NOT NULL,  --유저연락처
		userAddress1		varchar2(200)		NOT NULL,  --유저기본주소	
		userAddress2	varchar2(200)		NULL  --유저상세주소
	); */
	
/*서승희 userVO*/
@Data
@Component("userVO")
public class UserVO {
	private String userId;
	private String userPwd;
	private String userName;
	private String userBirth;
	private String userGender;
	private String userEmail;
	private String userPhone;
	private String userAddress1;
	private String userAddress2;
	private String smssts_yn;        //SMS 수신동의 여부(23.07.20 추가)
	private String emailsts_yn;    //Email 수신동의 여부(23.07.20 추가)
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserAddress1() {
		return userAddress1;
	}
	public void setUserAddress1(String userAddress1) {
		this.userAddress1 = userAddress1;
	}
	public String getUserAddress2() {
		return userAddress2;
	}
	public void setUserAddress2(String userAddress2) {
		this.userAddress2 = userAddress2;
	}
	public String getSmssts_yn() {
		return smssts_yn;
	}
	public void setSmssts_yn(String smssts_yn) {
		this.smssts_yn = smssts_yn;
	}
	public String getEmailsts_yn() {
		return emailsts_yn;
	}
	public void setEmailsts_yn(String emailsts_yn) {
		this.emailsts_yn = emailsts_yn;
	}
	
	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userBirth="
				+ userBirth + ", userGender=" + userGender + ", userEmail=" + userEmail + ", userPhone=" + userPhone
				+ ", userAddress1=" + userAddress1 + ", userAddress2=" + userAddress2 + ", smssts_yn=" + smssts_yn
				+ ", emailsts_yn=" + emailsts_yn + "]";
	}

}
