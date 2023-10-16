package com.proj.salad.review.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

//페이징에 필요한 파라미터를 받아서 페이징버튼을 만들 클래스
//화면에서 버튼 생성을 도와주는 계산 클래스
public class PageVO {	
	
	private int totalPost;			//총 게시물 수
	private int startPage;			//시작페이지 번호
	private int endPage;			//마지막페이지 번호
	private int realEnd;			//실제 마지막페이지 번호
	private boolean prev, next;		//이전버튼, 다음버튼
	private int displayPage=10;		//한 화면에 표시될 페이지 개수	
	private Criteria criteria;		//현재페이지에 관한 데이터 호출(PageVO는 Criteria에 의존)
		
	public PageVO() {}
	
	public PageVO(Criteria criteria, int totalPost) {	//사용자 정의 생성자
		this.totalPost=totalPost;	
		this.criteria=criteria;		
	}

	//getter, setter
	public int getTotalPost() {
		return totalPost;
	}
	
	public void setTotalPost(int totalPost) {
		this.totalPost = totalPost;
		calcData();	//게시물 총개수가 설정되는 시점에 calcData() 메서드를 호출하여 필요한 데이터 계산	
	}
	
	private void calcData() {
		endPage=(int)(Math.ceil(criteria.getCurPage() / (double)displayPage)*displayPage);	//Math.ceil(): 소수점 이하를 올림
		startPage=(endPage-displayPage)+1;
																							//(3/10)*10=10, (12/10)*10=20
		realEnd=(int)(Math.ceil(totalPost*1.0 / criteria.getPostsPerPage()));	//(int)(Math.ceil(12/10)=2
		
		if(endPage>realEnd) {	//실제 마지막 페이지번호가 계산된 마지막 페이지번호보다 적을 경우,  
			endPage=realEnd;	//마지막페이지번호를 endPage로 맞춤
		}
		
		prev=startPage==1?false:true;
		next=endPage*criteria.getPostsPerPage() >= totalPost?false:true;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getRealEnd() {
		return realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
	
	public int getDisplayPage() {
		return displayPage;
	}

	public void setDisplayPage(int displayPage) {
		this.displayPage = displayPage;
	}

	public Criteria getCriteria() {
		return criteria;
	}

	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}
	
	//UriEncoding: uri를 만드는 메소드
	public String makeQuery(int curPage){
	 UriComponents uriComponents =
	   UriComponentsBuilder.newInstance()
	   .queryParam("curPage", curPage)
	   .queryParam("perPageNum", criteria.getPostsPerPage())
	   .build();
	   
	 return uriComponents.toUriString();
	}
	
	//검색기능 관련 메소드: URLEncoding
	//뷰에서 keyword를 입력 받아와서 DB처리를 통해 검색 후, 그것으로 url을 조합해서 검색문을 페이징 처리해서 보내줌
	//page=page&perPageNum=criteria.getPostsPerPage()&searchType=(SearchCriteria)criteria).getSearchType()&keyword=encoding(((SearchCriteria)criteria).getKeyword()))으로 url 조합
	public String makeSearch(int curPage) {
		UriComponents uriComponents = 
		  UriComponentsBuilder.newInstance()
		  .queryParam("curPage", curPage)
		  .queryParam("perPageNum", criteria.getPostsPerPage())
		  .queryParam("searchType", ((SearchCriteria)criteria).getSearchType())
		  .queryParam("keyword", encoding(((SearchCriteria)criteria).getKeyword()))
		  .build();
		return uriComponents.toUriString();
	}
	
	//URLEncoding: 특정한 값들은 url 규칙에 맞게 변환되어야 함
	//예) 쿠키와 같이 한글을 표현하지 못하는 경우, 한글을 ASCII값으로 인코딩
	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}

	//toString
	@Override
	public String toString() {
		return "PageVO [totalPost=" + totalPost + ", startPage=" + startPage + ", endPage=" + endPage + ", realEnd="
				+ realEnd + ", prev=" + prev + ", next=" + next + ", displayPage=" + displayPage + ", criteria="
				+ criteria + "]";
	}
	
}