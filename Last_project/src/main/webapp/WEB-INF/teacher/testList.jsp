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
                    	
                    	<h1 align="left">시험 목록</h1>
			          
			        </div>
			        <div class="col-lg-4" style="display:flex; justify-content: flex-end; align-items: center; padding-right: 10px;">
                     	
						<button type="button" class="btn btn-gradient-success py-3" onclick="location.href='testWrite.teacher'">시험 만들기</button>&nbsp;&nbsp;&nbsp;</h2>

			        </div>
                </div><!-- row -->
				
			    <div align="center" style="margin-top:30px;">	    	
			    	
				    <table class="table">
				    	
				    	<tr>
				    		<th style="padding-left: 25px; background-color: #F6F6F6;">번호</th>
				    		<th style="padding-left: 25px; background-color: #F6F6F6;" align="right">시험 제목</th>
				    		<th style="background-color: #F6F6F6;"><span style="al">응시 인원</span></th>
				    	</tr>
				    		
				    	<c:if test="${fn:length(tlist) == 0}">
				    			
				    			<tr>
				    				<td colspan="3" align="center" style="padding: 48px 0;">준비된 시험이 없습니다.</td>
				    			</tr>
				    			
				    	</c:if>
				    		
				    	<c:set var="i" value="1"/>
				    		
				    	<c:if test="${fn:length(tlist) != 0}">
				    			
				    		<c:forEach var="test" items="${tlist}">
				    				
				    			<c:set var="j" value="0"/>
				    				
				    			<tr >
									<td style="padding-left: 25px;">${i}</td>
									<td align="left"><a href="testResultContent.teacher?test_num=${test.test_num}">${test.test_name}</a></td>
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
			   </div>
			  </div>
			 </div>
			</div>
	    
	    <%@ include file = "teacherBottom.jsp"%>