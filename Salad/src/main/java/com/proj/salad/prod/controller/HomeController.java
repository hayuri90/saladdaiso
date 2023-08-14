package com.proj.salad.prod.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.cart.service.CartServiceImpl;
import com.proj.salad.cart.vo.CartVO;
import com.proj.salad.prod.service.ProdServiceImpl;
import com.proj.salad.user.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
    @Autowired
    CartServiceImpl cartService;
    @Autowired
    ProdServiceImpl prodService;
    @Autowired
    CartVO cartVO;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = {  "/main.do" }, method = RequestMethod.GET)
	private ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		System.out.println("viewName : " + viewName);

		/* 김동혁 추가 */
		/* 메인화면 '추천식단' 부분에 상품 리스트 출력 */
		/*		List prodList = new ArrayList();
				prodList = prodService.selectProdList();*/


		ModelAndView mav = new ModelAndView();
		/*		mav.addObject("prodList", prodList);*/
		mav.setViewName(viewName);
		return mav;
	}
	
    //하유리: 이용약관 페이지(23.07.29.)
	@RequestMapping(value="/terms", method=RequestMethod.GET)
	public String terms() {
    	return "/common/terms";
    }
	
	//하유리: 개인정보 처리방침(23.07.29.)
	@RequestMapping(value="/policy", method=RequestMethod.GET)
	public String policy() {
    	return "/common/policy";
    }
	
	@RequestMapping(value = "/mainAddCart", method = RequestMethod.POST)
	@ResponseBody
	public String mainAddCart(HttpServletRequest request, HttpSession session) throws Exception {
	    System.out.println("/mainAddCart 메소드 실행");
	    String prodNum = request.getParameter("prodNum");

	    // 수정해야함!!!!
	    cartVO.setProdNum(Integer.parseInt(prodNum));
	    cartVO.setCartCount(1);

	    // 로그인 값 확인 후 String에 유저 아이디 저장하기
	    String userId = null;
	    UserVO userVO = null;

	    // 세션 형변환을 boolean이 아닌 Boolean으로 형변환
	    if((Boolean) session.getAttribute("isLogOn")) {
	        userVO = (UserVO) session.getAttribute("user");
	        userId = userVO.getUserId();
	        System.out.println("userId : " + userId);
	    } else {
	        // 로그인 상태가 아닐 경우 실패 메시지 반환
	        return "login_fail";
	    }

	    cartVO.setUserId(userId);
	    System.out.println("남아있는 userId 확인 : " + cartVO.getUserId() + ", " + userId);
	    System.out.println("cartVO 값 확인 : " + cartVO);

	    // 받은 정보(prodNum, prodCount, userId)를 장바구니 테이블에 저장
	    cartService.addCart(cartVO);

	    // 성공 메시지 반환
	    return "success";
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
			viewName = viewName.substring(viewName.lastIndexOf("/"), viewName.length());
		}
		return viewName;
	}

}
