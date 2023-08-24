package com.legend.conv.common.vo;

public class HitVO {
	private String hitId;
	private String hitYype;
	private String hitNo;
	private String hitYn;
	
	public HitVO(String hitId, String hitYype, String hitNo, String hitYn) {
		this.hitId = hitId;
		this.hitYype = hitYype;
		this.hitNo = hitNo;
		this.hitYn = hitYn;
	}

	public HitVO() {	}

	public String getHitId() {
		return hitId;
	}

	public void setHitId(String hitId) {
		this.hitId = hitId;
	}

	public String getHitYype() {
		return hitYype;
	}

	public void setHitYype(String hitYype) {
		this.hitYype = hitYype;
	}

	public String getHitNo() {
		return hitNo;
	}

	public void setHitNo(String hitNo) {
		this.hitNo = hitNo;
	}

	public String getHitYn() {
		return hitYn;
	}

	public void setHitYn(String hitYn) {
		this.hitYn = hitYn;
	}

	@Override
	public String toString() {
		return "HitVO [hitId=" + hitId + ", hitYype=" + hitYype + ", hitNo=" + hitNo + ", hitYn=" + hitYn + "]";
	}
	
	
}
