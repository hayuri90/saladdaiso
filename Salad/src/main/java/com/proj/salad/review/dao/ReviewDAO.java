package com.proj.salad.review.dao;

import java.util.List;
import java.util.Map;

import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.SearchCriteria;
import com.proj.salad.review.vo.ajaxCommentVO;

public interface ReviewDAO {
	
	//하유리: 1. 전체목록조회 + 답변형 게시판 + 페이징(23.07.16.)
	public List<ReviewVO> selectAllReviewList(Criteria criteria);
	
	//하유리: 1-1-1. 게시물 총 개수(23.07.16.)
	public int getTotal();
	
	//하유리: 2-2. 글쓰기(23.07.16.)
	public void insertReview(ReviewVO reviewVO);

	//김동혁: 2-2-1. order 테이블 reviewStatus → 1로 수정(23.08.02.)
	public void updateReviewStatus(ReviewVO reviewVO);
	
	//하유리: 2-2-1. 게시물 번호 가져오기(23.07.20.)
	public String selectReview(ReviewVO reviewVO);
	
	//하유리: 2-2-2. 파일 업로드(23.07.20.)
	public void insertImage(Map<String, Object>map) throws Exception;
	
	//하유리: 3-1. 게시물 상세조회(23.07.16.)
	public ReviewVO detailReview(int re_articleNO);
	
	//하유리: 3-1-1. 조회수(23.07.16.)
	public void updateCnt(int re_articleNO);
	
	//하유리: 3-1-2. 이미지 정보 가져오기(23.07.23.)
	public List<Review_imageVO> detailImg(int re_articleNO);
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	public int updateReview(ReviewVO reviewVO);
	
	//하유리: 5. 게시물 삭제하기(23.07.18.)
	public void deleteReview(int re_articleNO);
	
	//하유리: 6-2. 답변 작성(23.07.18.)
	public void replyReview(ReviewVO reviewVO);

	//하유리: 7. 글 목록 + 페이징 + 검색
	public List<ReviewVO> searchList(SearchCriteria scri) throws Exception;
	
	//하유리: 7-1. 검색 결과 개수
	public int searchCount(SearchCriteria scri) throws Exception;
	
	//조상현: 댓글, 대댓글(23.08.01)
	public List<ajaxCommentVO> selectComment(int re_articleNO);
	public void insertCommnet(ajaxCommentVO ajaxCommentVO);

}