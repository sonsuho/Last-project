<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="teacherTop.jsp"%>

	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
	
	<style type="text/css">
	    .table {
	        width: 100%;
	        margin-bottom: 1rem;
	        color: #212529;
	    }
	
	    .table th, .table td {
	        padding: 0.75rem;
	        vertical-align: top;
	        border-top: 1px solid #dee2e6;
	    }
	
	    .table thead th {
	        vertical-align: bottom;
	        border-bottom: 2px solid #dee2e6;
	        background-color: #DDa7ff; /* 배경색 지정 */
	        font-weight: bold;
	    }
	
	    .table tbody + tbody {
	        border-top: 2px solid #dee2e6;
	    }
	
	    .percentage {
	        font-size: 0.875rem;
	        color: #6c757d;
	    }
	
	    .card-body {
	        min-height: 70vh; /* viewport 높이의 50% */
	    }
	
	    .feedback {
	        margin-top: 2rem;
	    }
	</style>
	
	<!-- header -->
	<div class="page-header">
	    <h3 class="page-title">
	        <span class="page-title-icon bg-gradient-primary text-white me-2">
	            <i class="mdi mdi-home"></i>
	        </span> Evaluation Result Content
	    </h3>
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
	
	<div class="row">
	    <div class="col-lg-12 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                <div class="text-center">
	                    <h1>${eval_name}</h1> <br>
	
	                    <table class="table table-bordered">
	                        <thead>
	                            <tr align="center">
	                                <th align="center">번호</th>
	                                <th align="center">내용</th>
	                                <th align="center">매우 그렇다</th>
	                                <th align="center">그렇다</th>
	                                <th align="center">보통이다</th>
	                                <th align="center">그렇지 않다</th>
	                                <th align="center">매우 그렇지 않다</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach var="i" begin="0" end="8">
	                                <tr>
	                                    <td>${i + 1}번</td>
	                                    <td class="text-left">${problems[i]}</td>
	                                    <td>
	                                        ${result[i][0]}
	                                        <div class="percentage">(${result[i][0]/count * 100}%)</div>
	                                    </td>
	                                    <td>
	                                        ${result[i][1]}
	                                        <div class="percentage">(${result[i][1]/count * 100}%)</div>
	                                    </td>
	                                    <td>
	                                        ${result[i][2]}
	                                        <div class="percentage">(${result[i][2]/count * 100}%)</div>
	                                    </td>
	                                    <td>
	                                        ${result[i][3]}
	                                        <div class="percentage">(${result[i][3]/count * 100}%)</div>
	                                    </td>
	                                    <td>
	                                        ${result[i][4]}
	                                        <div class="percentage">(${result[i][4]/count * 100}%)</div>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                            <tr>
	                                <td align="center" style="vertical-align: middle;">강사에게 하고 싶은 말</td>
	                                <td colspan="6" class="text-left" style="vertical-align: middle;">
	                                    <c:forEach var="request" items="${req}">
	                                    	<br><br> ${request} <br><br>
	                                    </c:forEach>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
<%@ include file="teacherBottom.jsp"%>
	
	<!-- Include Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	