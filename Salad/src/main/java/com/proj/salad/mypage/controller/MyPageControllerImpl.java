package com.proj.salad.mypage.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.salad.order.vo.OrderVO;
import com.proj.salad.mypage.service.MyPageService;
import com.proj.salad.mypage.vo.MyPageVO;
import com.proj.salad.user.vo.UserVO;


@Controller("myPageController")
public class MyPageControllerImpl implements MyPageController {

	@Autowired  //의존성주입
	MyPageService myPageService;
	@Autowired //의존성주입
	UserVO userVO;

	//회원정보상세
	@Override
	@RequestMapping(value="/mypage/myDetailInfo.do",method=RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		
		ModelAndView mav = new ModelAndView(viewName);
		//mav.setViewName(viewName);
		System.out.println(viewName);
		return mav;
	}

	//회원정보수정
	//attribute는 수정할 회원 정보 속성을 저장하고 value는 회원 정보의 속성 값을 저장
	@Override
	@RequestMapping(value="/mypage/modifyMyInfo.do",method=RequestMethod.POST)
	public ResponseEntity modifyMyInfo(@RequestParam("attribute")  String attribute,
            																@RequestParam("value")  String value, 
            																HttpServletRequest request,
            																HttpServletResponse response) throws Exception {
		
		Map<String, String> userMap = new HashMap<String, String>();
		String val[]=null; //배열 초기화
		
		HttpSession session = request.getSession();  //세션 사용
		userVO = (UserVO)session.getAttribute("user");
		String userId = userVO.getUserId();
		
		if(attribute.equals("email")) {
			val=value.split(",");  //split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
			userMap.put("userEmail", val[0]);
			userMap.put("emailsts_yn", val[1]);
		}else if(attribute.equals("phone")) {
			val=value.split(",");  // ','를 기준으로 문자열을 자른다.
			userMap.put("userPhone", val[0]);
			userMap.put("smssts_yn", val[1]);
		}else if(attribute.equals("address")) {
			val=value.split(",");
			userMap.put("userAddress1", val[0]);
			userMap.put("userAddress2", val[1]);
		}else {
			userMap.put(attribute, value);
		}
		
		userMap.put("userId", userId);
		
		//수정된 회원정보를 다시 세션에 저장한다.
		userVO = (UserVO) myPageService.modifyMyInfo(userMap);
		session.removeAttribute("user");
		session.setAttribute("user", userVO);
		
		System.out.println("userMap:"+userMap);
		System.out.println("userVO:"+userVO);
		
		String message = null;  //변수 초기화
		ResponseEntity resEntity = null;  //변수 초기화
		HttpHeaders responseHeaders = new HttpHeaders();
		message = "mod_success";  //정보 수정 되었을 때 나올 메세지
		//message 변수에는 클라이언트로 다시 전송될 응답으로 다시 보내려는 메시지 또는 데이터이며 HttpStatus.OK는 HttpStatus의 Http 상태 코드를 나타내는 클래스이다.
		resEntity = new ResponseEntity(message,responseHeaders,HttpStatus.OK); 
		
		return resEntity;
	}
	
	//회원정보탈퇴
	//23.07.31  회원정보 및 회원내역 전체 삭제 되게 수정
   @RequestMapping(value="/mypage/removeUser.do", method=RequestMethod.GET)
	public ModelAndView removeUser(HttpServletRequest request, HttpServletResponse response)
																		throws Exception {
	   
	   ModelAndView mav = new ModelAndView();
	   
	   HttpSession session = request.getSession();  //세션 사용
		userVO = (UserVO)session.getAttribute("user");
		
		String userId = userVO.getUserId();
		
		try {
			int result=myPageService.removeUser(userId); 
			
			if(result == 1) {
				mav.setViewName("redirect:/user/logout.do");   //로그아웃 하여 메인페이지로 감
			}
		}catch(Exception e) {
				mav.addObject("msg", e.getMessage());  //탈퇴 시 확인 메세지
		}
	   
	   return mav;
	}

