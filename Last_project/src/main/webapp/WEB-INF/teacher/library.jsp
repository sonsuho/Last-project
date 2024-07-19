<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>

    <style type="text/css">
    	
    	table {
			width: 650px;
		}
    	
    </style>
    
    <script type="text/javascript">
    
    	// 자료실 글쓰기
    	function writeLibrary(pageNumber, whatColumn, keyword){
    		location.href = "writeLibrary.teacher?pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    	}
    	
    	// 자료실 상세보기 
    	function contentLib(num){
    		location.href = "contentLibrary.teacher?li_num=" + num;
    	}
    	
    	function allCheck(obj){
    		
    		var rcheck = document.getElementsByName("rowcheck");
    		
    		var check = obj.checked;
    		
    		if(check){
    			for(var i = 0; i < rcheck.length; i++){
    				rcheck[i].checked = true;
    			}
    		}else{
    			for(var i = 0; i < rcheck.length; i++){
    				rcheck[i].checked = false;
    			}
    		}
    		
    	}
    	
    	function selectDelete(){
    		
    		var flag = false;
    		
    		var rcheck = document.getElementsByName("rowcheck");
    		
    		for(var i = 0; i < rcheck.length; i++){
    			
    			if(rcheck[i].checked ==	true){
    				flag = true;
    				break;
    			}
    		}
    		
    		if(!flag){
    			alert('삭제할 항목을 선택하세요.');
				return false;
    		}
    		
    		var result = confirm("삭제 하시겠습니까?");
    		
    		if(result == true){			
	    		document.myform.submit();
    		} else{
    			alert('취소했습니다');
    			return false;
    		}
    	}
    
    </script>
    
    <div class="row">
       <div class="col-lg-12 grid-margin stretch-card">
          <div class="card">
             <div class="card-body">
    
    			<div class="row">
    				<div class="col-lag-12">
				    	<h1 style="text-align:center;">자료실</h1>
    				</div>
    			</div>
    			
    			<div class="row" style="margin-top: 36px;">
    				<!-- 자료실 삭제 / 글쓰기 버튼 학생 빼고 활성화  -->
    				<div class="col-lg-4" style="display:flex; justify-content: flex-start; align-content: center;">
    					<c:if test="${loginInfo.category != 'student' }">
    						<%-- <a href="writeLibrary.teacher?pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">글쓰기</a> --%>
	    					<div>
		    					<button type="button" onclick="writeLibrary('${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}' )" style="padding:12px; margin-right: 7px;" class="btn btn-gradient-primary"><i class="fa fa-send"></i> &nbsp;&nbsp;글쓰기</button>
	    					</div>
	    					<div>
		    					<button type="button" class="btn btn-gradient-light btn-sm" onclick="selectDelete()"><img src="resources/images/delete.png" style="width:24px; height:24px;">삭제</button>
	    					</div>
    					</c:if>
    				</div>
    				<div class="col-lg-2">
    				</div>
    				
    				<div class="col-lg-6">
    				  <form action="library.teacher">
    					<div class="form-group" style="display:flex; justify-content: flex-start; align-content: center;">
    					
	                      <select name="whatColumn" class="form-select" style="width:140px; margin-right: 15px;">
			    			 <option value="all">전체검색</option>
			    			 <option value="title">제목</option>
			    			 <option value="content">내용</option>
	                      </select>
	                      
	                      <input type="text" name="keyword" class="form-control" style="font-size: 16px;" placeholder="검색어를 입력하세요.">
				    	  <input type="submit"class="btn btn-sm btn-success py-3" style="width: 70px;" value="검색">
	                      
	                    </div>
				      </form>
    				</div><!-- col-lg-8 end  -->
    			</div><!-- row end -->
		    	
		    	<form name="myform" action="deleteAllLibrary.teacher">
		    	
			    	<table class="table table-hover">
			    		
			    		<thead>
				    		<tr>
				    			<th style="background:#f6f6f6; width:100px !important;">
				    				<label class="form-check-label">
				    					<input type="checkbox" class="form-check-input item" name="allcheck" onclick="allCheck(this)">
				    				</label>
				    			</th>
				    			<th style="background:#f6f6f6; text-align: left !important;">제목</th>
				    			<th style="background:#f6f6f6; text-align: left !important;">작성자</th>
				    			<th style="background:#f6f6f6; text-align: left !important;">작성일</th>
				    		</tr>
			    		</thead>
			    		
			    		<tbody>
			    		
				    		<c:if test="${fn:length(list) == 0}">
				    			
				    			<tr>
				    				<td colspan="4" align="center" style="height: 50">작성된 글이 없습니다.</td>
				    			</tr>
				    			
				    		</c:if>
				    		
				    		<c:if test="${fn:length(list) != 0}">
				    			
				    			<c:forEach var="library" items="${list}">
				    				
				    				<tr onclick="contentLib('${library.li_num}')">
										<td align="center">
											<label class="form-check-label">
												<input type="checkbox" class="form-check-input item" name="rowcheck" value="${library.li_num }">
											</label>
										</td>
										<td>${library.title}</td>
										<td>${library.writer}</td>
										<td>${library.day}</td>
				    				</tr>
				    				
				    			</c:forEach>
				    			
				    		</c:if>
			    		
			    		</tbody>
			    		
			    	</table>
		    	
		    	</form>
		    	
		    	<br>
		    	<div style="text-align: center;">
			    	${pageInfo.pagingHtml}
		    	</div>
		    	    	
    
    		</div>
          </div>
       </div>
    </div>
    
<%@ include file = "teacherBottom.jsp"%>
	