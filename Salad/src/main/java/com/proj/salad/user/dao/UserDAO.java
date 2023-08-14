package com.proj.salad.user.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.proj.salad.user.vo.UserVO;

public interface UserDAO {
	
	//로그인
	public UserVO login(Map loginMap) throws DataAccessException;  
	//회원가입
	public void insertNewUser(UserVO userVO) throws DataAccessException; 
	//ID 중복검사
	public String selectOverlappedID(String userId) throws DataAccessException; 
}
