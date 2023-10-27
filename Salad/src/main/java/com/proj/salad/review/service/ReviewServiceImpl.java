package com.proj.salad.review.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.proj.salad.review.dao.ReviewDAO;
import com.proj.salad.review.util.FileUtils;
import com.proj.salad.review.vo.Criteria;
import com.proj.salad.review.vo.ReviewVO;
import com.proj.salad.review.vo.Review_imageVO;
import com.proj.salad.review.vo.SearchCriteria;
import com.proj.salad.review.vo.ajaxCommentVO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {
	
	private static final String filePath = "C:\\salad\\review\\";	//파일이 저장될 위치
	
	@Autowired
	private ReviewDAO reviewDao;
	
	@Autowired
	private FileUtils fileUtils;
	
	//하유리: 1. 전체목록조회 + 답변형 게시판 + 페이징(23.07.16.)
	@Override
	public List<ReviewVO> selectAllReviewList(Criteria criteria) {
		return reviewDao.selectAllReviewList(criteria);
	}

	//하유리: 1-1-1. 게시물 총 개수(23.07.16.)
	@Override
	public int getTotal() {
		return reviewDao.getTotal();
	}

	//하유리: 2-2. 글쓰기(23.07.16.)
	@Override
	public void insertReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {
		//하유리: 게시물 작성
		reviewDao.insertReview(reviewVO);
		
		//하유리: 게시물 번호 가져오기(23.07.20.)
		String ReviewSeq = reviewDao.selectReview(reviewVO);
		
		//하유리: 파일 업로드(23.07.20.)
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(reviewVO, mRequest, ReviewSeq, filePath);	//DB에 넣을 정보만 list에 담음
		System.out.println("@@@@@list.size(): " + list.size()); //첨부파일 개수
		for(int i=0, size=list.size(); i<size; i++){
			reviewDao.insertImage(list.get(i));
		}
	}

	//김동혁: 2-2-1. order 테이블 reviewStatus=1로 수정(23.08.02.)
	@Override
	public void updateReviewStatus(ReviewVO reviewVO) {
		reviewDao.updateReviewStatus(reviewVO);
	}

	//하유리: 3-1. 게시물 상세조회(23.07.16.)
	@Override
	public ReviewVO detailReview(int re_articleNO) {
		return reviewDao.detailReview(re_articleNO);
	}

	//하유리: 3-1-1. 조회수(23.07.16.)
	@Override
	public void updateCnt(int re_articleNO, HttpSession session) {
		long updateTime=0; //게시물 조회시간 변수선언+초기화
		
		//현재시간과 조회시간의 차이가 하루 미만일 때(=24시간 내에 처음 조회한 게 아닐 때)
		if(session.getAttribute("updateTime"+re_articleNO)!=null) { //세션에 값이 있을 때
			updateTime = (Long) session.getAttribute("updateTime" + re_articleNO); //세션에 저장된 값(24시간 내 게시글 처음 조회시간)을 key로 가져옴
			System.out.println("re_articleNO: " + re_articleNO); //게시물번호 출력
			System.out.println("updateTime: " + updateTime); //updateTime+게시물번호가 long타입으로 형변환되어 출력
		}
		
		//현재시간 구하기
		long currentTime = System.currentTimeMillis();
		System.out.println("currentTime: " + currentTime);
		//조회한 지 하루가 넘은 게시물 클릭 시(=해당 게시물을 24시간 내에 처음 조회했을 때)
		if(currentTime - updateTime > 24*60*60*1000) { //현재시간-조회시간(0)의 차이가 하루 이상일 때
			reviewDao.updateCnt(re_articleNO); //조회수 +1 증가시켜주는 쿼리로 연결
			session.setAttribute("updateTime" + re_articleNO, currentTime); //세션에 게시글 조회시간을 값으로 저장(key: "updateTime" + re_articleNO, 값: currentTime)
			//System.out.println("currentTime: " + session.getAttribute("updateTime"+re_articleNO)); //key로 세션값 출력하면 값(currentTime) 출력
		}			
	}
	
	//하유리: 3-1-2. 이미지 정보 가져오기(23.07.23.)
	@Override
	public List<Review_imageVO> detailImg(int re_articleNO) {
		return reviewDao.detailImg(re_articleNO);
	}
	
	//하유리: 3-2. 파일 다운로드(23.07.23.)
	@Override
	public void imgDown(String re_storedFileName, HttpServletResponse response) {
		//직접 파일 정보를 변수에 저장해 놨지만, 이 부분이 db에서 읽어왔다고 가정한다.
		String fileName = re_storedFileName;
		String saveFileName = filePath + fileName;
        File file = new File(saveFileName);
        long fileLength = file.length();
        //파일의 크기와 같지 않을 경우 프로그램이 멈추지 않고 계속 실행되거나, 잘못된 정보가 다운로드 될 수 있다.

        //이미지파일을 가져오기 위한 규약
        //response에 header 설정
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary"); //전송되는 데이터의 인코딩 방식 지정
        response.setHeader("Content-Type", "image/gif"); //다운 받을 파일유형 지정
        response.setHeader("Content-Length", "" + fileLength);	//파일크기 지정
        response.setHeader("Pragma", "no-cache;");						
        response.setHeader("Expires", "-1;");	//만료일 지정: 이미지 출력시간을 무한대로 지정

        try(
        		//파일 읽을 준비
                FileInputStream fis = new FileInputStream(saveFileName); //InputStream: 자바에서 외부데이터 입력 받을 때 사용
                OutputStream out = response.getOutputStream(); //파일을 outputStream으로 출력
        ){
        		//실제로 파일 읽는 부분
                int readCount = 0;
                byte[] buffer = new byte[1024]; //데이터를 옮길 단위 설정(1024byte=1KB)
                while((readCount = fis.read(buffer)) != -1){ //읽어들일 스트림이 없을 때까지 반복
                    out.write(buffer,0,readCount);
            }
        }catch(Exception ex){
            throw new RuntimeException("file Download Error");
        }
	}

	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@Override
	public int updateReview(ReviewVO reviewVO) {
		return reviewDao.updateReview(reviewVO);
	}

	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@Override
	public void deleteReview(int re_articleNO) {
		reviewDao.deleteReview(re_articleNO);
	}

	//하유리: 6-2. 답변 작성(23.07.18.)
	@Override
	public void replyReview(ReviewVO reviewVO, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {
		reviewDao.replyReview(reviewVO);
		
		System.out.println("@@@@@@@userId: " + reviewVO.getUserId());
		
		//하유리: 게시물 번호 가져오기(23.07.31.)
		String ReviewSeq = reviewDao.selectReview(reviewVO);
				
		//하유리: 파일 업로드(23.07.31.)
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(reviewVO, mRequest, ReviewSeq, filePath);	//DB에 넣을 정보만 list에 담음
		for(int i=0, size=list.size(); i<size; i++){
			reviewDao.insertImage(list.get(i));
		}
	}
	
	//하유리: 7. 글 목록 + 페이징 + 검색
	@Override
	public List<ReviewVO> searchList(SearchCriteria scri) throws Exception {
		return reviewDao.searchList(scri);
	}
	
	//하유리: 7-1. 검색 결과 개수
	@Override
	public int searchCount(SearchCriteria scri) throws Exception{
		return reviewDao.searchCount(scri);
	}

	//조상현: 댓글, 대댓글(23.08.01.)
	@Override
	public List<ajaxCommentVO> ajaxComment(int re_articleNO) {
		return reviewDao.selectComment(re_articleNO);
	}

	@Override
	public void ajaxCommentInsert(ajaxCommentVO ajaxCommentVO) {
		reviewDao.insertCommnet(ajaxCommentVO);
	}

}