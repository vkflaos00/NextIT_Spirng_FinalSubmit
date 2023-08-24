package com.legend.conv.product.vo;

import com.legend.conv.common.vo.PagingVO;

public class ProductSearchVO extends PagingVO{
	
	private String searchWord;
	private String searchCategory;
	private String searchEvent;
	private String searchStore;
	
	@Override
	public String toString() {
		return "ProductSearchVO [searchWord=" + searchWord + ", searchCategory=" + searchCategory + ", searchEvent="
				+ searchEvent + ", searchStore=" + searchStore + "]" + super.toString();
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

	public String getSearchEvent() {
		return searchEvent;
	}

	public void setSearchEvent(String searchEvent) {
		this.searchEvent = searchEvent;
	}

	public String getSearchStore() {
		return searchStore;
	}

	public void setSearchStore(String searchStore) {
		this.searchStore = searchStore;
	}
	
	
	
}
