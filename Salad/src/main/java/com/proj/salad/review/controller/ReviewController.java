package com.proj.salad.review.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.proj.salad.mypage.service.MyPageOrderServiceImpl;
import com.proj.salad.mypage.vo.OrderInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.review.service.ReviewService;
import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.PageVO;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.ajaxCommentVO;
import com.proj.salad.user.vo.UserVO;


@Controller
@RequestMapping("/review")
public class ReviewController extends HttpServlet {
		
	@Autowired
	private ReviewService reviewService;

	@Autowired
	private MyPageOrderServiceImpl myPageOrderService;

	@Autowired
	private HttpSession session;

	@Autowired
	private ajaxCommentVO ajaxCommentVO;

	//하유리: 1. 리뷰게시판 전체리스트 보기(23.07.16.)
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String selectAllReviewList(Model model, HttpServletRequest request, HttpServletResponse response, Criteria criteria) throws Exception {
		List<ReviewVO> list = reviewService.selectAllReviewList(criteria);
		model.addAttribute("reviewList", list);
		
		PageVO paging = new PageVO();
		paging.setCriteria(criteria);
		paging.setTotalPost(reviewService.getTotal());
		model.addAttribute("pageMaker", paging);
		model.addAttribute("select", criteria.getCurPage());
		return "/review/list";
	}
	
	//하유리: 2-1. 리뷰게시판 글쓰기(23.07.16.)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public ModelAndView insertFormWithON(@RequestParam("orderNum") int orderNum,
								   HttpServletRequest request) throws Exception {
		String userName = null;

		// 주소값으로부터 orderNum 받아오기
		/*orderNum = Integer.parseInt(request.getParameter("orderNum"));*/

		Integer checkNull = orderNum;
		OrderInfoVO orderInfoVO = null;

		// orderNum으로 주문 내역 조회
		if(checkNull != null) {
			orderInfoVO = myPageOrderService.selectOrderOne(orderNum);
			System.out.println("받은 orderNum : " + orderNum);
			System.out.println("나온 orderInfo 결과값 : " + orderInfoVO.getFakeOrderNum());
		}
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);
		if(checkNull != null) {
			mav.addObject("orderInfo", orderInfoVO);
		}
		return mav;
	}
	
	//하유리: 2-2. 리뷰게시판 글쓰기(23.07.16.)
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
    public ModelAndView insertReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
        // 화면에서 전송한 모든 데이터가 HttpServletRequest에 저장됨
