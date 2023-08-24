package com.legend.conv.member.vo;

public class AgeChartVO {
	private String age;
	private int count;
	
	@Override
	public String toString() {
		return "AgeChartVO [age=" + age + ", count=" + count + "]";
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
	
}
