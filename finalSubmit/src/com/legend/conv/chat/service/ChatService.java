package com.legend.conv.chat.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.legend.conv.chat.dao.IChatDAO;
import com.legend.conv.chat.vo.ChatRoomVO;
import com.legend.conv.chat.vo.ChatUserVO;
import com.legend.conv.exception.BizNotEffectedException;
import com.legend.conv.member.vo.MemberVO;

@Service
public class ChatService {
	
	@Autowired
	private IChatDAO dao;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void createChatRoomAndAddUser(String itemNo, ChatUserVO chatUserVO, HttpSession session) throws BizNotEffectedException {
		
		// 이미 채팅방이 존재하는지 확인
		ChatRoomVO existingChatRoom = dao.getChatRoomByItemNo(itemNo);
		if(existingChatRoom != null) {
			// 이미 채팅방이 존재하는 경우, 유저만 추가
			chatUserVO.setRoomId(existingChatRoom.getRoomId());
			
			// 로그인된 사용자 정보 추출
			MemberVO member = ((MemberVO) session.getAttribute("login"));
	        String userId = member.getId();
	        String userName = member.getName();
	        
	        chatUserVO.setUserId(userId);
	        chatUserVO.setUserName(userName);
	        
	        // chatuser 정보 등록
	        dao.addUserToChatRoom(chatUserVO);
	        
	        // 채팅방 존재시 해당 챗팅방 유저카운트 증가
	        dao.increaseUserCount(existingChatRoom.getRoomId());
		} else {
			// roomid 만들기
			String roomId = dao.getCreatedChatRoomId();
			
			// 채팅방 생성
			int resultCnt1 = dao.createChatRoom(roomId,itemNo);
			
			if(resultCnt1 != 1) {
				throw new BizNotEffectedException();
			}
			
			// 로그인된 사용자 정보 추출
			MemberVO member = ((MemberVO) session.getAttribute("login"));
			logger.info(member.toString());
			String userId = member.getId();
			String userName = member.getName();
			
			// chatUserVO 에 값 셋팅
			chatUserVO.setRoomId(roomId);
			chatUserVO.setUserId(userId);
			chatUserVO.setUserName(userName);
			
			// chatUser 정보 등록
			int resultCnt2 = dao.addUserToChatRoom(chatUserVO);
			
			if(resultCnt2 != 1) {
				throw new BizNotEffectedException();
			}
			
		}
		
	}
	
	// 사용자가 채팅방에서 나갈 때의 로직을 처리하는 메소드
	public void userExitChatRoom(String roomId, String userId) {
		// chatUser 정보 삭제
		logger.info("roomId,userId:" + roomId + userId);
		int resultCnt1 = dao.removeUserFromChatRoom(roomId, userId);
		
		// chatRoom의 userCount 업데이트 및 chat_yn 변경
		int updatedUserCount = dao.decreaseUserCount(roomId);
		if (updatedUserCount > 0) {
		    int currentUserCount = dao.getUserCount(roomId);
		    if (currentUserCount == 0) {
		        dao.updateChatYn(roomId);
		    }
		}
	}
	
}
