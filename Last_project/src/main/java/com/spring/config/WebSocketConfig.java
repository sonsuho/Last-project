package com.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{
	
	@Autowired
	private EchoHandler echoHandler;

	@Override																						// WebSocket 기능을 활성화 및 핸들러 등록
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(echoHandler, "ex/echo").setAllowedOrigins("*").withSockJS()		// echoHandler를 controller/echo 경로에 등록
		.setInterceptors(new HttpSessionHandshakeInterceptor())										// WebSocket 핸드셰이크 과정 중 웹소켓용 세션 생성!!!
		.setClientLibraryUrl("localhost:8070/ex/resources/sockjs.min.js");			// 클라이언트에서 사용할 SockJS 라이브러리의 URL을 설정
	}
}
