package com.proj.salad.notice.vo;

public class Criteria {
	private int curPage;				//현재페이지
	private int postsPerPage;		//페이지당 게시글 수
	private int rowStart;				//현재페이지의 시작게시물 번호
	private int rowEnd;				//현재페이지의 마지막게시물 번호
	
	public Criteria() {
		this.curPage=1;
		this.postsPerPage=10;
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
		if(postsPerPage<=0 || postsPerPage>100) {
			this.postsPerPage=10;
			return;
		}
		this.postsPerPage=postsPerPage;
	}	
	
	public int getPageStart() {
		return (this.curPage-1) * postsPerPage;
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