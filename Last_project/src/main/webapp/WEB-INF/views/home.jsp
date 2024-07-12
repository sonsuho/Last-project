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
	
	<%
		Integer mem_num = (Integer)request.getAttribute("mem_num");
		String mem_name = (String)request.getAttribute("mem_name");
		String chat_num = (String)request.getAttribute("chat_num");
		
		System.out.print(mem_num);
		System.out.print(mem_name);
		System.out.print(chat_num);		
	%>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="resources/sockjs.min.js"></script>
	
	<script type="text/javascript">
	
		var mem_num = "<%= mem_num %>";
		var mem_name = "<%= mem_name %>";
		var chat_num = "<%= chat_num %>";
		
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
				$("#chat").append(parts[0] + " : " + parts[1] + "<br/>");
		    }
		}
		
		sock.onclose = function(){
			$("#chat").append("연결 종료");
		}
		
	</script>
	
	<div>

		<br><br>
		
		<form id="chatForm">
			<input type="text" id="message"/>
			<button>send</button>
		</form>
		<div id="chat"></div>
	
	</div>
	
<%@ include file="studentBottom.jsp"%>
