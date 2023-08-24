package com.legend.conv.member.vo;

public class RegionChartVO {
	private String address1;
	private int count;
	
	@Override
	public String toString() {
		return "AgeChartVO [address1=" + address1 + ", count=" + count + "]";
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
}
