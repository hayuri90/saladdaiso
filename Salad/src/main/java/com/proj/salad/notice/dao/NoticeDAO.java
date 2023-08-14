package com.proj.salad.notice.dao;

import java.util.List;
import java.util.Map;

import com.proj.salad.notice.vo.Criteria;
import com.proj.salad.notice.vo.NoticeVO;
import com.proj.salad.notice.vo.Notice_imageVO;

public interface NoticeDAO {
	
	//하유리: 1-1. 리뷰게시판 전체리스트 보기(23.07.16.)
	public List<NoticeVO> selectAllNoticeList(Criteria criteria);
	
	//하유리: 1-2. 게시물 총 개수(23.07.16.)
	public int getTotal();
	
	//하유리: 2-1. 리뷰게시판 글쓰기(23.07.16.)
	public void insertNotice(NoticeVO noticeVO);
	
	//하유리: 게시물 번호 가져오기(23.07.20.)
	public String selectNotice(NoticeVO noticeVO);
	
	//하유리: 파일 업로드(23.07.20.)
	public void insertImage(Map<String, Object>map) throws Exception;
	
	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	public NoticeVO detailNotice(int articleNO);
	
	//하유리: 3-2. 조회수(23.07.16.)
	public void updateCnt(int articleNO);
	
	//하유리: 이미지 정보 가져오기(23.07.23.)
	public List<Notice_imageVO> detailImg(int articleNO);
	
	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	public int updateNotice(NoticeVO noticeVO);
	
	//하유리: 5. 게시물 삭제하기(23.07.18.)
	public void deleteNotice(int articleNO);
	
	//하유리: 6-2. 답변 작성(23.07.18.)
	public void replyNotice(NoticeVO noticeVO);

}
