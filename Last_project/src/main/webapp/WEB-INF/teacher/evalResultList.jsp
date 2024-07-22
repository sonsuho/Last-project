<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
    
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

	    	<div class="row" style=" padding: 20px 0;">
               <div class="col-lg-8">
                    	
                  <h1 align="left">강의 평가 목록</h1>
			          
			   </div>
			   <div class="col-lg-4" style="display:flex; justify-content: flex-end; align-items: center; padding-right: 10px;">

			   </div>
            </div><!-- row -->
			
		    <div align="center">		    	
		    	
			<table class="table">
	    		
	    	<tr>
	    		<th style="padding-left: 25px; background-color: #F6F6F6;">번호</th>
	    		<th style="background-color: #F6F6F6;">강의 평가 제목</th>
	    		<th style="background-color: #F6F6F6;">응시 인원</th>
	    	</tr>
	    		
	    	<c:if test="${fn:length(elist) == 0}">
	    			
    			<tr>
    				<td colspan="3" align="center" style="padding: 48px 0;">강의 평가 내용이 없습니다.</td>
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
    </div>
    </div>
    </div>
    </div>
    
<%@ include file = "teacherBottom.jsp"%>