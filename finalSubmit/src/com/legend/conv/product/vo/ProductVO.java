package com.legend.conv.product.vo;

public class ProductVO {
	
	private String itemNo;  		// 제품 품번
	private String itemName;		// 제품 이름
	private int itemPrice;			// 제품 가격
	private String likeFlag;		// 제품 찜
	private String storeType;		// 편의점 구분
	private String storeEvent;		// 할인 행사 구분
	private String itemCategory;	// 제품 분류 (ex. 음료, 식품류 등)
	private String updateDate;		// 업데이트 날짜
	private String imagePath;		// 이미지 경로
	private String chatYn;			// 채팅방 존재 유무
	
	public ProductVO() {
	}

	public ProductVO(String itemNo, String itemName, int itemPrice, String likeFlag, String storeType,
			String storeEvent, String itemCategory, String updateDate, String imagePath, String chatYn) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.likeFlag = likeFlag;
		this.storeType = storeType;
		this.storeEvent = storeEvent;
		this.itemCategory = itemCategory;
		this.updateDate = updateDate;
		this.imagePath = imagePath;
		this.chatYn = chatYn;
	}


	
	@Override
	public String toString() {
		return "ProductVO [itemNo=" + itemNo + ", itemName=" + itemName + ", itemPrice=" + itemPrice + ", likeFlag="
				+ likeFlag + ", storeType=" + storeType + ", storeEvent=" + storeEvent + ", itemCategory="
				+ itemCategory + ", updateDate=" + updateDate + ", imagePath=" + imagePath + ", chatYn=" + chatYn + "]";
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public String getLikeFlag() {
		return likeFlag;
	}

	public void setLikeFlag(String likeFlag) {
		this.likeFlag = likeFlag;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getStoreEvent() {
		return storeEvent;
	}

	public void setStoreEvent(String storeEvent) {
		this.storeEvent = storeEvent;
	}

	public String getItemCategory() {
		return itemCategory;
	}

	public void setItemCategory(String itemCategory) {
		this.itemCategory = itemCategory;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getChatYn() {
		return chatYn;
	}

	public void setChatYn(String chatYn) {
		this.chatYn = chatYn;
	}
	
	
}
