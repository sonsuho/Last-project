<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
	
  <style type="text/css">
  	
  	table{
  		width: 600px;
  	}
  	
  </style>
  
  <!-- header -->
  <div class="page-header">
    <h3 class="page-title">
      <span class="page-title-icon bg-gradient-primary text-white me-2">
        <i class="mdi mdi-home"></i>
      </span> TestList
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
    	
    	<h1>시험 목록</h1>
    	
	    <table border="1">
	    	
	    	<tr align="right">
	    		<th colspan="3"><a href="testWrite.teacher">시험 출제</a></th>
	    	</tr>
	    	
	    	<tr>
	    		<th>번호</th>
	    		<th>시험 제목</th>
	    		<th>응시 인원</th>
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
						<td><a href="testResultContent.teacher?test_num=${test.test_num}">${test.test_name}</a></td>
						<td>
								
							<c:forEach var="testResult" items="${trlist }">
								
								<c:if test="${testResult.test_num == test.test_num}">
									
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