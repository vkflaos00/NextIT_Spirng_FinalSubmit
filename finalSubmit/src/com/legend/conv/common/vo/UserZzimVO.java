package com.legend.conv.common.vo;

public class UserZzimVO {
	
	private String userId;
	private String itemNo;
	private String zzimYn;
	
	public UserZzimVO() {}

	public UserZzimVO(String userId, String itemNo, String zzimYn) {
		super();
		this.userId = userId;
		this.itemNo = itemNo;
		this.zzimYn = zzimYn;
	}

	@Override
	public String toString() {
		return "UserZzimVO [userId=" + userId + ", itemNo=" + itemNo + ", zzimYn=" + zzimYn + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getZzimYn() {
		return zzimYn;
	}

	public void setZzimYn(String zzimYn) {
		this.zzimYn = zzimYn;
	}
	
	
}
