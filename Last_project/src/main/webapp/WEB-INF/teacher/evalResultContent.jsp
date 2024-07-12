<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
	
	<style type="text/css">
		
		table {
			width: 1100px;
			text-align: center;
		}
		
	</style>
	
	<!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> Evaluation Result Content
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
	
		<h1>${eval_name}</h1>	
			
		<table border="1">
					
			<tr>
				<th>번호</th>
				<th>내용</th>
				<th>매우 그렇다</th>
				<th>그렇다</th>
				<th>보통이다</th>
				<th>그렇지 않다</th>
				<th>매우 그렇지 않다</th>
			</tr>
				
			<c:forEach var="i" begin="0" end="8">
				
				<tr>
					<td>${i + 1}번</td>
					<td align="left">${problems[i]}</td>
					<td>${result[i][0]}<br>(${result[i][0]/count * 100} %)</td>
					<td>${result[i][1]}<br>(${result[i][1]/count * 100} %)</td>
					<td>${result[i][2]}<br>(${result[i][2]/count * 100} %)</td>
					<td>${result[i][3]}<br>(${result[i][3]/count * 100} %)</td>
					<td>${result[i][4]}<br>(${result[i][4]/count * 100} %)</td>
				</tr>
					
			</c:forEach>
				
			<tr>
				<td>강사에게 하고 싶은 말</td>
				<td colspan="6" align="left">
					<br>
					<c:forEach var="request" items="${req}">
						
						${request} <br><br>
						
					</c:forEach>
				</td>
			</tr>
				
		</table>
		
	</div>
	
<%@ include file = "teacherBottom.jsp"%>

	