package com.proj.salad.review.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.ajaxCommentVO;

import lombok.RequiredArgsConstructor;

@Repository("reviewDao")
@RequiredArgsConstructor
public class ReviewDAOImpl implements ReviewDAO {

	//DB에 접속하기 위해 의존관계 주입
	@Autowired
	private SqlSessionTemplate sqlSession;

	//하유리: 1-1. 리뷰게시판 전체리스트 보기(23.07.16.)
	@Override
	public List<ReviewVO> selectAllReviewList(Criteria criteria) {
		return sqlSession.selectList("review.selectAllReviewList", criteria);
	}

	//하유리: 1-2. 게시물 총 개수(23.07.16.)
	@Override
	public int getTotal() {
		return sqlSession.selectOne("review.getTotal");
	}

	//하유리: 2-1. 리뷰게시판 글쓰기(23.07.16.)
	@Override
	public void insertReview(ReviewVO reviewVO) {
		sqlSession.insert("review.insertReview", reviewVO);
	}

	//김동혁: 2-1-1. order 테이블 reviewStatus -> 1로 수정(23.08.02)
	@Override
	public void updateReviewStatus(ReviewVO reviewVO) {
		sqlSession.update("review.updateOrderReviewStatus", reviewVO);
	}

	//하유리: 게시물 번호 가져오기(23.07.20.)
	@Override
	public String selectReview(ReviewVO reviewVO) {
		return sqlSession.selectOne("review.selectReview", reviewVO);
	}
	
	//하유리: 파일 업로드(23.07.20.)
	public void insertImage(Map<String, Object>map) throws Exception{
		sqlSession.insert("review.insertReviewImg", map);
	}
	
	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	@Override
	public ReviewVO detailReview(int re_articleNO) {
		return (ReviewVO) sqlSession.selectOne("review.detailReview", re_articleNO);
	}
	
	//하유리: 3-2. 조회수(23.07.16.)
	@Override
	public void updateCnt(int re_articleNO) {
		sqlSession.update("review.updateCnt", re_articleNO);
	}
	
	//하유리: 이미지 정보 가져오기(23.07.23.)
	@Override
	public List<Review_imageVO> detailImg(int re_articleNO) {
		return sqlSession.selectList("review.detailImg", re_articleNO);
	}

	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@Override
	public int updateReview(ReviewVO reviewVO) {
		return sqlSession.update("review.updateReview", reviewVO);
	}

	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@Override
	public void deleteReview(int re_articleNO) {
		sqlSession.delete("review.deleteReview", re_articleNO);		
	}

	//하유리: 6-2. 답변 작성(23.07.18.)
	@Override
	public void replyReview(ReviewVO reviewVO) {
		sqlSession.insert("review.replyReview", reviewVO);
	}

	@Override
	public List<ajaxCommentVO> selectComment(int re_articleNO) {
		return sqlSession.selectList("review.selectComment", re_articleNO);
	}

	@Override
	public void insertCommnet(ajaxCommentVO ajaxCommentVO) {
		System.out.println("DAO VO 정보!!!!!!!!!!"+ajaxCommentVO);
		sqlSession.insert("review.insertComment",ajaxCommentVO);
		
	}

	@Override
	public List<ReviewVO> selectSearchReviewList(Criteria criteria) {
		return sqlSession.selectList("review.selectSearchReviewList", criteria);
	}

	@Override
	public int getSearchTotal(String s_title) {
		return sqlSession.selectOne("review.getSearchTotal", s_title);
	}
}
