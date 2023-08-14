package com.proj.salad.notice.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageVO {	
	
	private int totalPost;					//총 게시물 수 	
	private int startPage;				//시작페이지 번호		
	private int endPage;				//마지막페이지 번호
	private int realEnd;					//실제 마지막페이지 번호
	private boolean prev, next;		//이전버튼, 다음버튼
	private int displayPage=10;		//한 화면에 표시될 페이지개수	
	private Criteria criteria;				//현재페이지에 관한 데이터 호출
		
	public PageVO() {}
	
	public PageVO(Criteria criteria, int totalPost) {
		this.totalPost=totalPost;
		this.criteria=criteria;		
	}

	//getter, setter
	public int getTotalPost() {
		return totalPost;
	}

	public void setTotalPost(int totalPost) {
		this.totalPost = totalPost;
		calcData();		
	}
	
	private void calcData() {
		endPage=(int)(Math.ceil(criteria.getCurPage() / (double)displayPage)*displayPage);
		startPage=(endPage-displayPage)+1;
		realEnd=(int)(Math.ceil(totalPost*1.0 / criteria.getPostsPerPage()));
		
		if(endPage>realEnd) {
			endPage=realEnd;
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
	
	public String makeQuery(int curPage){
	 UriComponents uriComponents =
	   UriComponentsBuilder.newInstance()
	   .queryParam("curPage", curPage)
	   .queryParam("perPageNum", criteria.getPostsPerPage())
	   .build();
	   
	 return uriComponents.toUriString();
	}
	
	//toString
	@Override
	public String toString() {
		return "PageVO [totalPost=" + totalPost + ", startPage=" + startPage + ", endPage=" + endPage + ", realEnd="
				+ realEnd + ", prev=" + prev + ", next=" + next + ", displayPage=" + displayPage + ", criteria="
				+ criteria + "]";
	}
	
}