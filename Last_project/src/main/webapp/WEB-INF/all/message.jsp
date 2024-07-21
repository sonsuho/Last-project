<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>


    <!-- 메신저알림 -->
    <!-- 최신 메시지 3개 노출 -->
    
    <li class="nav-item dropdown">
      <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="mdi mdi-email-outline"></i>
        <!-- 새로운 메시지가 하나라도 있으면 표시 -->
          <span class="count-symbol msg-count-symbol"></span>
      </a>
      
      <div id="topMenuMessageList" class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list" aria-labelledby="messageDropdown">
        <h6 class="p-3 mb-0">메시지</h6>
        <div class="dropdown-divider"></div>
        <div id="topMenuMessageItem">
        
        <!-- ajax 데이터 들어 옴 -->
        
        </div>
        
        <!-- 받은 메세지함으로 이동 -->
        <h6 class="p-3 mb-0 text-center">
        	<a href="rlist.messenger">메세지 더보기</a>
        	<!-- <a href="Messenger.manager">메세지 더보기</a> -->
        </h6>
      </div>
    </li>
    
    
    
    
