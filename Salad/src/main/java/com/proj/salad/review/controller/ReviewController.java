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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.review.service.ReviewService;
import com.proj.salad.review.util.CommonUtils;
import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.PageVO;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.SearchCriteria;
import com.proj.salad.review.vo.ajaxCommentVO;
import com.proj.salad.user.vo.UserVO;

@Controller	//springframework에 이 클래스가 controller임을 알려줌
@RequestMapping("/review")	//공통적인 url 설정
public class ReviewController extends HttpServlet {
		
	@Autowired	//의존성 주입
	private ReviewService reviewService;

	@Autowired
	private MyPageOrderServiceImpl myPageOrderService;

	@Autowired
	private HttpSession session;

	@Autowired
	private ajaxCommentVO ajaxCommentVO;

	//하유리: 1. 전체목록조회 + 답변형 게시판 + 페이징(23.07.16.)
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String selectAllReviewList(Model model, HttpServletRequest request, HttpServletResponse response, Criteria criteria) throws Exception {
		//Criteria(VO)로 받은 값을, 페이징을 원하는 select문에 매개변수로 넣어서 List데이터를 Model을 이용해 뷰로 보내준다.
		List<ReviewVO> list = reviewService.selectAllReviewList(criteria);	//List형식으로 데이터를 가져와 Model에 담음
		model.addAttribute("reviewList", list);	//Model에 reviewList라는 이름으로 list값을 넣어서 jsp(view)로 전달
		
		//페이징
		PageVO paging = new PageVO();
		paging.setCriteria(criteria); //파라미터(criteria)를 넣어서 현재 페이지에 따라 페이징 버튼 변경
		paging.setTotalPost(reviewService.getTotal());	//게시물 총 개수(23.07.16.)
		model.addAttribute("pageMaker", paging);
		model.addAttribute("select", criteria.getCurPage()); //현재페이지
		
		return "/review/list";
	}
	
	//하유리: 2-1. 글쓰기(23.07.16.)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertFormWithON(int orderNum, HttpServletRequest request, Model model) throws Exception {
		String userName = null;
		
		Integer checkNull = orderNum; //Integer: int의 wrapper class
		OrderInfoVO orderInfoVO = null;

