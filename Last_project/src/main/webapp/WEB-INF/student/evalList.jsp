<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>
	
	<style type="text/css">
		
		table {
			width: 800px;
		}
		
	</style>
	
    <!-- header -->
    <div class="page-header">
    	<h3 class="page-title">
	    	<span class="page-title-icon bg-gradient-primary text-white me-2">
	        	<i class="mdi mdi-home"></i>
	    	</span> evaluation List
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
    	
    	<br>
    	
	    <table border="1">
	    		
	    	<tr>
	    		<th>번호</th>
	    		<th>평가 제목</th>
	    		<th>응시 여부</th>
	    	</tr>
	    		
	    	<c:if test="${fn:length(elist) == 0}">
	    			
	    			<tr>
	    				<td colspan="3" align="center" style="height: 50">준비된 평가가 없습니다!!!</td>
	    			</tr>
	    			
	    	</c:if>
	    		
	    	<c:set var="i" value="1"/>
	    		
	    	<c:if test="${fn:length(elist) != 0}">
	    			
	    		<c:forEach var="eval" items="${elist}">
	    				
	    			<c:set var="j" value="0"/>
	    				
	    			<tr>
						<td>${i}</td>
						<td>${eval.eval_content}</td>
						<td>
								
							<c:forEach var="evalResult" items="${erlist}">
									
								<c:if test="${evalResult.eval_num == eval.eval_num}">
										
									응시 완료
										
									<c:set var="j" value="1"/>
									
								</c:if>
									
							</c:forEach>
								
							<c:if test="${j != 1}">
									
								<a href="evalContent.student?eval_num=${eval.eval_num }">응시 하기</a>
								
							</c:if>
							
						</td>
    				</tr>
	    				
	   				<c:set var="i" value="${i + 1}"/>
	    				
	    		</c:forEach>
	    			
	    	</c:if>
	    		
	    </table>
    	
    </div>
    
<%@ include file = "studentBottom.jsp"%>
