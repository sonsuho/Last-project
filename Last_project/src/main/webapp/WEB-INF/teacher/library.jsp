<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> TeacherMain
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
    	
    	<h1>자료실 목록</h1>
    	
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
	    			
	    			<c:forEach var="library" items="${list}">
	    				
	    				<tr>
							<td align="center"><input type="checkbox" name="rowcheck" value="${library.li_num }"></td>
							<td><a href="contentLibrary.teacher?li_num=${library.li_num}">${library.title}</a></td>
							<td>${library.writer}</td>
							<td>${library.day}</td>
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
		
    </div>
    
<%@ include file = "teacherBottom.jsp"%>
	