		//orderNum으로 주문 내역 조회
		if(checkNull != null) { //checkNull이 wrapper class이기 때문에 null값과 비교 가능
			orderInfoVO = myPageOrderService.selectOrderOne(orderNum); //주문번호 가져오기
			model.addAttribute("orderInfo", orderInfoVO); //model에 담아서 view로 전달
			System.out.println("받은 orderNum : " + orderNum);
			System.out.println("나온 orderInfo 결과값 : " + orderInfoVO.getFakeOrderNum());
		}
		return "/review/insertReview";
	}
	
	//하유리: 2-2. 글쓰기(23.07.16.)
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insertReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest, RedirectAttributes rttr) throws Exception {
        //세션 값 가져오기(23.07.18.)
        HttpSession session = request.getSession();

        //게시물 작성+파일 업로드(23.07.20.)
    	reviewService.insertReview(reviewVO, request, mRequest); //Controller에서 Request를 MultipartHttpServletRequest로 받음
    															 //첨부파일을 인코딩해서 파라미터 값을 받아올 수 있게 하는 MultiparthttpServletRquest를 추가
    	
		//김동혁: order 테이블 reviewStatus=1로 수정(23.08.02.)
    	reviewService.updateReviewStatus(reviewVO);
    	
    	rttr.addFlashAttribute("result", "enroll success"); //스트링 데이터를 "result" 속성 값에 저장하는 addFlashAttribute() 메소드 호출
    	
    	return "redirect:/review/list"; //페이지 이동
    }

	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	@RequestMapping(value="/content", method=RequestMethod.GET)
	public String detailReview(Criteria criteria, int re_articleNO, SearchCriteria scri, Model model, HttpSession session) {
		
		//페이징 정보 가져오기
		PageVO paging = new PageVO();
		paging.setCriteria(criteria);
		model.addAttribute("pageMaker", paging);
		System.out.println("curPage: " + paging.getCriteria().getCurPage());
		
		//조회수 증가
		reviewService.updateCnt(re_articleNO, session);
		
		//이미지 정보 가져오기(23.07.23.)
		//List<Review_imageVO> imageVO = reviewService.detailImg(re_articleNO);
		//System.out.println("이미지 관련 정보 :" + imageVO);
				
		ReviewVO review = reviewService.detailReview(re_articleNO); //게시물 데이터 가져오기
		review.setRe_imageFileList(reviewService.detailImg(re_articleNO)); //이미지 정보 가져오기
		model.addAttribute("review", review);
		model.addAttribute("scri", scri);	//검색
		
		//로그인 세션 가져오기
		UserVO userVO = (UserVO) session.getAttribute("user");
		model.addAttribute("userVO",userVO);
		
		//조상현: 세션이용(23.07.31)
		session.removeAttribute("re_articleNO");
		session.setAttribute("re_articleNO", re_articleNO);

		return "/review/reviewContent";
	}

	//하유리: 3-2. 업로드 이미지 출력(23.07.23.)
	@RequestMapping(value="/imgDown", method=RequestMethod.GET)
	public void ImgDown(@RequestParam("re_storedFileName") String re_storedFileName, HttpServletResponse response) {
		//System.out.println("파일 이름: " + re_storedFileName);
		reviewService.imgDown(re_storedFileName, response);
	}
	
	//하유리: 4-1. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(Model model, int re_articleNO) {
		
		//이미지 관련 정보 가져오기(23.07.23.)
		List<Review_imageVO> imageVO = reviewService.detailImg(re_articleNO);
		System.out.println("이미지 관련 정보 :" + imageVO);
		
		ReviewVO review = reviewService.detailReview(re_articleNO);
		System.out.println(re_articleNO);
		review.setRe_imageFileList(imageVO);
		model.addAttribute("review", review);		
		
		return "/review/updateReview";
	}
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateReview(ReviewVO reviewVO, RedirectAttributes rttr) {
		//업로드된 파일 삭제
		
		//파일 추가 업로드
		
		reviewService.updateReview(reviewVO);
		
		//수정 후 redirect로 페이지 이동 시, 경고창을 띄우기 위해
		rttr.addFlashAttribute("result", "modify success"); //"result" 속성 값에 "modify success" 스트링 데이터를 저장
		return "redirect:/review/content?re_articleNO="+reviewVO.getRe_articleNO(); //수정한 게시물로 이동(23.09.01.)
	}
	
	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String deleteReveiw(int re_articleNO, RedirectAttributes rttr) {
		reviewService.deleteReview(re_articleNO);
		rttr.addFlashAttribute("re_articleNO", re_articleNO); //게시물번호를 넘김
		rttr.addFlashAttribute("result", "delete success"); //게시물 삭제 후 알림창 출력
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
		
		// 세션 값 가져오기(23.07.18.)
        HttpSession session = request.getSession();
        System.out.println("@@@@@@Controller_userId: " + session.getId());

        // 글 작성
        reviewService.replyReview(reviewVO, request, mRequest);
        
		return "redirect:/review/list";
	}
	
	//하유리: 7. 글 목록 + 페이징 + 검색
	@RequestMapping(value="/searchList", method=RequestMethod.GET)
	public String searchList(SearchCriteria scri, Model model, String searchType, String keyword) throws Exception {
		//검색목록 출력
		List<ReviewVO> list = reviewService.searchList(scri);
		model.addAttribute("reviewList", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("keyword", keyword);
		
		//검색결과 페이징
		PageVO paging = new PageVO();
		paging.setCriteria(scri);
		//검색 결과 개수
		paging.setTotalPost(reviewService.searchCount(scri));
		model.addAttribute("pageMaker", paging);
		System.out.println("@@@검색기능 실행");
		
		return "/review/searchList";
	}

	//김동혁: getViewName 추가
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
	
	//조상현: 댓글, 대댓글(23.08.01.)
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
            jsonString = "[]"; 	// 에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
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
            jsonString = "[]"; 	//에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
        }
        System.out.println(jsonString);
        return jsonString;
    }
	
	//조상현: 대댓글 추가(23.08.01)
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
            jsonString = "[]"; 	//에러 발생 시 빈 배열을 반환하거나 다른 처리를 수행할 수 있습니다.
        }
        System.out.println(jsonString);
        return jsonString;
    }

}