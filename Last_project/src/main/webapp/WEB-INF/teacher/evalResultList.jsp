<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
    
    <style type="text/css">
    	
    	table {
			width: 650px;
		}
    	
    </style>

  	<!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> Evaluation Result List
    	</h3>
    	<nav aria-label="breadcrumb">
      	<ul class="breadcrumb">
        	<li class="breadcrumb-item active" aria-current="page">
          		<span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
        		</li>
      		</ul>
    	</nav>
  	</div>
    
    <div align="center">
    	
    	<h1>강의 평가 목록</h1>
    	
	    <table border="1">
	    		
	    	<tr>
	    		<th>번호</th>
	    		<th>강의 평가 제목</th>
	    		<th>응시 인원</th>
	    	</tr>
	    		
	    	<c:if test="${fn:length(elist) == 0}">
	    			
	    			<tr>
	    				<td colspan="3" align="center" style="height: 50">강의 평가 내용이 없습니다!!!</td>
	    			</tr>
	    			
	    	</c:if>
	    		
	    	<c:set var="i" value="1"/>
	    		
	    	<c:if test="${fn:length(elist) != 0}">
	    			
	    		<c:forEach var="eval" items="${elist}">
	    				
	    			<c:set var="j" value="0"/>
	    				
	    			<tr>
						<td>${i}</td>
						<td><a href="evalResultContent.teacher?eval_num=${eval.eval_num}">${eval.eval_content}</a></td>
						<td>
								
							<c:forEach var="evalResult" items="${erlist }">
								
								<c:if test="${evalResult.eval_num == eval.eval_num}">
									
									<c:set var="j" value="${j + 1}"/>
									
								</c:if>
								
							</c:forEach>
							
							${j}
							
						</td>
    				</tr>
	    				
	   				<c:set var="i" value="${i + 1}"/>
	    				
	    		</c:forEach>
	    			
	    	</c:if>
	    		
	    </table>
    	
    </div>
    
<%@ include file = "teacherBottom.jsp"%>