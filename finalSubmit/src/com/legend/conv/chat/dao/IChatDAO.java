package com.legend.conv.chat.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.legend.conv.chat.vo.ChatRoomVO;
import com.legend.conv.chat.vo.ChatUserVO;

@Mapper
public interface IChatDAO {
	
	// room Id 만들기
	public String getCreatedChatRoomId();
	
	// 채팅방 오픈
	public int createChatRoom(@Param("roomId")String roomId, @Param("itemNo")String itemNo);
	
	// 오픈된 채팅방 사용자 등록
	public int addUserToChatRoom(ChatUserVO chatUserVO);
	
	// 채팅방 존재 유무 확인
	public ChatRoomVO getChatRoomByItemNo(String itemNo);
	
	// 이미 채팅방이 존재하는 경우 userCount 증가
	public int increaseUserCount(String roomId);
	
	// 채팅 유저 정보 삭제
	public int removeUserFromChatRoom(@Param("roomId") String roomId,@Param("userId") String userId);
	
	// chatroom의 userCount 업데이트
	public int decreaseUserCount(String roomId);
	
	// 채팅방 인원 0명일 때 chat_yn 변경
	public int updateChatYn(String roomId);
	
	// 현재 채팅방인원 확인하는 쿼리
	public int getUserCount(String roomId);
	
}
