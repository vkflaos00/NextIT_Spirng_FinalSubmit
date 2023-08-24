//package com.legend.conv.chat.util;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import org.apache.commons.lang3.StringUtils;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//import com.legend.conv.member.vo.MemberVO;
//
//public class ConvWebSocketHandler extends TextWebSocketHandler {
//
////	 private final Logger logger = LoggerFactory.getLogger(this.getClass());
////	 
////	 //연결된 모든 sessions 저장 List<WebSocketSession> sessions = new ArrayList<>();
////	 //userId의 webSession을 저장한다 Map<String, WebSocketSession> userSessions = new
////	 HashMap<>();
////	 
//	// 클라이언트 접속 성공 시 연결 성공시
//
//	@Override
//	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		// 클라이언트 연결이 확립된 후 실행되는 메소드
//		System.out.println("연결됨 :" + session.getId());
//		super.afterConnectionEstablished(session);
////	 sessions.add(session);
////	 
////	 //userId 알아내기 Map<String, Object> sessionVal = session.getAttributes();
////	 MemberVO memberVO = (MemberVO) sessionVal.get("login");
////	 System.out.println(memberVO.getId()); String userId = memberVO.getId();
////	 
////	 if(userSessions.get(userId) != null) { //userId에 원래 웹세션값이 저장되어 있다면 update
////	 userSessions.replace(userId, session); } else { //userId에 웹세션값이 없다면 put
////	 userSessions.put(userId, session); } }
////	 
////	 //소켓에 메시지를 보냈을때 js에서 on.message
////	 
////	 @Override protected void handleTextMessage(WebSocketSession session,
////	 TextMessage message) throws Exception { // 클라이언트로부터 텍스트 메시지를 받았을 때 실행되는 메소드
////	 System.out.println("handleTextmessage: " + session + " : " + message);
////	 
////	 //protocol: 내용, 보내는id, 받는id (content, requestId, responseId) String msg =
////	 message.getPayload(); if(StringUtils.isNotEmpty(msg)) { String[] strs =
////	 msg.split(","); if (strs != null && strs.length == 3) { String sendId =
////	 strs[0]; String receiveUserId = strs[1]; String content = strs[2];
////	 
////	 //broadcasting if(receiveUserId.equals("")) { for (WebSocketSession sess:
////	 sessions) { //message를 TextMessage형태로 받음 (22번째줄, string x)
////	 sess.sendMessage(new TextMessage(receiveUserId + ":" +
////	 message.getPayload())); } } else { WebSocketSession responseIdSession =
////	 userSessions.get(receiveUserId); if (responseIdSession != null) { TextMessage
////	 tmpMsg = new TextMessage(sendId + "," + receiveUserId + "," + content);
////	 responseIdSession.sendMessage(tmpMsg); } }
////	 
////	 } }
////	 
//	}
////	 
////	 
////	 //소켓이 close 됐을 때
////	 
//	 @Override 
//	 public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { 
//		 // 클라이언트 연결이 종료되었을 때 실행되는 메소드
////	 	sessions.remove(session); 
//		 System.out.println("연결끊김: " + session.getId()); 
//		 super.afterConnectionClosed(session, status);
////	 
////	 // 예외 발생 시 호출됩니다.
////	 
////	 @Override public void handleTransportError(WebSocketSession session,
////	 Throwable exception) throws Exception { super.handleTransportError(session,
////	 exception); System.err.println("WebSocket 통신 중 에러 발생: " +
////	 exception.getMessage()); 
//	 }
//
//}
