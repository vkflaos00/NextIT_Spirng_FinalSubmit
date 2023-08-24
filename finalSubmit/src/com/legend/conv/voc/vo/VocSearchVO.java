package com.legend.conv.voc.vo;

import com.legend.conv.common.vo.PagingVO;

public class VocSearchVO extends PagingVO{
	
	private String searchType;
	private String searchWord;
	private String searchCategory;
	
	public VocSearchVO() {}

	public VocSearchVO(String searchType, String searchWord, String searchCategory) {
		super();
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
	}

	@Override
	public String toString() {
		return "VocSearchVO [searchType=" + searchType + ", searchWord=" + searchWord + ", searchCategory="
				+ searchCategory + "]" + super.toString();
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
