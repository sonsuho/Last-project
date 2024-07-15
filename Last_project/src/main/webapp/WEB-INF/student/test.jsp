<%@page import="test.model.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

	<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        
        .test-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .question {
            margin-bottom: 20px;
        }
        
        .question-number {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .question-text {
            font-size: 20px;
            margin-bottom: 10px;
        }
        
        .question-options {
            padding-left: 30px;
        }
        
        .option-label {
            font-size: 16px;
        }
        
        .question-number, .question-text {
		    display: inline;
		    margin-right: 10px;
		}
    </style>
	
	<%
		
		TestBean test = (TestBean)request.getAttribute("test");
		
		String[] questions = test.getTest_questions().split("/");
		String[] answers = test.getTest_answer().split("/");
		String[] images = test.getTest_img().split("/");
		
		String[] opts = test.getTest_opt().split("/");
	%>
	
	<c:set var="questions" value="<%=questions %>"/>
	<c:set var="answers" value="<%=answers %>"/>
	<c:set var="opts" value="<%=opts %>"/>
	<c:set var="images" value="<%=images %>"/>
	
	<body>
	    <div class="test-container">
	        <h1 class="text-center"><font size="6">${test.test_name}</font></h1> <br>
	        
	        <form action="testContent.student" method="post">
	            
	            <c:forEach var="i" begin="0" end="${fn:length(questions) - 1}">
	                <div class="question">
	                
	                	<div style="display: inline-block;">
		                    <div class="question-number">${i + 1})</div>
		                    <div class="question-text">${questions[i]}</div>
	                    </div>
	                    
	                    <div class="question-options">
	                        <img src="resources/testFiles/${images[i]}" width="150" height="150" style="margin-bottom: 10px;"> <br>
	                        
	                        <input type="radio" id="option${i + 1}_1" name="problem${i + 1}" value="1">
	                        <label for="option${i + 1}_1" class="option-label">${opts[i].split("-")[0]}</label><br>
	                        
	                        <input type="radio" id="option${i + 1}_2" name="problem${i + 1}" value="2">
	                        <label for="option${i + 1}_2" class="option-label">${opts[i].split("-")[1]}</label><br>
	                        
	                        <input type="radio" id="option${i + 1}_3" name="problem${i + 1}" value="3">
	                        <label for="option${i + 1}_3" class="option-label">${opts[i].split("-")[2]}</label><br>
	                        
	                        <input type="radio" id="option${i + 1}_4" name="problem${i + 1}" value="4">
	                        <label for="option${i + 1}_4" class="option-label">${opts[i].split("-")[3]}</label><br>
	                        
	                        <input type="radio" id="option${i + 1}_5" name="problem${i + 1}" value="5">
	                        <label for="option${i + 1}_5" class="option-label">${opts[i].split("-")[4]}</label><br>
	                    </div>
	                    	                    
	                </div>
	                
	                <br>
	            
	            </c:forEach>
	            
	            <input type="hidden" name="test_num" value="${test.getTest_num()}">
	            <input type="hidden" name="answers" value="${test.getTest_answer()}">
	            
	            <div class="text-center mt-4" align="center">
	                <input type="submit" value="제출하기" class="btn btn-primary">
	            </div>
	        </form>
	    </div>
	</body>