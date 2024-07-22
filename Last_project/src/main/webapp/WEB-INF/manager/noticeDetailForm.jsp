<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${loginInfo.category == 'manager'}">
   <%@include file = "managerBarTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
   <%@include file = "../student/studentTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
	<%@include file = "../teacher/teacherTop.jsp"%>
</c:if>

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
    
    </script>
	
	<!-- header -->
  	<div class="page-header">
   		<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> Notice Detail
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
		
		<div style="border: 1px solid black; width: 800;">
		
			<h1>자료글 내용</h1>
			
			<div align="left" style="padding-left: 45px;">
			
				공개대상 : ${notice.class_name } <br><br>
				
				제목 : ${notice.title} <br><br>
				
				작성자 : ${notice.writer} <br><br>
				
				작성일 : ${notice.day } <br><br>
				
				내용 : ${notice.content } <br><br>
				
				
			
			</div>
			
			<br>
			
			<!-- 자신의 반 공지사항은 자신만 수정 및 삭제가 가능하도록 -->
			<c:if test="${notice.lec_num == loginInfo.lec_num && loginInfo.category == 'manager'}">
				<a href="noticeUpdate.manager?n_num=${notice.n_num}">수정</a>
				<a href="noticeDelete.manager?n_num=${notice.n_num}">삭제</a>
			</c:if>

			<br>
			
		</div>
		
		<br><br><br>
    	
    	<form name="myform" action="deleteAllNotice.manager">
    	
	    	<table border="1">
	    		
	    		<tr>
	    			<td colspan="6" align="right" bgcolor="#BBFFDD">
	    				<a href="noticeInsert.manager?pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">글쓰기</a>
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    		
		    		<th>
			    		<c:if test="${loginInfo.category == 'manager'}">
							<input type="checkbox" name="allcheck" onclick="allCheck(this)">
						</c:if>
		    		</th>	
	    			<th>제목</th>
	    			<th>작성자</th>
	    			<th>작성일</th>
	    			<th>반</th>
	    		</tr>
	    		
	    		<c:if test="${fn:length(noticeList) == 0}">
	    			
	    			<tr>
	    				<td colspan="4" align="center" style="height: 50">공지사항에 작성된 글이 없습니다!!</td>
	    			</tr>
	    			
	    		</c:if>
	    		
	    		<c:if test="${fn:length(noticeList) != 0}">
	    			
	    			<c:forEach var="element" items="${noticeList}">
	    				
	    				<tr>
	    					<td align="center">
		    					<c:if test="${loginInfo.category == 'manager'}">
			    					<c:if test="${element.lec_num == loginInfo.lec_num}">
											<input type="checkbox" name="rowcheck" value="${element.n_num }">
			    					</c:if>
		    					</c:if>
							</td>
							
							
							<td>
								<c:if test="${notice.n_num == element.n_num}">
									<a href="noticeDetail.manager?n_num=${element.n_num}"><font size="15" color="red">${element.title}</font></a>							
								</c:if>
								
								<c:if test="${notice.n_num != element.n_num}">
									<a href="noticeDetail.manager?n_num=${element.n_num}">${element.title}</a>							
								</c:if>
							</td>
							<td>${element.writer}</td>
							<td>${element.day}</td>
							<td>${element.class_name}</td>
	    				</tr>	
	    			</c:forEach>
	    		</c:if>
	    	</table>
    	</form>
    	
    	<br>
    	${pageInfo.pagingHtml}
    	    	
    	<form action="notice.manager">
    		
    		<select name="whatColumn">
    			<option value="all">전체검색</option>
    			<option value="title">제목</option>
    			<option value="content">내용</option>
    		</select>
    		
    		<input type="text" name="keyword">
    		
    		<input type="submit" value="검색">
    		
    	</form>
    	
    	<c:if test="${loginInfo.category == 'manager'}">
			<input type="button" value="삭제" onclick="selectDelete()">
	    </c:if>
	</div>
	
<c:if test="${loginInfo.category == 'manager'}">
   <%@include file = "managerBarBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
   <%@include file = "../student/studentBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
	<%@include file = "../teacher/teacherBottom.jsp"%>
</c:if>