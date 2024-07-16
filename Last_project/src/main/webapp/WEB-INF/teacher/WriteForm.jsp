<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

	<!-- Include Bootstrap CSS -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
	
	<script type="text/javascript">
	    function testCheck() {
	        var form = document.forms[0];
	
	        var testName = form.test_name.value.trim();
	        var problem = form.problem.value.trim();
	        var opt1 = form.opt1.value.trim();
	        var opt2 = form.opt2.value.trim();
	        var opt3 = form.opt3.value.trim();
	        var opt4 = form.opt4.value.trim();
	        var opt5 = form.opt5.value.trim();
	        var answer = form.answer.value.trim();
	        
	        if (testName === "") {
	            alert("시험명을 입력하세요.");
	            form.test_name.focus();
	            return false;
	        }
	        if (problem === "") {
	            alert("문제를 입력하세요.");
	            form.problem.focus();
	            return false;
	        }
	        if (opt1 === "" || opt2 === "" || opt3 === "" || opt4 === "" || opt5 === "") {
	            alert("모든 선택지를 입력하세요.");
	            if (opt1 === "") form.opt1.focus();
	            else if (opt2 === "") form.opt2.focus();
	            else if (opt3 === "") form.opt3.focus();
	            else if (opt4 === "") form.opt4.focus();
	            else form.opt5.focus();
	            return false;
	        }
	        if (answer === "") {
	            alert("정답을 입력하세요.");
	            form.answer.focus();
	            return false;
	        }
	        return true;
	    }
	    
	    function goBack() {
	        history.back();
	    }
	    
	</script>
	
	<div class="container mt-5">
	    <h1 class="mb-4">시험 문제 출제</h1>
	
	    <c:if test="${i == null}">
	        <c:set var="i" value="1"/>
	    </c:if>
	
	    <c:if test="${i != null}">
	        <c:set var="i" value="${i + 1}"/>
	    </c:if>
	
	    <p class="mb-4">${index} 번 문제를 입력하세요!</p>
	
	    <c:if test="${index == 5}">
	        <form action="testWrite.teacher" method="post" enctype="multipart/form-data" onsubmit="return testCheck()">
	            <div class="form-group">
	                <label for="test_name">시험명</label>
	                <input type="text" class="form-control" id="test_name" name="test_name" value="${test_name}">
	            </div>
	            <div class="form-group">
	                <label for="problem">문제</label>
	                <textarea class="form-control" id="problem" name="problem" rows="3"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="image">자료</label>
	                <input type="file" class="form-control-file" id="image" name="image">
	            </div>
	            <div class="form-group">
	                <label>선택지</label>
	                <input type="text" class="form-control mb-2" name="opt1" placeholder="1.">
	                <input type="text" class="form-control mb-2" name="opt2" placeholder="2.">
	                <input type="text" class="form-control mb-2" name="opt3" placeholder="3.">
	                <input type="text" class="form-control mb-2" name="opt4" placeholder="4.">
	                <input type="text" class="form-control mb-2" name="opt5" placeholder="5.">
	            </div>
	            <div class="form-group">
	                <label for="answer">정답</label>
	                <textarea class="form-control" id="answer" name="answer" rows="2"></textarea>
	            </div>
	
	            <input type="hidden" name="problems" value="${problems}">
	            <input type="hidden" name="answers" value="${answers}">
	            <input type="hidden" name="images" value="${images}">
	            <input type="hidden" name="choice" value="${choice}">
	            <input type="hidden" name="index" value="${index}">
	
	            <div align="right">
	            	<button type="button" class="btn btn-secondary" onclick="goBack()">이전</button>
	            	&nbsp;&nbsp;&nbsp;
	            	<button type="submit" class="btn btn-secondary">제출</button>
	            </div>
	            
	            <br>
	            
	        </form>
	    </c:if>
	
	    <c:if test="${index != 5 && index != 1}">
	        <form action="testWrite2.teacher" method="post" enctype="multipart/form-data" onsubmit="return testCheck()">
	            <div class="form-group">
	                <label for="test_name">시험명</label>
	                <input type="text" class="form-control" id="test_name" name="test_name" value="${test_name}">
	            </div>
	            <div class="form-group">
	                <label for="problem">문제</label>
	                <textarea class="form-control" id="problem" name="problem" rows="3"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="image">자료</label>
	                <input type="file" class="form-control-file" id="image" name="image">
	            </div>
	            <div class="form-group">
	                <label>선택지</label>
	                <input type="text" class="form-control mb-2" name="opt1" placeholder="1.">
	                <input type="text" class="form-control mb-2" name="opt2" placeholder="2.">
	                <input type="text" class="form-control mb-2" name="opt3" placeholder="3.">
	                <input type="text" class="form-control mb-2" name="opt4" placeholder="4.">
	                <input type="text" class="form-control mb-2" name="opt5" placeholder="5.">
	            </div>
	            <div class="form-group">
	                <label for="answer">정답</label>
	                <textarea class="form-control" id="answer" name="answer" rows="2"></textarea>
	            </div>
	
	            <input type="hidden" name="problems" value="${problems}">
	            <input type="hidden" name="answers" value="${answers}">
	            <input type="hidden" name="images" value="${images}">
	            <input type="hidden" name="choice" value="${choice}">
	            <input type="hidden" name="index" value="${index}">
	
	            <div align="right">
	            	<button type="button" class="btn btn-secondary" onclick="goBack()">이전</button>
	            	&nbsp;&nbsp;&nbsp;
	            	<button type="submit" class="btn btn-secondary">다음</button>
	            </div>
	            
	            <br>
	            
	        </form>
	    </c:if>
	    
	    <c:if test="${index == 1}">
	        <form action="testWrite2.teacher" method="post" enctype="multipart/form-data" onsubmit="return testCheck()">
	            <div class="form-group">
	                <label for="test_name">시험명</label>
	                <input type="text" class="form-control" id="test_name" name="test_name" value="${test_name}">
	            </div>
	            <div class="form-group">
	                <label for="problem">문제</label>
	                <textarea class="form-control" id="problem" name="problem" rows="3"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="image">자료</label>
	                <input type="file" class="form-control-file" id="image" name="image">
	            </div>
	            <div class="form-group">
	                <label>선택지</label>
	                <input type="text" class="form-control mb-2" name="opt1" placeholder="1.">
	                <input type="text" class="form-control mb-2" name="opt2" placeholder="2.">
	                <input type="text" class="form-control mb-2" name="opt3" placeholder="3.">
	                <input type="text" class="form-control mb-2" name="opt4" placeholder="4.">
	                <input type="text" class="form-control mb-2" name="opt5" placeholder="5.">
	            </div>
	            <div class="form-group">
	                <label for="answer">정답</label>
	                <textarea class="form-control" id="answer" name="answer" rows="2"></textarea>
	            </div>
	
	            <input type="hidden" name="problems" value="${problems}">
	            <input type="hidden" name="answers" value="${answers}">
	            <input type="hidden" name="images" value="${images}">
	            <input type="hidden" name="choice" value="${choice}">
	            <input type="hidden" name="index" value="${index}">
	
	            <div align="right">
	            	<button type="submit" class="btn btn-secondary">다음</button>
	            </div>
	            <br>
	            
	        </form>
	    </c:if>
	</div>
	
	<!-- Include Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