	//마이페이지 메인
	@Override
	@ResponseBody 
	@RequestMapping(value="/mypage/myPageMain.do",method=RequestMethod.GET)
	public ModelAndView myPageMain(@RequestParam(required = false,value="message") String message, 
																		@RequestParam Map<String, String> dateMap,
																			HttpServletRequest request, HttpServletResponse response)
																			throws Exception {
		
		HttpSession session=request.getSession();  //세션사용
		session=request.getSession();
		session.setAttribute("side_menu", "my_page"); //마이페이지 사이드 메뉴로 설정한다.
		
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println(viewName);
		
		userVO=(UserVO)session.getAttribute("user");
		String userId=userVO.getUserId();
		System.out.println("userId:"+userId);
		
		//message에 model 값 넘기기
		mav.addObject("message", message);
		System.out.println("message:"+message);
		
		//userVO에 model 값 넘기기
		mav.addObject("userVO", userVO);
		System.out.println("userVO:"+ userVO);
	
		//주문검색 년월일 조회(자바스크립트 코드)
		  String fixedSearchPeriod = dateMap.get("fixedSearchPeriod"); 
		  String beginDate=null,endDate=null;
	  
		  String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		  beginDate=tempDate[0]; 
		  endDate=tempDate[1]; 
		  dateMap.put("beginDate",beginDate); 
		  dateMap.put("endDate", endDate); 
		  dateMap.put("userId", userId);
	  
		 //제품주문리스트 myOrderHistList에 결과값 저장
		  List<MyPageVO> myOrderHistList=myPageService.listMyOrderHistory(dateMap);
		  
		  String beginDate1[]=beginDate.split("-"); //검색일자를 년,월,일로 분리해서 화면에 전달합니다.
		  String endDate1[]=endDate.split("-");
		  mav.addObject("beginYear",beginDate1[0]);
		  mav.addObject("beginMonth",beginDate1[1]);
		  mav.addObject("beginDay",beginDate1[2]);
		  mav.addObject("endYear",endDate1[0]); 
		  mav.addObject("endMonth",endDate1[1]);
		  mav.addObject("endDay",endDate1[2]); 
	  	  mav.addObject("myOrderHistList",myOrderHistList); 
	  	  
		return mav;
	}
		  
	//주문검색 년월일 계산코드
	protected String calcSearchPeriod(String fixedSearchPeriod){ 
		String beginDate=null; 
		String endDate=null; 
		String endYear=null; 
		String endMonth=null; 
		String endDay=null; 
		String beginYear=null; 
		String beginMonth=null; 
		String beginDay=null; 
			  
		DecimalFormat df = new DecimalFormat("00"); 
			  
		Calendar cal=Calendar.getInstance();
		  
		endYear = Integer.toString(cal.get(Calendar.YEAR)); 
		endMonth =df.format(cal.get(Calendar.MONTH) + 1); 
		endDay =df.format(cal.get(Calendar.DATE)); 
		endDate = endYear +"-"+ endMonth+"-"+endDay;
		  
		  if(fixedSearchPeriod == null) { 
			  cal.add(cal.MONTH,-4); 
		  }else if(fixedSearchPeriod.equals("three_day")) { 
			  cal.add(Calendar.DAY_OF_YEAR, -3);
		  }else if(fixedSearchPeriod.equals("one_week")) {
			  cal.add(Calendar.DAY_OF_YEAR, -7); 
		  }else if(fixedSearchPeriod.equals("one_month")) { 
			  cal.add(cal.MONTH,-1); 
		  }else if(fixedSearchPeriod.equals("three_month")) { 
			  cal.add(cal.MONTH,-3); 
		  }else if(fixedSearchPeriod.equals("six_month")) { 
			  cal.add(cal.MONTH,-6); 
		} 
		  beginYear = Integer.toString(cal.get(Calendar.YEAR)); 
		  beginMonth =df.format(cal.get(Calendar.MONTH) + 1); 
		  beginDay =df.format(cal.get(Calendar.DATE)); 
		  beginDate = beginYear +"-"+ beginMonth+"-"+beginDay;
		  
		  return beginDate+","+endDate;
		 
	}

	//주문취소
	@Override
	@RequestMapping(value="/mypage/cancelMyOrder.do" ,method = RequestMethod.POST)
	public ModelAndView cancelMyOrder(@RequestParam("orderNum") int orderNum, 
																				HttpServletRequest request, HttpServletResponse response)
																				throws Exception {

		String viewName = getViewName(request);
		
		ModelAndView mav = new ModelAndView(viewName);
		
		myPageService.cancelOrder(orderNum);
		mav.addObject("message", "cancel_order");
		mav.setViewName("redirect:/mypage/myPageMain.do");
		
		return mav;
		
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
