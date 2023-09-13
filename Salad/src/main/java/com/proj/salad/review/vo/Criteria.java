package com.proj.salad.review.vo;

//한 페이지의 기준이 되는 클래스
//페이징이 적용된 게시판을 조회하기 위한 파라미터를 담아놓은 클래스
//=게시글 조회 쿼리에 전달할 데이터를 담을 클래스
public class Criteria {
	private int curPage;			//현재페이지
	private int postsPerPage;		//페이지당 게시글 수
	private int rowStart;			//현재페이지의 시작게시물 번호
	private int rowEnd;				//현재페이지의 마지막게시물 번호
	
	public Criteria() { //Criteria 디폴트 생성자 
		this.curPage=1;			//현재 페이지를 1페이지로 설정
		this.postsPerPage=10;	//한 페이지에 10개의 게시물 배치
	}
	
	//getter, setter
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		if(curPage<=0) {		
			this.curPage = 1;	
			return;
		}
		this.curPage=curPage;	
	}

	public int getPostsPerPage() {
		return postsPerPage;
	}

	public void setPostsPerPage(int postsPerPage) {
		if(postsPerPage<=0 || postsPerPage>100) { //페이지당 게시글 수가 0보다 적거나 100보다 많으면
			this.postsPerPage=10;
			return;
		}
		this.postsPerPage=postsPerPage;
	}	
	
	public int getRowStart() {
		rowStart=((curPage-1) * postsPerPage) +1;
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd=rowStart+postsPerPage-1;
		return rowEnd;
	}

	//toString
	@Override
	public String toString() {
		return "Criteria [curPage=" + curPage + ", postsPerPage=" + postsPerPage + ", rowStart=" + rowStart
				+ ", rowEnd=" + rowEnd + "]";
	}
	
}