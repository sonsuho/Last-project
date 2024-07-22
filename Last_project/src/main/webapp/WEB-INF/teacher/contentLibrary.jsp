<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

<%@ include file = "teacherTop.jsp"%>
	
	<style type="text/css">
    	
    	table {
			width: 650px;
		}
    	
    </style>
    
	<script type="text/javascript">
    	
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
    			
    			if(rcheck[i].checked == true){
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
    	
    	// 뒤로가기
    	function back(){
    		location.href="javascript:history.back();";
    	}
    	
    	// 삭제하기
    	function deleteLibrary(li_num){
    		location.href="deleteLibrary.teacher?li_num=" + li_num;
    	}
    	
    	// 수정하기
    	function updateLibrary(li_num){
    		location.href="updateLibrary.teacher?li_num=" + li_num;
    	}
    
    </script>
	
	<!-- header -->
    <div class="page-header">
      <div class="input-group-append">
        <button class="btn btn-sm" type="button" onclick="back()"><i class="fa fa-chevron-left"></i> &nbsp;&nbsp; 뒤로가기</button>
      </div>
    </div>
	
	<div class="row">
       <div class="col-lg-12 grid-margin stretch-card">
          <div class="card">
             <div class="card-body">
    
    			<div class="row">
    				<div class="col-lg-12">
				    	<h1>${library.title}</h1>
				    	<div style="color: #999; margin: 20px 0; display:flex; justify-content:space-between; align-items: center; border-bottom:1px solid #000; font-size: 15px;">
				    		<div style="display:flex; justify-content: flex-start; align-items: center;">
					    		<p><b>${library.writer}</b></p>
					    		<p style="padding:0 10px;">|</p>
					    		<p>${library.day }</p>
				    		</div>
				    		<div style="display:flex; justify-content: flex-end; align-items: center; margin-bottom: 16px;">
				    			<c:if test="${library.mem_num == loginInfo.mem_num }">
									<div style="margin-right: 10px;">
				    					<button type="button" class="btn btn-gradient-light btn-sm" onclick="updateLibrary('${library.li_num}')"><img src="resources/images/update.png" style="width:24px; height:24px;">수정</button>
			    					</div>
			    					<div>
				    					<button type="button" class="btn btn-gradient-light btn-sm" onclick="deleteLibrary('${library.li_num}')"><img src="resources/images/delete.png" style="width:24px; height:24px;">삭제</button>
			    					</div>
		    					</c:if>
				    		</div>
				    		
				    	</div>
				    	<div style="padding: 30px 0 50px; font-size: 16px;">
				    		${library.content }
				    	</div>
				    	<div>
				    		<p style="margin-bottom: 10px;">
				    			<b>첨부파일</b>
				    		</p>
				    		<div>
				    			<c:forEach var="upload" items="${uploadList}">		
					
								<a href="<%=request.getContextPath() %>/resources/libraryFiles/${upload}" download="${upload}" style="margin-bottom: 10px;">
									<img src="resources/images/download.png" width="20" height="20">
									<span>${upload}</span>
								</a>
								
								<br>
								
							</c:forEach>
				    		</div>
				    	</div>
    				</div>
    			</div>
    			
    		 </div>
    		 
    	  </div><!-- card end -->
       </div><!-- gol-lg-12 end -->
    </div>




<!-- 수호씨 코드  -->	
<%-- 	<div align="center">
		
		<div style="border: 1px solid black; width: 800;">
		
			<h1>자료글 내용</h1>
			
			<div align="left" style="padding-left: 45px;">
			
				제목 : ${library.title} <br><br>
				
				작성자 : ${library.writer} <br><br>
				
				작성일 : ${library.day } <br><br>
				
				내용 : ${library.content } <br><br>
			
				<c:forEach var="upload" items="${uploadList}">		
					
					<a href="<%=request.getContextPath() %>/resources/libraryFiles/${upload}" download="${upload}">
						<img src="resources/images/download.png" width="20" height="20">
						<span>${upload}</span>
					</a>
					
					<br>
					
				</c:forEach>
			
			</div>
			
			<br>
			
			<a href="updateLibrary.teacher?li_num=${library.li_num}">수정</a>
			
			<a href="deleteLibrary.teacher?li_num=${library.li_num}">삭제</a>
			
			<br>
			
		</div>
		
		<br><br><br>
    	
    	<form name="myform" action="deleteAllLibrary.teacher">
    	
	    	<table border="1">
	    		
	    		<tr>
	    			<td colspan="6" align="right" bgcolor="#BBFFDD">
	    				<a href="writeLibrary.teacher?pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">글쓰기</a>
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<th><input type="checkbox" name="allcheck" onclick="allCheck(this)"></th>
	    			<th>제목</th>
	    			<th>작성자</th>
	    			<th>작성일</th>
	    		</tr>
	    		
	    		<c:if test="${fn:length(list) == 0}">
	    			
	    			<tr>
	    				<td colspan="4" align="center" style="height: 50">자료실에 작성된 글이 없습니다!!</td>
	    			</tr>
	    			
	    		</c:if>
	    		
	    		<c:if test="${fn:length(list) != 0}">
	    			
	    			<c:forEach var="element" items="${list}">
	    				
	    				<tr>
							<td align="center"><input type="checkbox" name="rowcheck" value="${element.li_num }"></td>
							<td>
								<c:if test="${library.li_num == element.li_num}">
									<a href="contentLibrary.teacher?li_num=${element.li_num}"><font size="15" color="red">${element.title}</font></a>							
								</c:if>
								
								<c:if test="${library.li_num != element.li_num}">
									<a href="contentLibrary.teacher?li_num=${element.li_num}">${element.title}</a>							
								</c:if>
							</td>
							<td>${element.writer}</td>
							<td>${element.day}</td>
	    				</tr>
	    				
	    			</c:forEach>
	    			
	    		</c:if>
	    		
	    	</table>
    	
    	</form>
    	
    	<br>
    	
    	${pageInfo.pagingHtml}
    	    	
    	<form action="library.teacher">
    		
    		<select name="whatColumn">
    			<option value="all">전체검색</option>
    			<option value="title">제목</option>
    			<option value="content">내용</option>
    		</select>
    		
    		<input type="text" name="keyword">
    		
    		<input type="submit" value="검색">
    		
    	</form>
    	
    	<input type="button" value="삭제" onclick="selectDelete()">
		
	</div> --%>


<%@ include file = "teacherBottom.jsp"%>


	