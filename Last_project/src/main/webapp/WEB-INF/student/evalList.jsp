<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>
	
	<style type="text/css">
		
		.form-group {
		  display: flex;
		  align-items: center;
		  margin-right: 1rem;
		}
		
		.form-group .btn,
		.form-group .form-control,
		.form-group .form-select {
		  margin-right: 0.3rem;
		}
		
		.form-select{
		  width: 100px;
		}
		
		.datepicker .disabled, .datepicker .disabled:hover {
		    color: #ccc !important;
		    cursor: not-allowed;
		}
		
		.fa-minus-square {
		  color: #36E0C6;
		  font-size: 20px;
		}
		
		.fa-plus-square{
		  color: #36E0C6;
		  font-size: 30px;
		}
		
		.fa-minus-square:hover, .fa-plus-square:hover {
		  color: #F15F5F; /* 마우스 오버 시 색상 변경 */
		}
		
		.card-body {
		  min-height: 70vh; /* viewport 높이의 50% */
		}
	  	
	  	table{
	  		width: 1600px;
	  	}
	  	
	  	tr, th, td{
	  		height: 50px;
	  	}
		
	</style>
    
    <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	      
	       <h1 align="left">강의 평가 목록</h1>
	    	
		   <div align="center">
	    	
	    	<br>
	    	
		    <table class="table">
		    		
		    	<tr>
		    		<th style="padding-left: 25px; background-color: #F6F6F6;">번호</th>
		    		<th style="padding-left: 25px; background-color: #F6F6F6;">평가 제목</th>
		    		<th style="background-color: #F6F6F6;"><span style="al">응시 여부</span></th>        
		    	</tr>
		    		
		    	<c:if test="${fn:length(elist) == 0}">
		    			
		    			<tr>
		    				<td colspan="3" align="center" style="padding: 48px 0;">준비된 평가가 없습니다.</td>
		    			</tr>
		    			
		    	</c:if>
		    		
		    	<c:set var="i" value="1"/>
		    		
		    	<c:if test="${fn:length(elist) != 0}">
		    			
		    		<c:forEach var="eval" items="${elist}">
		    				
		    			<c:set var="j" value="0"/>
		    				
		    			<tr>
							<td style="padding-left: 25px;">${i}</td>
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
	   </div>
	  </div>
	 </div>
	</div>
    
<%@ include file = "studentBottom.jsp"%>
