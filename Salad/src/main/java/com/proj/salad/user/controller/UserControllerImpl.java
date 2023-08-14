package com.proj.salad.user.controller;

import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.proj.salad.user.service.CertificationService;
import com.proj.salad.user.service.UserService;
import com.proj.salad.user.vo.UserVO;

/* 서승희 userController */
@Controller("userController") // @Controller 애너테이션을 이용해 userController 클래스를 빈으로 자동변환 빈 id는 userController
public class UserControllerImpl implements UserController {

	@Autowired // 의존성주입
	private UserService userService;
	@Autowired // 의존성주입
	private UserVO userVO;

	// 로그인
	@Override
	@RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception { // @RequestParam("문자열")은 주소에 있는 특정 값을 가져옴

		ModelAndView mav = new ModelAndView();
		userVO = userService.login(loginMap); // login() 메서드의 loginMap안에 아이디와 비밀번호를 담아 호출 하면서 로그인 SQL문으로 전달

		if (userVO != null && userVO.getUserId() != null) {
			HttpSession session = request.getSession(); // 세션사용
			session = request.getSession();
			session.setAttribute("isLogOn", true); // 조회한 회원정보를 가져와 isLogOn 속성을 true로 설정하고
			session.setAttribute("user", userVO); // user 속성으로 회원정보를 저장

			String action = (String) session.getAttribute("action");

			if (action != null && action.equals("/order")) { // 제품 주문 과정에서 로그인 했으면 로그인 후 다시 주문 화면으로 진행
				// mav.setViewName("forward:"+action);
				mav.setViewName("redirect:" + action);
			} else {
				mav.setViewName("redirect:/main.do"); // action 값이 null인 경우에는 메인페이지로 표시
			}

		} else {
			String message = "아이디나  비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("result", message); // @RequestParam에서 설정한 Map 이름으로 바인딩
			mav.setViewName("redirect:/user/loginForm.do"); // 자료를 넘길 jsp 이름
		}
		return mav; // ModelAndView 객체에 설정한 뷰이름을 타일즈 뷰리졸버로 반환
	}

	// 로그아웃
	@Override
	@RequestMapping(value = "/user/logout.do", method = RequestMethod.GET) // get은 서버 → 사용자로 데이터가 이동하는 것
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession(); // 세션사용
		session.setAttribute("isLogOn", false); // 조회한 회원정보를 가져와 isLogOn 속성을 false로 설정하고
		session.removeAttribute("user"); // user 속성으로 회원정보를 지워 로그아웃 시킴
		mav.setViewName("redirect:/main.do"); // 메인페이지로 표시
		return mav;
	}

	// 회원가입
	@Override
	@RequestMapping(value = "/user/addUser.do", method = RequestMethod.POST) // post는 서버에 데이터를 보내는 데 사용
	public ResponseEntity addUser(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		System.out.println(userVO.getUserId());

		try {
			userService.addUser(userVO); // 회원 정보를 SQL문으로 전달
			message = "<script>";
			message += " alert('회원 가입을 마쳤습니다. 로그인창으로 이동합니다.');";
			message += " location.href='" + request.getContextPath() + "/user/loginForm.do';";
			message += " </script>";

		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath() + "/user/userForm.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	// ID 중복검사
	@Override
	@RequestMapping(value = "/user/overlapped.do", method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id, HttpServletRequest request,
																	HttpServletResponse response) throws Exception {
		ResponseEntity resEntity = null;
		String result = userService.overlapped(id); // ID 중복검사를 함
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}

	// 로그인 폼
	@RequestMapping(value = "/user/loginForm.do", method = RequestMethod.GET)
	private ModelAndView loginForm(@RequestParam(value = "result", required = false) String result,
																	@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
																	HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		System.out.println(viewName);
		return mav;
	}

	// 회원가입 폼
	@RequestMapping(value = "/user/userForm.do", method = RequestMethod.GET)
	private ModelAndView userForm(@RequestParam(value = "result", required = false) String result,
																	@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
																	HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	
	//문자 api 인증번호 발송
	//23.07.27 문자 api 인증 서승희 추가
	@RequestMapping(value="/sendSMS1.do")  //jsp 페이지 넘긴 mapping 값
	@ResponseBody
	public String sendSMS(String userPhone) {
			  
		Random random = new Random();  //랜덤숫자 생성하기
		String numStr = "";
		
		for(int i=0;i<4;i++) {
			String ran = Integer.toString(random.nextInt(10));
			numStr+=ran;
		}
			System.out.println("수신자번호: " + userPhone);
			System.out.println("인증번호: " + numStr);
			
			CertificationService.certifiedPhoneNumber(userPhone, numStr);  //휴대폰 api 쪽으로 가기
			
			return numStr;
		} 

	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}

}
