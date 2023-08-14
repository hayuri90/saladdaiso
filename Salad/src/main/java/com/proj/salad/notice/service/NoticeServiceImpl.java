package com.proj.salad.notice.service;

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

import com.proj.salad.notice.dao.NoticeDAO;
import com.proj.salad.notice.util.FileUtils;
import com.proj.salad.notice.vo.Criteria;
import com.proj.salad.notice.vo.NoticeVO;
import com.proj.salad.notice.vo.Notice_imageVO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	private static final String filePath = "C:\\salad\\noti\\";	//파일이 저장될 위치
	
	@Autowired
	private NoticeDAO noticeDao;
	
	@Autowired
	private FileUtils fileUtils;
	
	//하유리: 1.
	@Override
	public List<NoticeVO> selectAllNoticeList(Criteria criteria){
		return noticeDao.selectAllNoticeList(criteria);
	}

	@Override
	public int getTotal() {
		return noticeDao.getTotal();
	}

	//하유리: 2-1. 글쓰기(23.07.16.)
	@Override
	public void insertNotice(NoticeVO noticeVO, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {
		// 게시글 작성
		noticeDao.insertNotice(noticeVO);
		
		//게시물 번호 가져오기
		String NoticeSeq = noticeDao.selectNotice(noticeVO);
		System.out.println("NoticeSeq :" + NoticeSeq);
		
		//하유리: 파일 업로드(23.07.20.)
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(noticeVO, mRequest, NoticeSeq, filePath);
		for(int i=0, size=list.size(); i<size; i++){
			noticeDao.insertImage(list.get(i));
		}
	}

	//하유리: 3-1. 게시물 상세보기(23.07.16.)
	@Override
	public NoticeVO detailNotice(int articleNO) {
		return noticeDao.detailNotice(articleNO);
	}

	//하유리: 3-2. 조회수(23.07.16.)
	@Override
	public void updateCnt(int articleNO, HttpSession session) {
		long updateTime=0;	
		
		if(session.getAttribute("updateTime"+articleNO)!=null) {
			updateTime = (Long) session.getAttribute("updateTime" + articleNO);
			System.out.println("articleNO: " + articleNO);
			System.out.println("updateTime: " + updateTime);
		}
		
		long currentTime = System.currentTimeMillis();
		
		if(currentTime - updateTime > 24*60*60*1000) {	
			noticeDao.updateCnt(articleNO);
			session.setAttribute("updateTime" + articleNO, currentTime);
			System.out.println("updateTime: " + updateTime);
		}	
	}
	
	//하유리: 이미지 정보 가져오기(23.07.23.)
	@Override
	public List<Notice_imageVO> detailImg(int articleNO) {
		return noticeDao.detailImg(articleNO);
	}
	
	//하유리: 3-3. 업로드 이미지 출력(23.07.23.)
	@Override
	public void imgDown(String storedFileName,  HttpServletResponse response) {
		// 직접 파일 정보를 변수에 저장해 놨지만, 이 부분이 db에서 읽어왔다고 가정한다.
		String fileName = storedFileName;
		String saveFileName = filePath + fileName;
		String contentType = "image/jpg";
        File file = new File(saveFileName);
        long fileLength = file.length();
        //파일의 크기와 같지 않을 경우 프로그램이 멈추지 않고 계속 실행되거나, 잘못된 정보가 다운로드 될 수 있다.

        //이미지파일을 가져오기 위한 규약
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Type", contentType);
        response.setHeader("Content-Length", "" + fileLength);
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");

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
            throw new RuntimeException("file Save Error");
        }
	}

	//하유리: 4-2. 게시물 수정하기(23.07.18.)
	@Override
	public int updateNotice(NoticeVO noticeVO) {
		return noticeDao.updateNotice(noticeVO);
	}

	//하유리: 5. 게시물 삭제하기(23.07.18.)
	@Override
	public void deleteNotice(int articleNO) {
		noticeDao.deleteNotice(articleNO);
	}

	//하유리: 6-2. 답변 작성(23.07.18.)
	@Override
	public void replyNotice(NoticeVO noticeVO) {
		noticeDao.replyNotice(noticeVO);
	}



}
