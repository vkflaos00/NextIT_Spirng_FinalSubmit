package com.legend.conv.notice.vo;

public class SearchVO extends PagingVO {

	private String searchType;
	private String searchWord;
	private String searchCategory;

	public SearchVO() {
	}


	public SearchVO(String searchType, String searchWord, String searchCategory, String searchCategory2) {
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
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

	@Override
	public String toString() {
		return "SearchVO [searchType=" + searchType + ", searchWord=" + searchWord + ", searchCategory="
				+ searchCategory+"]";
	}

}
