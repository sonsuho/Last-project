<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "managerBarTop.jsp"%>
	
	<!-- header -->
	<div class="page-header">
	  	<h3 class="page-title">
	    	<span class="page-title-icon bg-gradient-primary text-white me-2">
	      		<i class="mdi mdi-home"></i>
	    	</span> Lecture Evaluation Write
	  	</h3>
		<nav aria-label="breadcrumb">
	    	<ul class="breadcrumb">
	    	  	<li class="breadcrumb-item active" aria-current="page">
	        		<span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
				</li>
	    	</ul>
	  	</nav>
	</div>
	
	<div align="left" style="padding-left: 400px;">
		
		<h1 style="padding-left: 5px;">강의 평가 조사</h1>
		
		<form action="lectureEval.manager" method="post">
			
			<c:forEach var="i" begin="0" end="${fn:length(classes) - 1}">
				
				<input type="checkbox" name="lec_nums" value="${classes[i]}"> ${lec_names[i]} <br>
				
			</c:forEach>
			
			<br>
						
			<input type="submit" value="평가" style="margin-left: 50px;">
				
		</form>
		
	</div>
	
<%@ include file = "managerBarBottom.jsp"%>
	