//		System.out.println("parameter : " + request.getParameter("re_title"));
//		System.out.println("파일정보: " + mRequest.getPathInfo());
//		System.out.println("reviewVO: " + reviewVO);

        // 세션 반환(23.07.18.)
        HttpSession session = request.getSession();

        // 파일 업로드(23.07.20.)
    	reviewService.insertReview(reviewVO, request, mRequest);    				//글 작성
		reviewService.updateReviewStatus(reviewVO);
    	ModelAndView mav = new ModelAndView("redirect:/review/list");		//페이지 이동
    	return mav;
    }

	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	@RequestMapping(value="/content", method=RequestMethod.GET)
	public String detailReview(@RequestParam("re_articleNO") Integer re_articleNO, Model model, HttpSession session) {
		//조회수
		reviewService.updateCnt(re_articleNO, session);
		
		// 이미지 관련 정보 가져오기(23.07.23.)
		List<Review_imageVO> imageVO = reviewService.detailImg(re_articleNO);
		System.out.println("이미지 관련 정보 :" + imageVO);
				
		ReviewVO review = reviewService.detailReview(re_articleNO);


		//조상현:  세션이용(23.07.31)
		session.removeAttribute("re_articleNO");
		session.setAttribute("re_articleNO", re_articleNO);

		UserVO userVO = (UserVO) session.getAttribute("user");

		review.setRe_imageFileList(imageVO);
		model.addAttribute("review", review);
		model.addAttribute("userVO",userVO);

		return "/review/reviewContent";
	}
	
	//조상현:  대댓글 추가(23.08.01)
	@RequestMapping(value="/addComment" , method=RequestMethod.POST, produces ="application/text; charset=UTF-8")
	@ResponseBody
	 public String addComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 	ajaxCommentVO ajaxCommentVO = new ajaxCommentVO();
		 	int re_articleNO = (int)session.getAttribute("re_articleNO");
		 	ajaxCommentVO.setAc_content(request.getParameter("ac_content"));
		 	ajaxCommentVO.setUserId(request.getParameter("userId"));
		 	ajaxCommentVO.setRe_articleNO(re_articleNO);

		 	reviewService.ajaxCommentInsert(ajaxCommentVO);

		 	// 저장된 댓글을 다시 조회하여 반환
	        List<ajaxCommentVO> ac = reviewService.ajaxComment(re_articleNO);
			System.out.println("대댓글 관련 정보 : " + ac);
			ObjectMapper objectMapper = new ObjectMapper();
	        String jsonString;
	        try {
	            jsonString = objectMapper.writeValueAsString(ac);
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	            jsonString = "[]"; // 에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
	        }
	        System.out.println(jsonString);
	        return jsonString;
	    }
		
	@RequestMapping(value="/addReply" , method=RequestMethod.POST, produces ="application/text; charset=UTF-8")
	@ResponseBody
	 public String addReply(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 	ajaxCommentVO ajaxCommentVO = new ajaxCommentVO();
		 	int re_articleNO = (int)session.getAttribute("re_articleNO");	
		 	String userId = null;
		 	HttpSession session = request.getSession();

			UserVO userVO = (UserVO) session.getAttribute("user");
			userId = userVO.getUserId();
			
			String aa = request.getParameter("ac_parentNO");
			
			ajaxCommentVO.setRe_articleNO(re_articleNO);
		 	ajaxCommentVO.setAc_parentNO(Integer.parseInt(aa));
		 	ajaxCommentVO.setAc_content(request.getParameter("ac_content"));
		 	ajaxCommentVO.setUserId(userId);
		 	

		 	reviewService.ajaxCommentInsert(ajaxCommentVO);

		 	// 저장된 댓글을 다시 조회하여 반환
	        List<ajaxCommentVO> ac = reviewService.ajaxComment(re_articleNO);
			ObjectMapper objectMapper = new ObjectMapper();
	        String jsonString;
	        try {
	            jsonString = objectMapper.writeValueAsString(ac);
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	            jsonString = "[]"; // 에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
	        }
	        System.out.println(jsonString);
	        return jsonString;
	    }
	//조상현:  대댓글 추가(23.08.01)
	@RequestMapping(value="/getCommentList" , method=RequestMethod.POST, produces ="application/text; charset=UTF-8")
	@ResponseBody
	 public String getCommentList(HttpServletRequest request, HttpServletResponse response) {
		 	int re_articleNO = (int)session.getAttribute("re_articleNO");

		 	// 저장된 댓글을 다시 조회하여 반환
	        List<ajaxCommentVO> ac = reviewService.ajaxComment(re_articleNO);
			System.out.println("대댓글 관련 정보@@@@@@@@@@@@@@@@ : " + ac);
			ObjectMapper objectMapper = new ObjectMapper();
	        String jsonString;
	        try {
	            jsonString = objectMapper.writeValueAsString(ac);
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	            jsonString = "[]"; // 에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
	        }
	        System.out.println(jsonString);
	        return jsonString;
	    }



	//하유리: 3-2. 업로드 이미지 출력(23.07.23.)
	@RequestMapping(value="/imgDown" , method=RequestMethod.GET)
	public void ImgDown(@RequestParam("re_storedFileName") String re_storedFileName, HttpServletResponse response) {
		//System.out.println("파일 이름: " + re_storedFileName);
		reviewService.imgDown(re_storedFileName, response);
	}
	
	//하유리: 4-1. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(Model model, int re_articleNO) {
		ReviewVO review = reviewService.detailReview(re_articleNO);
		System.out.println(re_articleNO);
		model.addAttribute("review", review);
		return "/review/updateReview";
	}
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateReview(ReviewVO reviewVO) {
		reviewService.updateReview(reviewVO);
		return "redirect:/review/list";
	}
	
	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String deleteReveiw(int re_articleNO) {
		reviewService.deleteReview(re_articleNO);
		return "redirect:/review/list";
	}
	
	//하유리: 6-1. 답변폼 조회(23.07.18.)
	@RequestMapping(value="/reply", method=RequestMethod.GET)
	public String replyForm(Model model, int re_articleNO) {
		ReviewVO review = reviewService.detailReview(re_articleNO);
		model.addAttribute("review", review);
		return "/review/replyReview";		
	}
	
	//하유리: 6-2. 답변 작성(23.07.18.) 수정(23.07.31.)
	@RequestMapping(value="/reply", method=RequestMethod.POST)
	public String replyReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
		
		// 세션 반환(23.07.18.)
        HttpSession session = request.getSession();

        // 글 작성
        reviewService.replyReview(reviewVO, request, mRequest);
        
		return "redirect:/review/list";
	}

	// 김동혁: 7-1. 검색어 기능(23.08.11) 추가
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String selectSearchReviewList(@RequestParam String s_title,
			Model model, HttpServletRequest request, HttpServletResponse response, Criteria criteria) throws Exception {
		// criteria에 검색할 제목 넣기
		criteria.setS_title(s_title);

		// 여기 SQL문, DAO, Service 다 수정해야 함 -> 수정완료!!
		List<ReviewVO> list = reviewService.selectSearchReviewList(criteria);
		model.addAttribute("reviewList", list);

		PageVO paging = new PageVO();
		paging.setCriteria(criteria);
		paging.setTotalPost(reviewService.getSearchTotal(s_title));
		model.addAttribute("pageMaker", paging);
		model.addAttribute("select", criteria.getCurPage());
		model.addAttribute("s_title", s_title);
		return "/review/search";
	}

	// getViewName 추가 - 김동혁
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
