<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "managerBarTop.jsp"%>

	<style type="text/css">
		
		.err{
			font-style: 15px;
			color: red;
		}
		
	</style>

	<script type="text/javascript">
	    function libCheck() {
			
	    	var title = document.getElementsByName('title')[0].value.trim();
	    	
	    	if (title === "") {
	            alert("제목을 입력하세요.");
	            document.getElementsByName('title')[0].focus();
	            return false;
	        }
	        return true;
		}
	</script>
	
	
		<!-- header -->
	<div class="page-header">
	  	<h3 class="page-title">
	    	<span class="page-title-icon bg-gradient-primary text-white me-2">
	      		<i class="mdi mdi-home"></i>
	    	</span> insert notice
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
		
		<h1>공지사항 글 쓰기</h1> <br>
		
		<form:form commandName="notice" action="noticeInsert.manager" method="post">
		
			<table border="1">
				
				<tr>
					<th>lec_num</th>
					<td>
						<input type="text" name="lec_num" value="${notice.lec_num}" disabled> <br>
					</td>
				</tr>
				
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" value="${notice.title}"> <br>
						<form:errors path="title" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="5" cols="22" name="content">${notice.content}</textarea>
						<form:errors path="content" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><input type="submit" value="삽입" onclick="return libCheck()"></td>
				</tr>
			</table>
		</form:form>
		
	</div>
	
<%@ include file = "managerBarBottom.jsp"%>