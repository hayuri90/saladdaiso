package com.proj.salad.review.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.proj.salad.review.vo.ReviewVO;

@Component("review_fileUtils")
public class FileUtils {
	
	public List<Map<String,Object>> parseInsertFileInfo(ReviewVO reviewVO, MultipartHttpServletRequest mRequest, String ReviewSeq, String filePath) throws Exception{
    	//Iterator는 컬렉션에서 정보를 얻어올 수 있는 인터페이스
		//Iterator를 이용하여 while문을 통해 Map에 있는 데이터에 순차적으로 접근
		Iterator<String> iterator = mRequest.getFileNames();
    	
    	//파일 업로드에 필요한 파라미터들을 null값으로 초기화
    	MultipartFile multipartFile = null;
    	String re_originalFileName = null;
    	String re_originalFileExtension = null;
    	String re_storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();	//클라이언트에서 전송될 파일정보를 담아서 List로 반환
        Map<String, Object> listMap = null; 
        
        System.out.println("ReviewSeq: " + ReviewSeq);
        String re_articleNO = ReviewSeq;	//게시물 번호 가져오기
        
        File file = new File(filePath);		
        if(file.exists() == false){	//파일 저장경로에 해당폴더가 없을 경우 폴더 생성
        	file.mkdirs();	//폴더 생성: 하위구조로 여러 개의 폴더를 생성할 경우 사용
        }
        
        while(iterator.hasNext()){	//iterator는 인덱스가 없으므로 while반복문 이용해 list의 모든 데이터를 순회하면서 데이터를 가져옴
			 						//읽어올 요소가 남아있는지 확인하는 메소드
        	multipartFile = mRequest.getFile(iterator.next());	//업로드된 파일의 이름목록에 읽어올 요소가 있다면 multipartFile 이라는 이름으로 다음 데이터를 반환
        	if(multipartFile.isEmpty() == false){	//파일이 있을 경우(이 코드가 없으면 파일 안 넣었을 때 오류 발생)
        		//다음 읽어올 요소의 데이터가 값이 있다면 업로드할때 필요한 데이터(테이블의 속성)값들을 가져온다. > 파일 정보를 새로운 이름으로 변경
        		re_originalFileName = multipartFile.getOriginalFilename();	//파일 원본이름 가져옴
        		re_originalFileExtension = re_originalFileName.substring(re_originalFileName.lastIndexOf("."));	//해당 파일의 확장자 알아냄
        		re_storedFileName = CommonUtils.getRandomString() + re_originalFileExtension;	//getRandomString()메소드를 이용해 랜덤으로 32자리 파일이름 생성
        																						//원본파일의 확장자를 붙여줌
        		file = new File(filePath + re_storedFileName);	//서버에 실제파일 저장
        		multipartFile.transferTo(file);	//지정된 경로에 파일 생성
        		
        		//위에서 만든 정보를 list에 추가
        		listMap = new HashMap<String,Object>();
        		listMap.put("USERID", reviewVO.getUserId());
        		listMap.put("RE_ARTICLENO", re_articleNO);
        		listMap.put("RE_ORGINALFILENAME", re_originalFileName);
        		listMap.put("RE_STOREDFILENAME", re_storedFileName);
        		listMap.put("RE_FILESIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
}