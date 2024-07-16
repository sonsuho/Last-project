<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
    <!-- 메신저알림 -->
    <!-- 최신 메시지 3개 노출 -->
    
    <li class="nav-item dropdown">
      <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" onclick="unreadMsg()" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="mdi mdi-email-outline"></i>
        <!-- 새로운 메시지가 하나라도 있으면 표시 -->
        <c:forEach var="r_msg" items="${reclist }">
          <c:choose>
	          <c:when test="${r_msg.read_chk == 0 }">
		          <span class="count-symbol bg-danger"></span>
	          </c:when>
	          <c:otherwise>
	          	 <span></span>
	          </c:otherwise>
          </c:choose>
        </c:forEach>
      </a>
      
      <div class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list" aria-labelledby="messageDropdown">
        <h6 class="p-3 mb-0">메시지</h6>
        <div class="dropdown-divider"></div>
        
        <c:forEach var="r_msg" items="${reclist }">
          <c:choose>
          	<c:when test="${r_msg.read_chk == 1 }">
          	  <a class="dropdown-item preview-item" style="background:#f6f6f6;" href="rlist.messenger">
	            <div class="preview-thumbnail">
	              <img src="resources/assets/images/faces/face4.jpg" alt="image" class="profile-pic">
	            </div>
	            <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
	              <h6 class="preview-subject ellipsis mb-1 font-weight-normal">
	                <b>${r_msg.send_name }</b>님이 메시지를 보냈습니다.
	              </h6>
	              <p class="text-gray mb-0">${r_msg.send_time}</p>
	            </div>
	          </a>  
          	</c:when>
          	<c:otherwise>
          	  <a class="dropdown-item preview-item" href="rlist.messenger">
	            <div class="preview-thumbnail">
	              <img src="resources/assets/images/faces/face4.jpg" alt="image" class="profile-pic">
	            </div>
	            <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
	              <h6 class="preview-subject ellipsis mb-1 font-weight-normal">
	              	<b>${r_msg.send_name }</b>님이 메시지를 보냈습니다.
	              </h6>
	              <p class="text-gray mb-0">${r_msg.send_time}</p>
	            </div>
	          </a>  
          	</c:otherwise>
          </c:choose>
        </c:forEach>
        
<!--                 
        <div class="dropdown-divider"></div>
        <a class="dropdown-item preview-item">
          <div class="preview-thumbnail">
            <img src="resources/assets/images/faces/face2.jpg" alt="image" class="profile-pic">
          </div>
          <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
            <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Cregh send you a message</h6>
            <p class="text-gray mb-0"> 15 Minutes ago </p>
          </div>
        </a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item preview-item">
          <div class="preview-thumbnail">
            <img src="resources/assets/images/faces/face3.jpg" alt="image" class="profile-pic">
          </div>
          <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
            <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Profile picture updated</h6>
            <p class="text-gray mb-0"> 18 Minutes ago </p>
          </div>
        </a>
        <div class="dropdown-divider"></div> 
-->
        
        <!-- 받은 메세지함으로 이동 -->
        <h6 class="p-3 mb-0 text-center">
        	<a href="rlist.messenger">메세지 더보기</a>
        	<!-- <a href="Messenger.manager">메세지 더보기</a> -->
        </h6>
      </div>
    </li>
    
    
    
    
    
    
<script>
	$(document).ready(function(){
		unreadMsg()
		
		function unreadMsg(){
			$.ajax({
	            url: '/unreadMessages',
	            type: 'GET',
	            dataType: 'json',
	            success: function(messages) {
	                // 성공적으로 메시지를 받아왔을 때 처리
	                console.log('Received unread messages:', messages);
	                
	                // 메시지를 화면에 표시하는 예시
	                var messageList = $('#unreadMessageList');
	                messageList.empty(); // 기존 리스트 초기화
	                
	                $.each(messages, function(index, message) {
	                    var listItem = $('<li>').text(message.sender + ': ' + message.message_text);
	                    messageList.append(listItem);
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('Error fetching unread messages:', error);
	            }
	        });
		}
	})
</script>
    