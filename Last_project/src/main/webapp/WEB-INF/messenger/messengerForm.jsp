<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!-- messengerForm.jsp<br> -->

<style>
	.err {font-size: 9px; color: red;}
</style>
<script>
	function allCheck(obj){
		var rcheck = document.getElementsByName('rowcheck');
		var check = obj.checked;
		
		if(check) {
			for(var i=0; i< rcheck.length; i++) {
				rcheck[i].checked = true;
			}
		} else {
			for(var i=0; i< rcheck.length; i++) {
				rcheck[i].checked = false;
			}
		}
	}
	
	function selectSend(){
		var flag = false;
		
		var rcheck = document.getElementsByName("rowcheck");
		
		for(var i=0; i<rcheck.length; i++){
			if(rcheck[i].checked == true){
				flag = true;
				break;
			}
		}
		var chk_txt = document.getElementById('chk_txt');
		var txt1 = document.getElementById('txt1');
		var txt2 = document.getElementById('txt2');
		
		if(!flag) {
			chk_txt.innerHTML = '받는 사람을 선택하세요.';
			return false;
		}
		/*
		if(msgForm.title.value.length == 0) {
			txt1.innerHTML = "제목을 입력하세요.";
			msgForm.title.focus();
			return false;
		}
		
		
		 if(msgForm.content.value = "") {
			txt2.innerHTML = "내용을 입력하세요.";
			msgForm.content.focus();
			return false;
		} */
		
		//document.msgForm.submit();
		
	}

	function checkFileInput(){
		var fileInput = document.getElementsByName("msg_upload")[0];
		var uploadField = document.getElementsByName("upload")[0];
		
		if(fileInput.files.length > 0) {
			uploadField.value = "파일 존재";
		} else {
			uploadField.value = "";
		}
	}
</script>


<h3>메세지 보내기</h3><a href="rlist.messenger">받은 메신저함</a>

<form name="msgForm" action="send.messenger" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<th>받는사람</th>
			<td>
				<p>
					<input type="checkbox" name="allcheck" onclick="allCheck(this)">전체선택
				</p>
				<label>매니저</label>
				<c:forEach var="mb" items="${managerlist }">
					<p>
						<input type="checkbox" name="rowcheck" value="${mb.mem_num }">${mb.name }
					</p>
				</c:forEach>
				
				<label>강사</label>
				<c:forEach var="mb" items="${teacherlist }">
					<p>
						<input type="checkbox" name="rowcheck" value="${mb.mem_num }">${mb.name }
					</p>
				</c:forEach>
				
				<label>학생</label>
				<c:forEach var="mb" items="${studentlist }">
					<p>
						<input type="checkbox" name="rowcheck" value="${mb.mem_num }">${mb.name }
					</p>
				</c:forEach>
				<p id="chk_txt" style="color: red; font-size: 12px;"></p>
			</td>
		</tr>	
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" required>
				<p id="txt1" style="color: red; font-size: 12px;"></p>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="content" cols="100" rows="5" required></textarea>
				<p id="txt2" style="color: red; font-size: 12px;"></p>
			</td>
		</tr>
		<tr>
			<th>파일 첨부</th>
			<td>
				<input type="file" name="msg_upload" multiple="multiple" onchange="checkFileInput()"> <br>
				<input type="hidden" name="upload" value="" readonly>
			</td>
		</tr>
		
		<tr>
			<th colspan="2"><input type="submit" value="쪽지보내기" onclick="return selectSend()"></th>
		</tr>
	</table>
</form>