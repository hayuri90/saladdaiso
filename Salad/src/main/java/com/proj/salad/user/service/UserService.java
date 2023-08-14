package com.proj.salad.user.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.proj.salad.user.vo.UserVO;

public interface UserService {

	//로그인
	public UserVO login(Map loginMap) throws Exception;  
	 //회원가입
	public void addUser(UserVO userVO)  throws Exception; 
	 //ID 중복검사
	public String overlapped(String userId)  throws Exception;

}
