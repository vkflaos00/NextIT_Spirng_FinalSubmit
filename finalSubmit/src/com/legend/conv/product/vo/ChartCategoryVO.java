package com.legend.conv.product.vo;

public class ChartCategoryVO {
	private String itemCategory;
	private int count;
	
	public ChartCategoryVO() {
	}

	public ChartCategoryVO(String itemCategory, int count) {
		super();
		this.itemCategory = itemCategory;
		this.count = count;
	}

	@Override
	public String toString() {
		return "ProductCategoryVO [itemCategory=" + itemCategory + ", count=" + count + "]";
	}

	public String getItemCategory() {
		return itemCategory;
	}

	public void setItemCategory(String itemCategory) {
		this.itemCategory = itemCategory;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
	
}
