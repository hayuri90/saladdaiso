package com.proj.salad.review.vo;

public class SearchCriteria extends Criteria {
	
	private String searchType = ""; //검색타입
	private String keyword = ""; //검색어
	
	//getter, setter
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	//toString
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}	
	
}