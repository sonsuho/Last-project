package com.spring.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();						// 현재 연결된 모든 WebSocket 세션을 저장하는 리스트
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {					// 새로운 WebSocket 연결이 열릴 때 해당 연결 session을 리스트에 추가
		sessionList.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {	// 클라이언트로부터 텍스트 메시지를 수신할 때
		
		String[] parts = message.getPayload().split("/");
		
		String loginInfo = parts[0];
		String content = parts[1];
        String chat_num = parts[2];
		
		for(WebSocketSession sess: sessionList) {
			sess.sendMessage(new TextMessage(loginInfo + "/" + content + "/" + chat_num));				// 리스트의 모든 세션에게 해당 메시지를 전달
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {	// 특정 클라이언트 WebSocket 연결이 닫힐 때 ... 즉 나갈 때
		sessionList.remove(session);
	}																									// 리스트에서 해당 session을 제거
}
