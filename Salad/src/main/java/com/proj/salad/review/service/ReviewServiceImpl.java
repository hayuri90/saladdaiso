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
		//하유리: 게시글 작성
		reviewDao.insertReview(reviewVO);
		
		//하유리: 게시물 번호 가져오기(23.07.20.)
		String ReviewSeq = reviewDao.selectReview(reviewVO);
		
		//하유리: 파일 업로드(23.07.20.)
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(reviewVO, mRequest, ReviewSeq, filePath);	//DB에 넣을 정보만 list에 담음
		for(int i=0, size=list.size(); i<size; i++){
			reviewDao.insertImage(list.get(i));
		}
	}

	//김동혁: 2-2-1. order 테이블 reviewStatus → 1로 수정(23.08.02.)
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
		long updateTime=0;	
		
		if(session.getAttribute("updateTime"+re_articleNO)!=null) {
			updateTime = (Long) session.getAttribute("updateTime" + re_articleNO);
			System.out.println("re_articleNO: " + re_articleNO);
			System.out.println("updateTime: " + updateTime);
		}
		
		long currentTime = System.currentTimeMillis();
		
		if(currentTime - updateTime > 24*60*60*1000) {	
			reviewDao.updateCnt(re_articleNO);
			session.setAttribute("updateTime" + re_articleNO, currentTime);
			System.out.println("updateTime: " + updateTime);
		}	
	}
	
	//하유리: 3-1-2. 이미지 정보 가져오기(23.07.23.)
	@Override
	public List<Review_imageVO> detailImg(int re_articleNO) {
		return reviewDao.detailImg(re_articleNO);
	}
	
	//하유리: 3-2. 업로드 이미지 출력(23.07.23.)
	@Override
	public void imgDown(String re_storedFileName, HttpServletResponse response) {
		//직접 파일 정보를 변수에 저장해 놨지만, 이 부분이 db에서 읽어왔다고 가정한다.
		String fileName = re_storedFileName;
		String saveFileName = filePath + fileName;
		String contentType = "image/jpg";	//다운받을 파일 형식 지정
        File file = new File(saveFileName);
        long fileLength = file.length();
        //파일의 크기와 같지 않을 경우 프로그램이 멈추지 않고 계속 실행되거나, 잘못된 정보가 다운로드 될 수 있다.

        //이미지파일을 가져오기 위한 규약
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Type", contentType);
        response.setHeader("Content-Length", "" + fileLength);	//파일크기
        response.setHeader("Pragma", "no-cache;");						
        response.setHeader("Expires", "-1;");	//이미지 출력시간을 무한대로 지정

        try(
        		//파일 읽을 준비
                FileInputStream fis = new FileInputStream(saveFileName);
                OutputStream out = response.getOutputStream();
        ){
        		//실제로 파일 읽는 부분
                int readCount = 0;
                byte[] buffer = new byte[1024];
                while((readCount = fis.read(buffer)) != -1){
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