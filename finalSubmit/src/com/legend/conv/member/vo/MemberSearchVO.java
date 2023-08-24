package com.legend.conv.member.vo;

import com.legend.conv.common.vo.PagingVO;

public class MemberSearchVO extends PagingVO{
	
	private String searchType;
	private String searchWord;
	
	public MemberSearchVO() {}

	public MemberSearchVO(String searchType, String searchWord) {
		super();
		this.searchType = searchType;
		this.searchWord = searchWord;
	}

	@Override
	public String toString() {
		return "MemberSearchVO [searchType=" + searchType + ", searchWord=" + searchWord + "]" +super.toString();
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
	
	
}
