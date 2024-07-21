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
	
	<center>
		
		<h1>공지사항 글 수정</h1>
		
		<form:form commandName="notice" action="noticeUpdate.manager" method="post">
			
			<input type="hidden" name="n_num" value="${notice.n_num}">
			
			<table>
				
				<tr>
					<th>강좌번호</th>
					<td>
						<input type="text" name=lec_num value="${notice.lec_num}" disabled> <br>
						<input type="hidden" name=lec_num value="${notice.lec_num}">
					</td>
				</tr>
				
				<tr>
					<th>반</th>
					
					<td>
						<input type="text" name=class_name value="${notice.class_name}" disabled> <br>
						<input type="hidden" name=class_name value="${notice.class_name}"> <br>
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
					<td><textarea rows="5" cols="22" name="content">${notice.content}</textarea> </td>
				</tr>
				
				<tr>
					<td colspan="2"><input type="submit" value="수정" onclick="return libCheck()"></td>
				</tr>
			</table>
		</form:form>
		
	</center>
<%@ include file = "managerBarBottom.jsp"%>