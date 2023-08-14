package com.proj.salad.review.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.ajaxCommentVO;

public interface ReviewService {
	
	//하유리: 1-1. (23.07.16.)
	public List<ReviewVO> selectAllReviewList(Criteria criteria);

	//하유리: 1-2. 게시물 총 개수(23.07.16.)
	public int getTotal();
	
	//하유리: 2. 글쓰기(23.07.16.)
	public void insertReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception;

	//김동혁: 2-1-1. order 테이블 reviewStatus -> 1로 수정(23.08.02)
	public void updateReviewStatus(ReviewVO reviewVO);
	
	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	public ReviewVO detailReview(int re_articleNO);

	//하유리: 3-2. 조회수(23.07.16.)
	public void updateCnt(int re_articleNO, HttpSession session);
	
	//하유리: 이미지 정보 가져오기(23.07.23.)
	public List<Review_imageVO> detailImg(int re_articleNO);
	
	//하유리: 3-3. 업로드 이미지 출력(23.07.23.)
	public void imgDown(String re_storedFileName, HttpServletResponse response);
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	public int updateReview(ReviewVO reviewVO);

	//하유리: 5. 게시물 삭제하기(23.07.18.)
	public void deleteReview(int re_articleNO);
	
	//하유리: 6-2. 답변 작성(23.07.18.)
	public void replyReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception;

	public List<ajaxCommentVO> ajaxComment(int re_articleNO);

	public void ajaxCommentInsert(ajaxCommentVO ajaxCommentVO);

	public List<ReviewVO> selectSearchReviewList(Criteria criteria);

	public int getSearchTotal(String s_title);

}
