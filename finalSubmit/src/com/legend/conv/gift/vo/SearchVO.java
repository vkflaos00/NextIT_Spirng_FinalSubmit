package com.legend.conv.gift.vo;

public class SearchVO extends PagingVO {

	private String searchType;
	private String searchWord;
	private String searchCategory;
	private String searchCategory2;
	private String id;
	private String searchBtn;

	public SearchVO() {
	}

	public SearchVO(String searchType, String searchWord, String searchCategory, String searchCategory2, String id,
			String searchBtn) {
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
		this.searchCategory2 = searchCategory2;
		this.id = id;
		this.searchBtn = searchBtn;
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

	public String getSearchCategory2() {
		return searchCategory2;
	}

	public void setSearchCategory2(String searchCategory2) {
		this.searchCategory2 = searchCategory2;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSearchBtn() {
		return searchBtn;
	}

	public void setSearchBtn(String searchBtn) {
		this.searchBtn = searchBtn;
	}

	@Override
	public String toString() {
		return "SearchVO [searchType=" + searchType + ", searchWord=" + searchWord + ", searchCategory="
				+ searchCategory + ", searchCategory2=" + searchCategory2 + ", id=" + id + ", searchBtn=" + searchBtn
				+ "]";
	}

	
}
