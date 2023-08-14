package com.proj.salad.order.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.order.service.OrderServiceImpl;
import com.proj.salad.order.vo.AccountVO;
import com.proj.salad.order.vo.OrderMenuVO;
import com.proj.salad.order.vo.OrderVO;
import com.proj.salad.user.vo.UserVO;

/* Order Controller 조상현 추가 */
@Controller
public class OrderController {
	@Autowired
	OrderServiceImpl OrderService;
	@Autowired
	UserVO UserVO;
	@Autowired
	OrderMenuVO orderMenuVO;
	@Autowired
	AccountVO accountVO;

	@RequestMapping(value = { "/order" }, method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		String userId = null;

		// 세션값 가져오기
		HttpSession session = request.getSession();

		UserVO userVO = (UserVO) session.getAttribute("user");
		userId = userVO.getUserId();

		List<CartListVO> orderList = OrderService.getOrderList(userId);

		System.out.println("orderList= " + orderList);

		ModelAndView mav = new ModelAndView();
		mav.addObject("userVO", userVO);
		mav.addObject("orderList", orderList);
		mav.setViewName(viewName);

		return mav;
	}

	@RequestMapping(value = { "/payment" }, method = RequestMethod.POST)
	public ModelAndView payment(OrderVO orderVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*String viewName = getViewName(request);
		String userId = null;
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		
		UserVO userVO = (UserVO) session.getAttribute("user");
		
		List<CartListVO> orderList = OrderService.getOrderList(userId);
		
		System.out.println("orderList= " + orderList);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("userVO", userVO);
		mav.addObject("orderList", orderList);
		mav.setViewName(viewName);
		
		return mav;*/
		
		String viewName = getViewName(request);
		
		System.out.println("결제완료 페이지 출력");
		System.out.println("받아온 orderVO 객체 : " + orderVO);

		// order 카드번호 4개 받아오기
		if(request.getParameter("cardNum1") != null){
			String orderCardNum = "";
			for(int i = 1; i <= 4; i++) {
				// 카드번호 4개 한 줄로 합치기
				orderCardNum += request.getParameter("cardNum" + String.valueOf(i));
				System.out.println("카드번호 : " + orderCardNum);
			}					
			// VO 지정
			accountVO.setAccountNumber(orderCardNum);
		}
		
		// Period 카드번호 2개 받아오기
				if(request.getParameter("period1") != null){
					String period = "";
					for(int i = 1; i <= 2; i++) {
						// 유효날짜 2개 한 줄로 합치기
						period += request.getParameter("period" + String.valueOf(i));
						System.out.println("유효날짜 : " + period);
					}					
					// VO 지정
					accountVO.setAccountPeriod(period);
				}
				
				
		// cvc 저장
		System.out.println(request.getParameter("cvc"));
		accountVO.setAccountCVC(request.getParameter("cvc"));
		// 주문자이름 저장
		System.out.println(orderVO.getOrdererName());
		accountVO.setAccountName(orderVO.getOrdererName());
		

		// 세션값 가져오기
		HttpSession session = request.getSession();

		UserVO userVO = (UserVO) session.getAttribute("user");
		String userId = userVO.getUserId();
		String userEmail = userVO.getUserEmail();

		orderVO.setUserId(userId);
		orderVO.setOrdererEmail(userEmail);
		//주문번호 난수 입력
		String randomNumber = generateRandomNumber(16);
		System.out.println(randomNumber);
		orderVO.setFakeOrderNum(randomNumber);
		
		System.out.println("세션의 userId : " + orderVO);
		System.out.println(orderVO.getOrdererName());

		// 결제 테이블 insert 서비스
		OrderService.newOrder(orderVO);
		
		// 계좌정보 insert 서비스
		OrderService.newAccount(accountVO);

		// 결제하려는 제품 개수
		int prodCount = Integer.parseInt(request.getParameter("listCount"));
		System.out.println("prodCount : " + prodCount);

		// 제품 개수만큼 order_menu insert 서비스 실행
		for(int i = 0; i < prodCount; i++) {
			// 제품 이름
			String prodName = request.getParameter("CL_prodName" + String.valueOf(i));

			// 제품 개수
			String tempCartCount = request.getParameter("CL_cartCount" + String.valueOf(i));
			int cartCount = Integer.parseInt(tempCartCount);

			// 제품 가격(미사용)
			String prodPrice = request.getParameter("CL_prodPrice" + String.valueOf(i));

			// orderMenuVO에 값 저장
			//orderMenuVO.setOrderNum(orderVO.getOrderNum());
			orderMenuVO.setMenuName(prodName);
			orderMenuVO.setMenuCount(cartCount);
			orderMenuVO.setUserId(userId);

			// 주문 메뉴 insert 서비스 실행부분
			OrderService.newOrderMenu(orderMenuVO);

		}

		// 주문, 주문 메뉴 서비스 실행후 장바구니 데이터 삭제
		OrderService.deleteCartList(orderVO.getUserId());


		System.out.println("최종 orderVO 객체 : " + orderVO);
		
		// 주문날짜 가져오기
		List<OrderVO> orderTime = OrderService.orderTime();
		
		 String formattedOrderTime = null;
		for (OrderVO order : orderTime) {
		    Date orderTimestamp = order.getOrderCreateTimestamp();
		    // 날짜 형식을 원하는대로 지정합니다.
	        String pattern = "yyyy-MM-dd"; // 예시: yyyy-MM-dd HH:mm:ss = 2023-07-26 15:30:00

	        // SimpleDateFormat 객체를 생성하고, 지정한 형식으로 날짜를 문자열로 변환합니다.
	        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
	        formattedOrderTime = sdf.format(orderTimestamp);

		}
		

		
		
		// 구매자 이름 가져오기
		String userName = userVO.getUserName();

		ModelAndView mav = new ModelAndView();
		mav.addObject("randomNumber", randomNumber); // 주문번호 12자리
		mav.addObject("formattedOrderTime", formattedOrderTime); // 주문날짜
		mav.addObject("userName",userName); // 구매자
		mav.setViewName(viewName);

		return mav;
	}
	
	// 주문번호 난수 12자리 생성
    public static String generateRandomNumber(int digits) {
        StringBuilder sb = new StringBuilder(digits);
        for (int i = 0; i < digits; i++) {
            int randomDigit = ThreadLocalRandom.current().nextInt(10);
            sb.append(randomDigit);
        }
        return sb.toString();
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
