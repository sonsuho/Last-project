<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>
	
	<script type="text/javascript">
		
		function deleteRoom(){
			
			var selectedChatNums = document.getElementsByName("chat_num");

		    for (var i = 0; i < selectedChatNums.length; i++) {
		        if (selectedChatNums[i].checked) {
		            var chatNumValue = selectedChatNums[i].value;

		            if (confirm("해당 스터디 그룹을 삭제하시겠습니까?")) {
		                location.href = "delete.chat?chat_num=" + chatNumValue;
		            }
		            return;
		        }
		    }
		}
		
	</script>
	
	<style type="text/css">
		
		#content {
            display: flex;
            justify-content: center;  
        }
        
        #content div{
        	padding: 50px;
        }
		
    </style>
	
	<!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      	<span class="page-title-icon bg-gradient-primary text-white me-2">
        	<i class="mdi mdi-home"></i>
      	</span> Study Group
    	</h3>
    	<nav aria-label="breadcrumb">
      		<ul class="breadcrumb">
        		<li class="breadcrumb-item active" aria-current="page">
          			<span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
        		</li>
      		</ul>
    	</nav>
  	</div>
	
	<div align="center">
		
		<table border="1">
			<tr align="right">
				<th align="right">
					<a href="make.chat">채팅방 생성</a>
				</th>
			</tr>	
		</table>
		
		<form action="enter.chat">
			
			<div id="content" align="center">
			
				<div align="center">
					
					<h1>채팅방</h1>
					
					<c:if test="${fn:length(clist) != 0}">

						<c:forEach var="room" items="${clist }">
							
							<input type="radio" name="chat_num" value="${room.chat_num}"> ${room.chat_name} <br>
							
						</c:forEach>
					
					</c:if>
					
					<c:if test="${fn:length(clist) == 0}">
						
						채팅방이 없습니다 <br><br><br><br>
						
					</c:if>
						
				</div>
				
				<div align="center">
					
					<h1>내 채팅방</h1>
					
					<c:if test="${fn:length(mylist) != 0}">
					
						<c:forEach var="room" items="${mylist }">
							
							<input type="radio" name="chat_num" value="${room.chat_num}"> ${room.chat_name} <br>
							
						</c:forEach>
						
					</c:if>
					
					<c:if test="${fn:length(mylist) == 0}">
						
						내 채팅방이 없습니다 <br><br><br><br>
						
					</c:if>
					
				</div>
				
			
			</div>
			
			<br><br>
			
			<input type="submit" value="입장하기">

			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<input type="button" value="삭제하기" onclick="deleteRoom()">
			
		</form>
		
	</div>

<%@ include file="studentBottom.jsp"%>
