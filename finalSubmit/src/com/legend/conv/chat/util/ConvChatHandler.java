package com.legend.conv.chat.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ConvChatHandler extends TextWebSocketHandler{
	
	// 여러개의 웹소켓 세션을 담도록 리스트를 생성한다.
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 연결되었을때
		System.out.println("연결됨 : " + session.getId());
		sessionList.add(session);
		int userCount = sessionList.size();
		System.out.println("연결된갯수: " + userCount);
		String userCountMessage = "userCount:" + userCount;
		for (WebSocketSession webSocketSession : sessionList) {
	        if (webSocketSession.isOpen()) { // 세션이 열려있을 때에만 전송
	            webSocketSession.sendMessage(new TextMessage(userCountMessage));
	        }
	    }
		super.afterConnectionEstablished(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 연결끊었을때
		// 유저가 접속을 끊었을 때, 접속 인원 수 갱신 및 클라이언트에 전송
		sessionList.remove(session);
		System.out.println("연결끊김 : " + session.getId());
		int userCount = sessionList.size();
	    String userCountMessage = "userCount:" + userCount;
	    for (WebSocketSession webSocketSession : sessionList) {
	        if (webSocketSession.isOpen()) { // 세션이 열려있을 때에만 전송
	            webSocketSession.sendMessage(new TextMessage(userCountMessage));
	        }
	    }
		super.afterConnectionClosed(session, status);
	}
	
	// 클라이언트(브라우저)에서 서버로 메시지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메시지가 들어오는 부분
		String strMessage = message.getPayload();
		System.out.println("메시지" + strMessage);
		
		// 연결된 세션들에게 메시지를 보낼때
		// 현재 시간도 보내보자.
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(new Date());
		strMessage+="|" + strDate;
		
		for (WebSocketSession webSocketSession : sessionList) {
			if (webSocketSession.isOpen()) { // 세션이 열려있을 때에만 전송
				webSocketSession.sendMessage(new TextMessage(strMessage));
			}
		}
		super.handleTextMessage(session, message);
	}
}
