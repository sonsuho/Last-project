<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../student/studentTop.jsp"%>
    
<style type="text/css">
    /* Flexbox container for centering content */
    #content {
        display: flex;
        justify-content: center;
        align-items: flex-start; /* Align items to the start to maintain the top alignment */
        flex-wrap: wrap; /* Allow items to wrap */
        gap: 40px; /* Add gap between flex items */
    }
    
    /* Individual chat room sections */
    .chat-section {
        margin: 20px;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        width: 300px;
        background-color: #f8f9fa;
        min-height: 400px; /* Fixed height */
        display: flex;
        flex-direction: column;
        justify-content: flex-start; /* Align items to the top within the section */
    }
    
    .chat-section h1 {
        font-size: 1.5rem;
        color: #007bff;
        margin-bottom: 10px;
    }
    
    .chat-room {
        flex: 1; /* Allow the chat-room div to grow to fill available space */
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #ffffff;
        cursor: pointer;
        display: flex;
        justify-content: center; /* Center items horizontally */
        align-items: center; /* Center items vertically */
    }
    
    .chat-room:hover {
        background-color: #e9ecef;
    }
    
    /* Ensure radio buttons are properly aligned */
    .chat-room-radio {
        display: flex;
        align-items: center; /* Center items vertically */
        margin-right: 10px;
    }

    /* Control the width of the chat-room divs */
    .chat-room-container {
        display: flex;
        align-items: center;
        width: 100%; /* Ensure the container takes up the full width of the chat-section */
    }
</style>


<script type="text/javascript">
    function deleteRoom() {
        var selectedRoom = document.querySelector('input[name="chat_num"]:checked');
        if (!selectedRoom) {
            alert('삭제할 채팅방을 선택해 주세요.');
            return false;
        }
        var chatNum = selectedRoom.value;
        var myChatRooms = [
            <c:forEach var="room" items="${mylist}" varStatus="loop">
                ${room.chat_num}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        if (myChatRooms.includes(parseInt(chatNum))) {
            location.href="delete.chat?chat_num=" + chatNum;
        } else {
            alert('다른 사용자의 채팅방은 삭제할 수 없습니다.');
            return false;
        }
    }

    function enterChatRoom(chatNum) {
        location.href = 'enter.chat?chat_num=' + chatNum;
    }
</script>

<!-- header -->
<div class="page-header">
    <h3 class="page-title">
        <span class="page-title-icon bg-gradient-primary text-white me-2">
            <i class="mdi mdi-pencil-box"></i>
        </span> Study Group List
    </h3>
    <nav aria-label="breadcrumb">
        <ul class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">
                <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
            </li>
        </ul>
    </nav>
</div>

<div class="row">
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <h2 align="left" style="margin-left: 50px">스터디그룹 목록
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;               
                   &nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-gradient-success py-3" onclick="location.href='make.chat'">CREATE</button>
                    &nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-gradient-info py-3" onclick="return deleteRoom()">DELETE</button>
                </h2>
                <br>
                <div align="center">
                    <div id="content">
                        <div class="chat-section">
                            <h1>채팅방</h1> <br><br>
                            <c:if test="${fn:length(clist) != 0}">
                                <c:forEach var="room" items="${clist}">
                                    <div class="chat-room-container">
                                        <div class="chat-room-radio">
                                            <input type="radio" name="chat_num" value="${room.chat_num}">
                                        </div>
                                        <div class="chat-room" align="left" onclick="enterChatRoom(${room.chat_num})">
                                            <span>${room.chat_name}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${fn:length(clist) == 0}">
                                <p>채팅방이 없습니다.</p>
                            </c:if>
                        </div>
                        <div class="chat-section">
                            <h1>내 채팅방</h1> <br><br>
                            <c:if test="${fn:length(mylist) != 0}">
                                <c:forEach var="room" items="${mylist}">
                                    <div class="chat-room-container">
                                        <div class="chat-room-radio">
                                            <input type="radio" name="chat_num" value="${room.chat_num}">
                                        </div>
                                        <div class="chat-room" align="left" onclick="enterChatRoom(${room.chat_num})">
                                            <span>${room.chat_name}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${fn:length(mylist) == 0}">
                                <p>내 채팅방이 없습니다.</p>
                            </c:if>
                        </div>
                    </div>
                    <br>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../student/studentBottom.jsp"%>
