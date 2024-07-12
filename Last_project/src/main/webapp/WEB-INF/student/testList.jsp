<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>
	
	<style type="text/css">
		
		table {
			width: 400px;
		}
		
	</style>
	
    <!-- header -->
    <div class="page-header">
    	<h3 class="page-title">
	    	<span class="page-title-icon bg-gradient-primary text-white me-2">
	        	<i class="mdi mdi-home"></i>
	    	</span> testList
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
    
	    <h1>시험 목록 게시판</h1>
	    
	    <br>
    	
	    <table border="1">
	    		
	    	<tr>
	    		<th>번호</th>
	    		<th>시험 제목</th>
	    		<th>응시 여부</th>
	    	</tr>
	    		
	    	<c:if test="${fn:length(tlist) == 0}">
	    			
	    			<tr>
	    				<td colspan="3" align="center" style="height: 50">준비된 시험이 없습니다!!!</td>
	    			</tr>
	    			
	    	</c:if>
	    		
	    	<c:set var="i" value="1"/>
	    		
	    	<c:if test="${fn:length(tlist) != 0}">
	    			
	    		<c:forEach var="test" items="${tlist}">
	    				
	    			<c:set var="j" value="0"/>
	    				
	    			<tr>
						<td>${i}</td>
						<td>${test.test_name}</td>
						<td>
								
							<c:forEach var="testResult" items="${trlist}">
									
								<c:if test="${testResult.test_num == test.test_num}">
										
									응시 완료
										
									<c:set var="j" value="1"/>
									
								</c:if>
									
							</c:forEach>
								
							<c:if test="${j != 1}">
									
								<a href="testContent.student?test_num=${test.test_num }">응시 하기</a>
								
							</c:if>
							
						</td>
    				</tr>
	    				
	   				<c:set var="i" value="${i + 1}"/>
	    				
	    		</c:forEach>
	    			
	    	</c:if>
	    		
	    </table>
    
    </div>
    
<%@ include file = "studentBottom.jsp"%>