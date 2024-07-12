<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
	
	<style type="text/css">
		
		.err{
			font-style: 15px;
			color: red;
		}
		
	</style>
	
	<script type="text/javascript">
	    function checkFileInput() {
	        var fileInput = document.getElementsByName('multiFile')[0];
	        var uploadField = document.getElementsByName('upload')[0];
	        
	        if (fileInput.files.length > 0) {
	            uploadField.value = '파일 존재';
	        } else {
	            uploadField.value = '';
	        }
	    }
	    
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
	    	</span> Write Library
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
		
		<h1>자료실 글 쓰기</h1> <br>
		
		<form:form commandName="library" action="writeLibrary.teacher" method="post" enctype="multipart/form-data">
		
			<table border="1">
				
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" value="${library.title}"> <br>
						<form:errors path="title" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td><textarea rows="5" cols="22" name="content">${library.content}</textarea> </td>
				</tr>
				
				<tr>
					<th>파일</th>
					<td>
						<input type="file" name="multiFile" multiple="multiple" onchange="checkFileInput()"> <br> 
						<input type="hidden" name="upload" value="" readonly="readonly">
						<form:errors path="upload" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><input type="submit" value="전송" onclick="return libCheck()"></td>
				</tr>
				
			</table>
		
		</form:form>
		
	</div>
	
<%@ include file = "teacherBottom.jsp"%>
	