<%@ page import="test.model.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

	<!-- plugins:css -->
	<link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
	<link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
	<!-- endinject -->
	<!-- Plugin css for this page -->
	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" href="resources/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<!-- endinject -->
	<!-- Layout styles -->
	<link rel="stylesheet" href="resources/assets/css/style.css">
	<!-- End layout styles -->
	<link rel="shortcut icon" href="resources/assets/images/favicon.png" />
	
	<script>
	    // Set the date we're counting down to (50 minutes from now)
	    var countDownDate = new Date().getTime() + 50 * 60 * 1000;
	
	    // Update the count down every 1 second
	    var x = setInterval(function() {
	        // Get today's date and time
	        var now = new Date().getTime();
	
	        // Find the distance between now and the count down date
	        var distance = countDownDate - now;
	
	        // Time calculations for days, hours, minutes and seconds
	        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
	
	        // Display the result in the element with id="demo"
	        document.getElementById("demo1").innerHTML = minutes + "m " + seconds + "s ";
	        document.getElementById("demo2").innerHTML = minutes + "m " + seconds + "s ";
	
	        // If the count down is finished, write some text and submit the form
	        if (distance < 0) {
	            clearInterval(x);
	            document.getElementById("demo1").innerHTML = "EXPIRED";
	            document.getElementById("testForm").submit();
	        }
	    }, 1000);
	    
	    // Scroll to top function
	    function scrollToTop() {
	        window.scrollTo({top: 0, behavior: 'smooth'});
	    }
	</script>
	
	<style>
	    body {
	        font-family: Arial, sans-serif;
	        background-color: #F2EDF3;
	        padding: 20px;
	    }
	
	    .header {
	        position: fixed;
	        top: 0;
	        left: 0;
	        width: 100%;
	        background-color: #F0FFF0;
	        border-bottom: 1px solid #ccc;
	        padding: 10px 0;
	        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	        z-index: 1000;
	        text-align: right;
	    }
	
	    .header .btn-submit {
	        background-color: #007bff;
	        color: white;
	        border: none;
	        border-radius: 5px;
	        padding: 10px 20px;
	        cursor: pointer;
	        font-size: 16px;
	        margin-left: 20px;
	    }
	
	    .header .btn-submit:hover {
	        background-color: #0056b3;
	    }
	
	    .test-container {
	        max-width: 800px;
	        margin: 60px auto 0; /* Add margin-top to avoid overlap with header */
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
	
	    .scroll-to-top-btn {
	        position: fixed;
	        bottom: 20px;
	        right: 20px;
	        background-color: #007bff;
	        color: white;
	        border: none;
	        border-radius: 50%;
	        width: 50px;
	        height: 50px;
	        font-size: 20px;
	        text-align: center;
	        line-height: 50px;
	        cursor: pointer;
	        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	        z-index: 1000;
	    }
	
	    .scroll-to-top-btn:hover {
	        background-color: #0056b3;
	    }
	</style>
	
	<%
	    TestBean test = (TestBean) request.getAttribute("test");
	
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
	    <div class="header" style="padding-right: 20px;">
	        <font size="4">Timer : <span id="demo1">50m 0s</span></font>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <input type="submit" value="제출하기" class="btn btn-gradient-success py-3" form="testForm">
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
	
	    <div class="test-container">
	        <h1 class="text-center">
	            &nbsp;&nbsp;&nbsp;<font size="6">${test.test_name}</font>
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <font size="5">남은 시간 : <span id="demo2"></span></font>
	        </h1>
	        <br>
	        
	        <form id="testForm" action="testContent.student" method="post">
	            <c:forEach var="i" begin="0" end="${fn:length(questions) - 1}">
	                <div class="question" style="padding-left: 30px;">
	                    <div style="display: inline-block;">
	                        <div class="question-number">${i + 1})</div>
	                        <div class="question-text">${questions[i]}</div>
	                    </div>
	                    
	                    <div class="question-options">
	                        <img src="resources/testFiles/${images[i]}" width="300" style="margin-bottom: 10px; padding-left: 20px; padding-top: 10px;"> <br>
	                        
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
	                <input type="submit" value="제출하기" class="btn btn-gradient-success py-3" form="testForm">
	            </div>
	        </form>
	    </div>
	
	    <button class="scroll-to-top-btn" onclick="scrollToTop()">▲</button>
	</body>
