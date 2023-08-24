package com.legend.conv.product.vo;

public class ProductChartVO {
	private String storeType;
	private int count;
	
	public ProductChartVO () {}

	public ProductChartVO(String storeType, int count) {
		super();
		this.storeType = storeType;
		this.count = count;
	}

	@Override
	public String toString() {
		return "ProductChartVO [storeType=" + storeType + ", count=" + count + "]";
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	
	
}
