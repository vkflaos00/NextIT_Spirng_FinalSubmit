//package com.legend.conv.chat.util;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.websocket.OnClose;
//import javax.websocket.OnError;
//import javax.websocket.OnMessage;
//import javax.websocket.OnOpen;
//import javax.websocket.Session;
//import javax.websocket.server.PathParam;
//import javax.websocket.server.ServerEndpoint;
//
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//@ServerEndpoint("/conv/chatserver")
//public class ChatServer {
//	
//	// 현재 채팅 서버에 접속한 클라이언트(WebSocket Session) 목록
//	// static 붙여야함!!
//	private static List<Session> list = new ArrayList<Session>();
//	
//	//userId의 webSession을 저장한다
//	Map<String, WebSocketSession> userSessions = new HashMap<>();
//	
//	private void print(String msg) {
//		System.out.printf("[%tT] %s\n", Calendar.getInstance(), msg);
//	}
//	
//	@OnOpen
//	public void handleOpen(Session session, @PathParam("userId") String userId) {
//		print("클라이언트 연결");
//		list.add(session); // 접속자 관리(****)
//		
//		if (userSessions.get(userId) != null) {
//	        // userId에 원래 웹세션값이 저장되어 있다면 update
//	        userSessions.replace(userId, session);
//	    } else {
//	        // userId에 웹세션값이 없다면 put
//	        userSessions.put(userId, session);
//	    }
//	}
//	
//	@OnMessage
//	public void handleMessage(String msg, Session session) {
//		System.out.println("msg: " + msg);
//		// 로그인할 때: 1#유저명
//		// 대화  할 때: 2유저명#메세지		
//		int index = msg.indexOf("#", 2);
//		System.out.println("index: " + index);
//		String no = msg.substring(0, 1); 
//		System.out.println("no: " + no);
//		String user = msg.substring(2, index);
//		System.out.println("user: " + user);
//		String txt = msg.substring(index + 1);
//		System.out.println("index, no, user, txt" + index + no + user + txt);
//		
//		if (no.equals("1")) {
//			// 누군가 접속 > 1#아무개
//			for (Session s : list) {
//				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
//					
//					try {
//						s.getBasicRemote().sendText("1#" + user + "#");
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//					
//				}
//			}
//			
//		} else if (no.equals("2")) {
//			// 누군가 메세지를 전송
//			for (Session s : list) {
//				
//				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
//					try {
//						s.getBasicRemote().sendText("2#" + user + ":" + txt);
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//					
//				}
//				
//			} 
//		} else if (no.equals("3")) {
//			// 누군가 접속 > 3#아무개
//			for (Session s : list) {
//				
//				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
//					try {
//						s.getBasicRemote().sendText("3#" + user + "#");
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//				}
//				
//			}
//		}
//		
//	}
//	
//	@OnClose
//	public void handleClose(Session session) {
//		list.remove(session);
//	}
//	
//	@OnError
//	public void handleError(Throwable t) {
//		t.printStackTrace();
//	}
//
//}