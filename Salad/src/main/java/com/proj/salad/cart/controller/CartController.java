package com.proj.salad.cart.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.cart.service.CartServiceImpl;
import com.proj.salad.cart.vo.CartListVO;
import com.proj.salad.cart.vo.CartVO;
import com.proj.salad.prod.service.ProdServiceImpl;
import com.proj.salad.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    CartServiceImpl cartService;
    @Autowired
    ProdServiceImpl prodService;
    @Autowired
    CartVO cartVO;

    @RequestMapping(value = "/addCart", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String addCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("/addCart 메소드 실행");
        System.out.println(request.getParameter("prodNum"));
        System.out.println(request.getParameter("cartCount"));

        // 수정해야함!!!!
        cartVO.setProdNum(Integer.parseInt(request.getParameter("prodNum")));
        cartVO.setCartCount(Integer.parseInt(request.getParameter("cartCount")));

        // 로그인 값 확인 후 String에 유저 아이디 저장하기
        String userId = null;
        UserVO userVO = null;
        HttpSession session = request.getSession();

        // 세션 형변환을 boolean이 아닌 Boolean으로 형변환
        if((Boolean) session.getAttribute("isLogOn")) {
            userVO = (UserVO) session.getAttribute("user");
            userId = userVO.getUserId();
            System.out.println("userId : " + userId);
        } else {
            System.out.println("비로그인 상태");
        }

        cartVO.setUserId(userId);
        System.out.println("남아있는 userId 확인 : " + cartVO.getUserId() + ", " + userId);
        System.out.println("cartVO 값 확인 : " + cartVO);


        // 받은 정보(prodNum, prodCount, userId)를 장바구니 테이블에 저장
        cartService.addCart(cartVO);

        // JSON 으로 리턴값 보내기
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonData = objectMapper.writeValueAsString("");

        return jsonData;
    }

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public ModelAndView cartList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = getViewName(request);
        String userId = null;

        // 세션값 가져오기
        HttpSession session = request.getSession();

        // 로그인 되어있을 경우
        if((Boolean)session.getAttribute("isLogOn")) {
            // 세션에서 로그인 정보 가져오기
            UserVO userVO = (UserVO) session.getAttribute("user");
            userId = userVO.getUserId();

        } else {
            // 로그인 안됐을시 로그인폼(login.jsp)으로 리다이렉트
            response.sendRedirect("/user/loginForm");
            return null; // 리턴값이 필요 없으므로 null 반환
        }

        // 제품 테이블, 장바구니 테이블 조인 결과값 리스트 저장
        List<CartListVO> cartList = cartService.cartById(userId);

        // 결과값 확인
        System.out.println("cartList : " + cartList);

        ModelAndView mav = new ModelAndView();
        // cartList 리스트 model값 넘기기
        mav.addObject("cartList", cartList);
        mav.setViewName(viewName);

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
            viewName = viewName.substring(viewName.lastIndexOf("/"), viewName.length());
        }
        return viewName;
    }

    @RequestMapping(value = "/delCart", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public String delCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // Ajax로 전송받은 데이터 int 형변환 대입
        int cartNum = Integer.parseInt(request.getParameter("cartNum"));
        System.out.println("삭제할 cartNum : " + cartNum);

        // 넘겨받은 cartNum으로 장바구니 한 행 삭제
        cartService.delCart(cartNum);

        // JSON 으로 리턴값 보내기
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonData = objectMapper.writeValueAsString("");

        return jsonData;
    }

    @RequestMapping(value = "/updateCart", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public String updateCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // Ajax로 전송받은 데이터 int 형변환 대입
        int cartNum = Integer.parseInt(request.getParameter("cartNum"));
        int cartCount = Integer.parseInt(request.getParameter("cartCount"));
        cartVO.setCartNum(cartNum);
        cartVO.setCartCount(cartCount);

        // 넘겨받은 cartNum, cartCount로 기존 장바구니 데이터 수정
        cartService.updateCart(cartVO);

        // JSON 으로 리턴값 보내기
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonData = objectMapper.writeValueAsString("");

        return jsonData;
    }

}
