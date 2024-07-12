<%@page import="test.model.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

	<br>test.jsp<br>
	
	<%
		
		TestBean test = (TestBean)request.getAttribute("test");
		
		String[] questions = test.getTest_questions().split("/");
		String[] answers = test.getTest_answer().split("/");
		String[] images = test.getTest_img().split("/");
		
		String[] opts = test.getTest_opt().split("/");
	%>
	
	<c:set var="questions" value="<%=questions %>"/>
	<c:set var="answers" value="<%=answers %>"/>
	<c:set var="images" value="<%=images %>"/>
	
	<center>
	
		<h1>${test.test_name }</h1>	
		
		<form action="testContent.student" method="post">
			
			<% int i = 1; %>
			
			<c:forEach var="i" begin="0" end="${fn:length(questions) - 1}">
				
				<%
	                String[] options = opts[i].split("-");
	            %>
	            
	            <c:set var="opt" value="<%=options %>"/>
				
				<hr>
				
				<p align="left" style="padding-left: 750px;">
					<font size="5">${i+1}) </font> 
					
					<font size="6">${questions[i]}</font> <br><br>
					
					<div style="padding-left: 930px;" align="left">
					
						<img src="resources/testFiles/${images[i]}" width="150" height="150"> <br>
					
						<input type="radio" name="problem${i + 1}" value="1"> 1. ${opt[0]} <br>
						<input type="radio" name="problem${i + 1}" value="2"> 2. ${opt[1]} <br>
						<input type="radio" name="problem${i + 1}" value="3"> 3. ${opt[2]} <br>
						<input type="radio" name="problem${i + 1}" value="4"> 4. ${opt[3]} <br>
						<input type="radio" name="problem${i + 1}" value="5"> 5. ${opt[4]} <br>
					</div>
				</p>
				
				<% i++; %>
				
			</c:forEach>
			
			<input type="hidden" name="test_num" value="<%= test.getTest_num()%>">
			<input type="hidden" name="answers" value="<%= test.getTest_answer()%>">
			
			<br>
			<input type="submit" value="제출하기">
			
		</form>
		
	</center>
	