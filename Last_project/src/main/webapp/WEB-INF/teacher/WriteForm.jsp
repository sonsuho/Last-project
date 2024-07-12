<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
	
	<script type="text/javascript">
		
		function testCheck(){
			
			var form = document.forms[0]
			
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
	
	</script>
	
	<br>WriteForm.jsp<br>
	
	<h1>시험 문제 출제</h1>
	
	<c:if test="${i == null}">
		
		<c:set var="i" value="1"/>
		
	</c:if>
	
	<c:if test="${i != null}">
		
		<c:set var="i" value="${i + 1}"/>
		
	</c:if>
	
	<p>
		${index} 번 문제를 입력하세요!
	</p>
	
	<c:if test="${index == 5}">
		
		<form action="testWrite.teacher" method="post" enctype="multipart/form-data">
			
			<table border="1">
				
				<tr>
					<th>시험명</th>
					<td><input type="text" name="test_name" value="${test_name}"></td>
				</tr>
				
				<tr>
					<th>문제</th>
					<td><textarea rows="3" cols="35" name="problem"></textarea></td>
				</tr>
				
				<tr>
					<th>자료</th>
					<td><input type="file" name="image"></td>
				</tr>
				
				<tr>
					<th>선택지</th>
					<td>
						&nbsp; 1. &nbsp;<input type="text" name="opt1"> <br>
						&nbsp; 2. &nbsp;<input type="text" name="opt2"> <br>
						&nbsp; 3. &nbsp;<input type="text" name="opt3"> <br>
						&nbsp; 4. &nbsp;<input type="text" name="opt4"> <br>
						&nbsp; 5. &nbsp;<input type="text" name="opt5"> <br>
					</td>
				</tr>
				
				<tr>
					<th>정답</th>
					<td><textarea rows="2" cols="35" name="answer"></textarea></td>
				</tr>
				
			</table>
		    
		    <input type="hidden" name="problems" value="${problems}">
		    <input type="hidden" name="answers" value="${answers }">
		    <input type="hidden" name="images" value="${images }">
		    <input type="hidden" name="choice" value="${choice }">
		    <input type="hidden" name="index" value="${index }">
			
			<input type="submit" value="제출하기" onclick="return testCheck()">
		</form>
		
	</c:if>
	
	<c:if test="${index != 5}">
		
		<form action="testWrite2.teacher" method="post" enctype="multipart/form-data">
			
			<table border="1">
				
				<tr>
					<th>시험명</th>
					<td><input type="text" name="test_name" value="${test_name}"></td>
				</tr>
				
				<tr>
					<th>문제</th>
					<td><textarea rows="3" cols="35" name="problem"></textarea></td>
				</tr>
				
				<tr>
					<th>자료</th>
					<td><input type="file" name="image"></td>
				</tr>
					
				<tr>
					<th>선택지</th>
					<td>
						&nbsp; 1. &nbsp;<input type="text" name="opt1"> <br>
						&nbsp; 2. &nbsp;<input type="text" name="opt2"> <br>
						&nbsp; 3. &nbsp;<input type="text" name="opt3"> <br>
						&nbsp; 4. &nbsp;<input type="text" name="opt4"> <br>
						&nbsp; 5. &nbsp;<input type="text" name="opt5"> <br>
					</td>
				</tr>
				
				<tr>
					<th>정답</th>
					<td><textarea rows="2" cols="35" name="answer"></textarea></td>
				</tr>
				
			</table>
		    
		    <input type="hidden" name="problems" value="${problems}">
		    <input type="hidden" name="answers" value="${answers }">
		    <input type="hidden" name="images" value="${images }">
		    <input type="hidden" name="choice" value="${choice }">
		    <input type="hidden" name="index" value="${index }">
			
			<input type="submit" value="다음" onclick="return testCheck()">
		</form>
		
	</c:if>
	