package com.proj.salad.review.vo;

//현재페이지에 관한 데이터를 담고 있는 클래스로, 목록조회 쿼리에 데이터 전달
public class Criteria {
	private int curPage;		//현재페이지
	private int postsPerPage;	//페이지당 게시글 수
	private int rowStart;		//현재페이지의 시작게시물 번호
	private int rowEnd;			//현재페이지의 마지막게시물 번호
	
	public Criteria() { 		//Criteria 디폴트 생성자 
		this.curPage=1;			//현재 페이지를 1페이지로 설정
		this.postsPerPage=10;	//한 페이지에 10개의 게시물 배치
	}
	
	//getter, setter
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		if(curPage<=0) {		//페이지가 없을 때
			this.curPage = 1;	//1로 맞춰줌
			return;
		}
		this.curPage=curPage;	
	}

	public int getPostsPerPage() {
		return postsPerPage;
	}

	public void setPostsPerPage(int postsPerPage) {
		if(postsPerPage<=0 || postsPerPage>100) { 	//페이지당 게시글 수가 0보다 적거나 100보다 많으면
			this.postsPerPage=10;
			return;
		}
		this.postsPerPage=postsPerPage;
	}
	
	//getRowStart(), getRowEnd(): 게시글을 몇 번부터 몇 번까지 출력할지 계산하는 메서드
	//curPage, postsPerPage를 이용해 DB에서 페이지에 내보낼 수를 계산
	public int getRowStart() {
		rowStart=((curPage-1) * postsPerPage) +1;	// ((1-1)*10)+1=1, ((2-1)*10)+1=11, ((3-1)*10)+1=21
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd=rowStart+postsPerPage-1;	//1+10-1=10, 11+10-1=20, 21+10-1=30
		return rowEnd;
	}

	//toString
	@Override
	public String toString() {
		return "Criteria [curPage=" + curPage + ", postsPerPage=" + postsPerPage + ", rowStart=" + rowStart
				+ ", rowEnd=" + rowEnd + "]";
	}
	
}