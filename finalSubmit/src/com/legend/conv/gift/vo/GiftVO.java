package com.legend.conv.gift.vo;

public class GiftVO {
	
	private int giftNo;
	private String giftType;
	private String giftCate;
	private String giftName;
	private int giftPrice;
	private int giftHit;
	private String giftSrc;
	private String giftDetail;
	private String giftNotice;
	private int cartCount;
	private String giftId;
	private int giftCount;
	
	public GiftVO() {}

	public GiftVO(int giftNo, String giftType, String giftCate, String giftName, int giftPrice, int giftHit,
			String giftSrc, String giftDetail, String giftNotice, int cartCount, String giftId, int giftCount) {
		this.giftNo = giftNo;
		this.giftType = giftType;
		this.giftCate = giftCate;
		this.giftName = giftName;
		this.giftPrice = giftPrice;
		this.giftHit = giftHit;
		this.giftSrc = giftSrc;
		this.giftDetail = giftDetail;
		this.giftNotice = giftNotice;
		this.cartCount = cartCount;
		this.giftId = giftId;
		this.giftCount = giftCount;
	}

	public int getGiftNo() {
		return giftNo;
	}

	public void setGiftNo(int giftNo) {
		this.giftNo = giftNo;
	}

	public String getGiftType() {
		return giftType;
	}

	public void setGiftType(String giftType) {
		this.giftType = giftType;
	}

	public String getGiftCate() {
		return giftCate;
	}

	public void setGiftCate(String giftCate) {
		this.giftCate = giftCate;
	}

	public String getGiftName() {
		return giftName;
	}

	public void setGiftName(String giftName) {
		this.giftName = giftName;
	}

	public int getGiftPrice() {
		return giftPrice;
	}

	public void setGiftPrice(int giftPrice) {
		this.giftPrice = giftPrice;
	}

	public int getGiftHit() {
		return giftHit;
	}

	public void setGiftHit(int giftHit) {
		this.giftHit = giftHit;
	}

	public String getGiftSrc() {
		return giftSrc;
	}

	public void setGiftSrc(String giftSrc) {
		this.giftSrc = giftSrc;
	}

	public String getGiftDetail() {
		return giftDetail;
	}

	public void setGiftDetail(String giftDetail) {
		this.giftDetail = giftDetail;
	}

	public String getGiftNotice() {
		return giftNotice;
	}

	public void setGiftNotice(String giftNotice) {
		this.giftNotice = giftNotice;
	}

	public int getCartCount() {
		return cartCount;
	}

	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}

	public String getGiftId() {
		return giftId;
	}

	public void setGiftId(String giftId) {
		this.giftId = giftId;
	}

	public int getGiftCount() {
		return giftCount;
	}

	public void setGiftCount(int giftCount) {
		this.giftCount = giftCount;
	}

	@Override
	public String toString() {
		return "GiftVO [giftNo=" + giftNo + ", giftType=" + giftType + ", giftCate=" + giftCate + ", giftName="
				+ giftName + ", giftPrice=" + giftPrice + ", giftHit=" + giftHit + ", giftSrc=" + giftSrc
				+ ", giftDetail=" + giftDetail + ", giftNotice=" + giftNotice + ", cartCount=" + cartCount + ", giftId="
				+ giftId + ", giftCount=" + giftCount + "]";
	}

	

}