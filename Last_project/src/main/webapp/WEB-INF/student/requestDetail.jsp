<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>
 
<script>
function msitu(req_num, app_num){
	location.href="changeCompanion.student?req_num="+req_num+"&app_num="+app_num;
}

function psitu(req_num, app_num){
	location.href="changeApproval.student?req_num="+req_num+"&app_num="+app_num;
}
</script>
<h2>내(학생) 문서함</h2>

<h1>${title }</h1>
<form>
	<table>
		<tr>
			<td>
				요청 내용<br>
				${reason }<br><br>
				희망기간 ${time2 }<br><br>
			</td>
		</tr>
		<tr>
			<td>
				첨부파일<br>
				<c:forEach var="upload" items="${uploadList}">		
					
					<a href="<%=request.getContextPath() %>/resources/sign/${upload}" download="${upload}">
						<i class = "fa fa-download"></i>
						<span>${upload}</span>
					</a>
    			</c:forEach>
			</td>
		</tr>
		
	</table>
</form>
<%@ include file = "studentBottom.jsp"%>