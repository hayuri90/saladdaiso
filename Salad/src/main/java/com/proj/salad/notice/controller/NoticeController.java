package com.proj.salad.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.proj.salad.notice.service.NoticeService;
import com.proj.salad.notice.vo.Criteria;
import com.proj.salad.notice.vo.NoticeVO;
import com.proj.salad.notice.vo.Notice_imageVO;
import com.proj.salad.notice.vo.PageVO;

@Controller
@RequestMapping("/notice")
public class NoticeController extends HttpServlet {
		
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private HttpSession session;

	//하유리: 1. 전체목록조회 + 답변형 게시판 + 페이징(23.07.16.)
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String selectAllNoticeList(Model model, HttpServletRequest request, HttpServletResponse response, Criteria criteria) throws Exception {
		List<NoticeVO> list = noticeService.selectAllNoticeList(criteria);
		model.addAttribute("noticeList", list);
		
		PageVO paging = new PageVO();
		paging.setCriteria(criteria);
		//게시물 총 개수(23.07.16.)
		paging.setTotalPost(noticeService.getTotal());
		model.addAttribute("pageMaker", paging);
		model.addAttribute("select", criteria.getCurPage());
		return "/notice/list";
	}
	
	//하유리: 2-1. 글쓰기(23.07.16.)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertForm() {
		return "/notice/insertNotice";
	}
	
	//하유리: 2-2. 공지게시판 글쓰기(23.07.16.)
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
    public ModelAndView insertNotice(NoticeVO noticeVO, HttpServletRequest request, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {

        //세션 반환(23.07.18.)
        HttpSession session = request.getSession();
        
        //파일 업로드(23.07.20.)
        ModelAndView mav = new ModelAndView("redirect:/notice/list");
    	noticeService.insertNotice(noticeVO, request, mRequest);
    	return mav;
    }

	//하유리: 3-1. 게시물 상세조회(23.07.16.)
	@RequestMapping(value="/content", method=RequestMethod.GET)
	public String detailNotice(int articleNO, Model model, HttpSession session) throws Exception {
		//조회수 증가(23.07.16.)
		noticeService.updateCnt(articleNO, session);
		
		//이미지 정보 가져오기(23.07.23.)
		List<Notice_imageVO> imageVO = noticeService.detailImg(articleNO);
		System.out.println("이미지 관련 정보 :" + imageVO);
				
		NoticeVO noticeVO = noticeService.detailNotice(articleNO);
		noticeVO.setImageFileList(imageVO);
		System.out.println("imageFileList: "+noticeVO.getImageFileList());
		model.addAttribute("notice", noticeVO);
		
		return "/notice/noticeContent";
	}
	
	//하유리: 3-2. 업로드 이미지 출력(23.07.23.)
	@RequestMapping(value="/imgDown" , method=RequestMethod.GET)
	public void ImgDown(@RequestParam("storedFileName") String storedFileName, HttpServletResponse response) {
		//System.out.println("파일 이름: " + storedFileName);
		noticeService.imgDown(storedFileName, response);
	}
	
	//하유리: 4-1. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(Model model, int articleNO) {
		
		//이미지 정보 가져오기
		List<Notice_imageVO> notice_imgVO = noticeService.detailImg(articleNO);
		System.out.println("이미지 정보: " + notice_imgVO);
		
		NoticeVO notice = noticeService.detailNotice(articleNO);
		System.out.println("게시글 번호: "+articleNO);
		notice.setImageFileList(notice_imgVO);
		model.addAttribute("notice", notice);
		return "/notice/updateNotice";
	}
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateNotice(NoticeVO noticeVO, RedirectAttributes rttr) {
		noticeService.updateNotice(noticeVO);
		System.out.println("수정내용: "+noticeService.updateNotice(noticeVO));
		
		//수정 후 redirect로 페이지 이동 시, 경고창 띄우기 위해
		rttr.addFlashAttribute("result", "modify success"); //"result" 속성 값에 "modify success" 스트링 데이터를 저장
		return "redirect:/notice/content?articleNO="+noticeVO.getArticleNO(); //수정한 게시물로 이동(23.09.01.)
	}
	
	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String deleteNotice(int articleNO, RedirectAttributes rttr) {
		noticeService.deleteNotice(articleNO);
		rttr.addFlashAttribute("articleNO", articleNO); //게시물번호를 넘김
		rttr.addFlashAttribute("result", "delete success"); //게시물 삭제 후 알림창 출력
		return "redirect:/notice/list";
	}
	
	//하유리: 6-1. 답변폼 조회(23.07.18.)
	@RequestMapping(value="/reply", method=RequestMethod.GET)
	public String replyForm(Model model, int articleNO) {
		NoticeVO noticeVO = noticeService.detailNotice(articleNO);
		model.addAttribute("notice", noticeVO);
		return "/notice/replyNotice";		
	}
	
	//하유리: 6-2. 답변 작성(23.07.18.)
	@RequestMapping(value="/reply", method=RequestMethod.POST)
	public String replyNotice(NoticeVO noticeVO, HttpServletRequest request) {
		
		//세션 반환(23.07.18.)
        HttpSession session = request.getSession();
        noticeService.replyNotice(noticeVO);
        
		return "redirect:/notice/list";
	}
	
}