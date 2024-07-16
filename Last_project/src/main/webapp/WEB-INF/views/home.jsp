<%@page import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
%>

<%@ include file="studentTop.jsp"%>
    
    <!-- header -->
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-pencil-box"></i>
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
    
    <%
        Integer mem_num = (Integer)request.getAttribute("mem_num");
        String mem_name = (String)request.getAttribute("mem_name");
        String chat_num = (String)request.getAttribute("chat_num");
    %>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="resources/sockjs.min.js"></script>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .chat-box {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        
        .chat-form {
            display: flex;
            margin-top: 10px;
        }
        
        .chat-form input[type="text"] {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            outline: none;
        }
        
        .chat-form button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            outline: none;
        }
        
        .chat-form button:hover {
            background-color: #0056b3;
        }
    </style>
    
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                
                	<br><h1 style="padding-left: 30px;">${chat_name}</h1>
                
                    <div class="card-body">
                        
                        <div class="chat-box" id="chat">
                        	<br><br>
                            <!-- 채팅 내용이 여기에 추가됩니다 -->
                        </div>
                        
                        <form id="chatForm" class="chat-form">
                            <input type="text" id="message" placeholder="메시지 입력..." autocomplete="off"> &nbsp;&nbsp;
                            <button type="submit">전송</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
    
        var mem_num = "<%= mem_num %>";
        var mem_name = "<%= mem_name %>";
        var chat_num = "<%= chat_num %>";
        
        var loginInfo = "<%= ((MemberBean)session.getAttribute("loginInfo")).getName()%>";
        
        var sock = new SockJS("/ex/echo");
    
        $(document).ready(function(){
    
            $("#chatForm").submit(function(event){
                event.preventDefault();
                sock.send(mem_name + "/" + $("#message").val() + "/" + chat_num);
                $("#message").val('').focus();
            });
        });
        
        sock.onmessage = function(e){
            
            var message = e.data;
            var parts = message.split("/");
            
            if(parts[2] == chat_num){
            	
            	if(parts[0] != mem_name){
	            	
	                $("#chat").append("<p><strong>" + parts[0] + ":</strong> " + parts[1] + "</p>");
	                var chatBox = document.getElementById("chat");
	                chatBox.scrollTop = chatBox.scrollHeight;
                
            	}else{
            		
	                $("#chat").append("<p><strong><font color='red'>" + parts[0] + "</font>:</strong> " + parts[1] + "</p>");
	                var chatBox = document.getElementById("chat");
	                chatBox.scrollTop = chatBox.scrollHeight;
            		
            	}
            }
        }
        
        sock.onclose = function(){
            $("#chat").append("<p>연결 종료</p>");
        }
        
    </script>
    
<%@ include file="studentBottom.jsp"%>
