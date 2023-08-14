package com.proj.salad.user.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.proj.salad.user.dao.UserDAO;
import com.proj.salad.user.vo.UserVO;

/* 서승희 userService */
@Service("userService")
//propagation : 트랜잭션 전파 규칙 설정, REQUIRED : propagation 속성에 관련된 값, 트랜잭션 없으면 새로운 트랜잭션 생성(디폴트 값)
@Transactional(propagation=Propagation.REQUIRED)  //@Transactional을 이용해 UserService 클래스의 모든 메서드에 트랜잭션을 적용
public class UserServiceImpl  implements UserService{
	
	@Autowired //의존성주입
	private UserDAO userDAO;

	 //로그인
	@Override
	public UserVO login(Map loginMap) throws Exception { 
		return userDAO.login(loginMap);
	}

	 //회원가입
	@Override
	public void addUser(UserVO userVO) throws Exception { 
		userDAO.insertNewUser(userVO);
	}

	 //ID 중복검사
	@Override
	public String overlapped(String userId) throws Exception { 
		return userDAO.selectOverlappedID(userId);
	}

}
