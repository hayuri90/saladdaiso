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

@Component("review_fileUtils") //@Component: 클래스를 빈으로 등록
public class FileUtils {
	
	public List<Map<String,Object>> parseInsertFileInfo(ReviewVO reviewVO, MultipartHttpServletRequest mRequest, String ReviewSeq, String filePath) throws Exception{
    	//Iterator는 컬렉션을 순회하면서 정보를 얻어올 수 있는 인터페이스
		Iterator<String> iterator = mRequest.getFileNames(); //MultipartHttpServletRequest 객체에 담긴 파일 이름들을 Iterator타입으로 저장
    	
    	//파일 업로드에 필요한 파라미터들 선언 및 null값으로 초기화
    	MultipartFile multipartFile = null; //MultipartFile: 업로드한 파일, 파일데이터를 표현하기 위한 용도로 사용
    	String re_originalFileName = null;
    	String re_originalFileExtension = null;
    	String re_storedFileName = null;
    	String re_articleNO = ReviewSeq;	//게시물 번호 가져와서 re_articleNO에 대입
    	System.out.println("ReviewSeq: " + ReviewSeq);
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();	//클라이언트에서 전송될 파일정보를 담아서 List로 반환
        Map<String, Object> listMap = null; 
        
        //파일 저장경로에 폴더가 없을 경우, 폴더 생성
        File file = new File(filePath);		
        if(file.exists() == false){
        	file.mkdirs();	//mkdirs(): 생성할 디렉토리의 상위 디렉토리가 없을 경우, 상위 디렉토리까지 생성
        }
        
        while(iterator.hasNext()){	//Map은 인덱스가 없기 때문에 while반복문 이용해 Map의 모든 데이터를 순회하면서 데이터를 가져옴
			 						//hasNext(): 읽어올 요소가 남아있는지 확인하는 메소드
        	//Iterator 형태로 추출된 파일들의 이름을 키값으로 하여, while문을 돌면서 넘어온 파일들의 정보를 추출해서 가공
        	multipartFile = mRequest.getFile(iterator.next()); //위에서 가져온 파일이름을 통해 파일정보 추출
        	if(multipartFile.isEmpty() == false){	//파일정보가 있을 경우(이 코드가 없으면 파일 안 넣었을 때 오류 발생)
        		//파일 정보 가공
        		re_originalFileName = multipartFile.getOriginalFilename();	//파일 원본이름
        		re_originalFileExtension = re_originalFileName.substring(re_originalFileName.lastIndexOf("."));	//파일의 확장자만 추출
        		re_storedFileName = CommonUtils.getRandomString() + re_originalFileExtension;	//getRandomString()메소드를 이용해 32자리 랜덤 파일명 생성+원본파일 확장자
        		
        		//파일 저장
        		file = new File(filePath + re_storedFileName); //파일을 저장하기 위한 파일객체 생성
        		System.out.println("@@@file:"+file); //file: filePath\re_storedFileName 이렇게 저장하겠다고 설계
        		multipartFile.transferTo(file);	//File객체에 설정한 파일경로에 저장
        		
        		//위에서 만든 정보를 Map에 추가 > 다시 List에 저장
        		listMap = new HashMap<String,Object>(); //파일정보를 저장할 Map 생성
        		listMap.put("USERID", reviewVO.getUserId());	//HashMap에 값 추가: put(key,value) 메소드 사용
        		listMap.put("RE_ARTICLENO", re_articleNO);	 	//HashMap 선언 시 설정한 타입에 맞춰 key, value값 추가
        		listMap.put("RE_ORGINALFILENAME", re_originalFileName);
        		listMap.put("RE_STOREDFILENAME", re_storedFileName);
        		listMap.put("RE_FILESIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        }
		return list; //List 반환
	}
}