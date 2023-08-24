package com.legend.conv.chat.vo;

public class ChatUserVO {
	
	private String userId;
	private String roomId;
	private String userName;
	
	public ChatUserVO() {
	}

	public ChatUserVO(String userId, String roomId, String userName) {
		this.userId = userId;
		this.roomId = roomId;
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "ChatUser [userId=" + userId + ", roomId=" + roomId + ", userName=" + userName + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
