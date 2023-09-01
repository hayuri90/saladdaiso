package com.proj.salad.user.service;

import java.util.Map;

import com.proj.salad.user.vo.UserVO;

public interface UserService {

	//로그인
	public UserVO login(Map loginMap) throws Exception;  
	
	//회원가입
	public void addUser(UserVO userVO)  throws Exception; 
	
	//ID 중복검사
	public String overlapped(String userId)  throws Exception;

}