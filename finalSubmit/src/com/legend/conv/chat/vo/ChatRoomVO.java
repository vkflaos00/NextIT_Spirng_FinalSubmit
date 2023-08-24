package com.legend.conv.chat.vo;

public class ChatRoomVO {
	
	private String roomId;
	private String productName;
	private String createdDate;
	private String closedDate;
	private int userCount;
	private String chatYn;
	
	public ChatRoomVO() {}
	
	public ChatRoomVO(String roomId, String productName, String createdDate, String closedDate, int userCount,
			String chatYn) {
		super();
		this.roomId = roomId;
		this.productName = productName;
		this.createdDate = createdDate;
		this.closedDate = closedDate;
		this.userCount = userCount;
		this.chatYn = chatYn;
	}

	@Override
	public String toString() {
		return "ChatRoomVO [roomId=" + roomId + ", productName=" + productName + ", createdDate=" + createdDate
				+ ", closedDate=" + closedDate + ", userCount=" + userCount + ", chatYn=" + chatYn + "]";
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getClosedDate() {
		return closedDate;
	}

	public void setClosedDate(String closedDate) {
		this.closedDate = closedDate;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public String getChatYn() {
		return chatYn;
	}

	public void setChatYn(String chatYn) {
		this.chatYn = chatYn;
	}
	
}
