package com.legend.conv.common.vo;

public class SearchVO extends PagingVO{

	private String searchType;
	private String searchWord;
	private String searchCategory;

	private String boCate; // 카테고리를 문자열로 받습니다.

	
	public String getBoCate() {
		return boCate;
	}

	public void setBoCate(String boCate) {
		this.boCate = boCate;
	}

	public SearchVO() {
		super();
	}
	
	public SearchVO(String searchType, String searchWord, String searchCategory, String searchStore,String boCate) {
		super();
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
		this.boCate = boCate;
	}

	@Override
	public String toString() {
		return "SearchVO [searchType=" + searchType + ", searchWord=" + searchWord + ", searchCategory="
				+ searchCategory + ", boCate=" + boCate + super.toString()+"]";
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}

	
}
