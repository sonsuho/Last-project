<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

	<style type="text/css">
		
		table {
			width: 1100px;
		}
		
	</style>
	
	<script type="text/javascript">
		
		function evalCheck() {
			
			var form = document.forms[0];
	        var problems = 9; // 문제의 개수
	        var allChecked = true;

	        for (var i = 1; i <= problems; i++) {
	            var radios = form['problem' + i];
	            var isChecked = false;

	            for (var j = 0; j < radios.length; j++) {
	                if (radios[j].checked) {
	                    isChecked = true;
	                    break;
	                }
	            }

	            if (!isChecked) {
	                alert(i + "번 문항이 누락되었습니다!!");
	                radios[0].focus();
	                allChecked = false;
	                break;
	            }
	        }

	        return allChecked;
		}
	
	</script>
	
	<!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> Evaluation
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
	    String[] problems = {
	        "강의 내용과 구성은 만족스러운가?",
	        "강의실 시설과 환경은 만족스러운가?",
	        "강사의 수업 진행 능력은 만족스러운가?",
	        "강의 진행 속도가 적당하다고 생각하는가?",
	        "강의에서 제공된 학습 자료가 학습에 유효한가?",
	        "강의 내용이 실무 환경에 실용적으로 적용 가능한가?",
	        "강의 중 학습자의 참여가 충분한가?",
	        "과제가 강의 내용을 잘 이해할 수 있게 충분한가?",
	        "평가가 강의 내용을 잘 이해하는지 평가 하기에 적절한가?"
	    };
	%>
	
	<c:set var="problems" value="<%=problems %>" />
	
	<div align="center">
	
		<h1>${eval.eval_content}</h1>	
		
		<form action="evalContent.student" method="post">
			
			<table border="1" style="text-align: center;">
					
				<tr>
					<th>번호</th>
					<th>내용</th>
					<th style="width: 100px;">매우 그렇다</th>
					<th style="width: 100px;">그렇다</th>
					<th style="width: 100px;">보통이다</th>
					<th style="width: 100px;">그렇지 않다</th>
					<th style="width: 130px;">매우 그렇지 않다</th>
				</tr>
				
				<c:forEach var="i" begin="0" end="8">
					
					<tr>
						<td>${i + 1}번</td>
						<td align="left">${problems[i]}</td>
						<td><input type="radio" name="problem${i + 1}" value="1"></td>
						<td><input type="radio" name="problem${i + 1}" value="2"></td>
						<td><input type="radio" name="problem${i + 1}" value="3"></td>
						<td><input type="radio" name="problem${i + 1}" value="4"></td>
						<td><input type="radio" name="problem${i + 1}" value="5"></td>
					</tr>
					
				</c:forEach>
				
				<tr align="left">
					<td>10번</td>
					<td colspan="6">
						<textarea rows="6" cols="154" name="req" placeholder="강사에게 하고싶은 말을 적어주세요"></textarea>
					</td>
				</tr>
				
			</table>
			
			<input type="hidden" name="eval_num" value="${eval.eval_num}">
			
			<br>
			<input type="submit" value="제출하기" onclick="return evalCheck()">
			
		</form>
		
	</div>

