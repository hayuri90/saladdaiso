package com.proj.salad.mypage.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.mypage.service.MyPageOrderServiceImpl;
import com.proj.salad.mypage.vo.OrderInfoVO;
import com.proj.salad.mypage.vo.OrderListVO;
import com.proj.salad.order.vo.OrderMenuVO;
import com.proj.salad.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MyPageOrderController {
    @Autowired
    UserVO userVO;
    @Autowired
    MyPageOrderServiceImpl myPageOrderService;

    // 주문 내역, 배송 조회
    @RequestMapping(value = "/mypage/orderList", method = RequestMethod.GET)
    public ModelAndView orderList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        // 사이드 메뉴 세션 설정
        session.setAttribute("side_menu", "my_page"); //마이페이지 사이드 메뉴로 설정한다.

        String userName = null;
        List<OrderListVO> orderList = new ArrayList<>();

        // 로그인 상태일 경우
        if((Boolean)session.getAttribute("isLogOn") == true) {
            // 유저 아이디 가져오기
            System.out.println("로그인 상태");
            
            userVO = (UserVO) session.getAttribute("user");
            System.out.println("userVO : " + userVO);
            userName = userVO.getUserName();
            System.out.println("userName : " + userName);

            // 주문 목록 리스트 서비스 실행
            orderList = myPageOrderService.selectOrderList(userName);
            System.out.println("orderList : " + orderList);
        } else {
            // 비로그인 상태시 로그인 폼 이동
            System.out.println("비로그인 상태");
            response.sendRedirect("/user/loginForm.do");
            return null;
        }

        System.out.println("테스트 테스트");
//        System.out.println("orderList : " + orderList);

        String viewName = getViewName(request);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("orderList", orderList);
        System.out.println(viewName);
        return mav;
    }

    @RequestMapping(value = "/mypage/canceledList", method = RequestMethod.GET)
    public ModelAndView cancelList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        String userName = null;
        List<OrderListVO> canceledList = new ArrayList<>();

        if((Boolean)session.getAttribute("isLogOn") == true) {
            // 유저 아이디 가져오기
            System.out.println("로그인 상태");

            userVO = (UserVO) session.getAttribute("user");
            System.out.println("userVO : " + userVO);
            userName = userVO.getUserName();
            System.out.println("userName : " + userName);

            // 주문 목록 리스트 서비스 실행
            canceledList = myPageOrderService.selectCanceledList(userName);
            System.out.println("취소 List : " + canceledList);
        } else {
            // 비로그인 상태시 로그인 폼 이동
            System.out.println("비로그인 상태");
            response.sendRedirect("/user/loginForm.do");
            return null;
        }

        String viewName = getViewName(request);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("canceledList", canceledList);

        System.out.println(viewName);
        return mav;
    }

    @RequestMapping(value = "/mypage/orderInfo/{orderNum}", method = RequestMethod.GET)
    public ModelAndView orderInfo(@PathVariable int orderNum,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("orderNum : " + orderNum);

        OrderInfoVO orderInfoVO = new OrderInfoVO();

        List<OrderMenuVO> infoMenuList = new ArrayList<>();

        // 주문 상세 페이지 VO 서비스 실행
        orderInfoVO = myPageOrderService.selectOrderOne(orderNum);

        // 상세 페이지의 주문 메뉴 목록 서비스 실행
        infoMenuList = myPageOrderService.selectOrderMenu(orderNum);


        String viewName = getViewName(request);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("orderInfo", orderInfoVO);
        mav.addObject("infoMenuList", infoMenuList);

        System.out.println(viewName);
        return mav;
    }

    @RequestMapping(value = "mypage/cancelOrder", method = RequestMethod.POST)
    @ResponseBody
    public String cancelOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int orderNum = Integer.parseInt(request.getParameter("orderNum"));
        System.out.println("주문 상태 취소 실행 : " + orderNum);
        int success = myPageOrderService.updateOrderStatus(orderNum);
        System.out.println("성공 여부 : " + success);
        if (success > 0) {
            System.out.println("취소 성공");
            return "aaa";
        } else {
            System.out.println("취소 실패");
            return "bbb";
        }
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
