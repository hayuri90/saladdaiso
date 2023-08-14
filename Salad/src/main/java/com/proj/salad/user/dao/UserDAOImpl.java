package com.proj.salad.user.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.proj.salad.user.vo.UserVO;

/* 서승희 userDAO */
@Repository("userDAO")
public class UserDAOImpl  implements UserDAO{
	
	@Autowired   //의존성주입
	private SqlSession sql;	

	 //로그인
	@Override
	public UserVO login(Map loginMap) throws DataAccessException { 
		UserVO user=(UserVO)sql.selectOne("mapper.user.login",loginMap);
		return user;
	}

	 //회원가입
	@Override
	public void insertNewUser(UserVO userVO) throws DataAccessException { 
		sql.insert("mapper.user.insertNewUser",userVO);
	}

	 //ID 중복검사
	@Override
	public String selectOverlappedID(String userId) throws DataAccessException { 
		String result =  sql.selectOne("mapper.user.selectOverlappedID",userId);
		return result;
	}

}
