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

  	<!-- header -->
  <div class="page-header">
    <h3 class="page-title">
      <span class="page-title-icon bg-gradient-primary text-white me-2">
        <i class="mdi mdi-clipboard-text"></i>
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
    
      <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">

	    	<h2 align="left" style="margin-left: 50px">강의 평가 목록</h2> <br>
			
		    <div align="center">		    	
		    	
			<table>
	    		
	    	<tr style="background-color: #F6F6F6">
	    		<th style="padding-left: 25px;">번호</th>
	    		<th>강의 평가 제목</th>
	    		<th>응시 인원</th>
	    	</tr>
	    		
	    	<c:if test="${fn:length(elist) == 0}">
	    			
	    			<tr>
	    				<td colspan="3" align="center" style="height: 250">강의 평가 내용이 없습니다!!!</td>
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