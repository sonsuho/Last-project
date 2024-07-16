<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

<!-- top.jsp 프로필 정보 => onclick="myPage()" -->

<style>
th {
	text-align: center !important;
}
</style>

<!-- 마이페이지 모달 -->
<div class="modal fade" id="myPageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myPageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width: 55%;">
    <div class="modal-content">
    	<div class="card">
 				<div class="card-body">
		      
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="myPageModalLabel" style="color:#c8c8c8; font-weight:bold;">
		        	마이페이지 &nbsp;&nbsp; <span id="modalState"></span>
		        </h1>
		      	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div> <br>
		      
		      <div class="modal-body">
		      	<form action="myPageUpdate.admin" method="post" enctype="multipart/form-data">
		      		<table class="table">
		      			<tr>
		      				<th rowspan=4 width=20% style="padding:50px;">
		      					<img src="resources/assets/images/faces/face10.jpg" style="width: 150px; height: 150px; object-fit: contain;" alt="profile"/> <br><br><br>
		      					<input type="button" onclick="alert('이미지 변경')" class="btn btn-sm btn-gradient-light" value="프로필 변경">
		      				</th>
		      				<th width=8% style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">이름</th>
		      				<td width=12% style="color: #323232;">${loginInfo.name}</td>
		      				<th width=8% style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">성별</th>
		      				<td width=12% style="color: #323232;">${loginInfo.gender}</td>
		      				<th width=8% style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">생년월일</th>
		      				<td width=12% style="color: #323232;">
		      					<fmt:parseDate var="birth" value="${loginInfo.birth}" pattern="yyyy-MM-dd" />
	                  <fmt:formatDate value="${birth}" pattern="yy.MM.dd" />
		      				</td>
		      				<th width=8% style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">나이</th>
		      				<td width=12% style="color: #323232;">
		      					<c:set var="currentDate" value="<%=new java.util.Date()%>" />
										<fmt:formatDate value="${currentDate}" pattern="yyyy" var="currentYear" />
										<fmt:formatDate value="${birth}" pattern="yyyy" var="birthYear" />
										<c:set var="age" value="${currentYear - birthYear}" />
										<c:if test="${currentDate.month < birth.month || ((currentDate.month == birth.month) && (currentDate.date < birth.date))}">
										    <c:set var="age" value="${age - 1}" />
										</c:if>
										만 ${age}세
		      				</td>
		      			</tr>
		      			<tr>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">아이디</th>
		      				<td colspan=3 style="color: #323232;">${loginInfo.id}</td>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">비밀번호</th>
		      				<td colspan=3><input type="button" onclick="resetPwModal()" class="btn btn-sm btn-gradient-light" value="비밀번호 변경"></td>
		      			</tr>
		      			<tr>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">이메일</th>
		      				<td colspan=3 style="color: #323232;">
		      					${loginInfo.email} &nbsp; <input type="button" value="변경" onclick="alert('이메일 변경')" class="btn btn-sm btn-rounded btn-gradient-light">
		      				</td>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">전화번호</th>
		      				<td colspan=3 style="color: #323232;">
		      					${loginInfo.phone} &nbsp; <input type="button" value="변경" onclick="alert('전화번호 변경')" class="btn btn-sm btn-rounded btn-gradient-light">
		      				</td>
		      			</tr>
		      			<tr>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">주소</th>
		      				<td colspan=7 style="color: #323232;">
		      					${loginInfo.addr} &nbsp; <input type="button" value="변경" onclick="alert('주소 변경')" class="btn btn-sm btn-rounded btn-gradient-light">
		      				</td>
		      			</tr>
		      		</table>
		      	</form>
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-gradient-info" style="opacity:65%" data-bs-dismiss="modal">닫기</button>
		      </div>
														      
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 비번 변경 모달 -->
<div class="modal fade" id="resetPwModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="resetPwModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
   	  <div class="card">
				<div class="card-body">
		      
		      <div class="modal-header">
		        <img src="resources/assets/images/logo_s.png" style="width: 80px;">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="color:#c8c8c8; font-weight:bold;">비밀번호 변경</h1>
		      </div> <br>
		      
		      <div class="modal-body">
		        <form name="changePwForm">
		          <input type="hidden" id="mem_num" name="mem_num">
		          <div class="form-group">
                <div class="input-group align-items-center">
                  <input type="text" value="현재 비밀번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
                  <div class="input-group-append">
            	    	<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요" class="form-control" style="width:250px; font-size: 13px;">
                  </div>
                </div>
           	  </div>
		          <div class="form-group">
                <div class="input-group align-items-center">
                  <input type="text" value="새 비밀번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
                  <div class="input-group-append">
            	    	<input type="password" name="pw1" id="pw1" placeholder="비밀번호를 입력하세요" class="form-control" style="width:250px; font-size: 13px;">
                  </div>
		          	</div>
		          </div>
		          <div class="form-group">
                <div class="input-group align-items-center">
                  <input type="text" value="비밀번호 확인" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
                  <div class="input-group-append">
            	    	<input type="password" name="pw2" id="pw2" placeholder="비밀번호를 입력하세요" class="form-control" style="width:250px; font-size: 13px;">
                  </div>
                </div>
           	  </div>
		        </form>
		      </div>
		      
		      <div class="modal-footer">
					  <button type="submit" onclick="return changePw()" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px;">변경하기</button>
					  <button type="button" onclick="closeResetPwModal()" class="btn btn-lg btn-light" data-bs-dismiss="modal">닫기</button>
		      </div>
														      
        </div>
      </div>
    </div>
  </div>
</div>
    
<script>
function myPage() {
	$('#myPageModal').modal('show');
}

function resetPwModal() {
	$('#myPageModal').animate({ opacity: 0.5 }, 300);
	$('#resetPwModal').modal('show');
}

function closeResetPwModal(){
	$('#myPageModal').animate({ opacity: 1 }, 300);
}

function changePw() {
	var pw = $('#pw').val();
	var pw1 = $('#pw1').val();
	var pw2 = $('#pw2').val();
	if(pw === ""){
		alert("현재 비밀번호를 입력하세요");
		$('#pw').focus();
		return false;
	} else if (pw1 === "") {
    alert('새 비밀번호를 입력하세요');
    $('#pw1').focus();
    return false;
  } else if (pw2 === "") {
    alert('비밀번호 확인을 입력하세요');
    $('#pw2').focus();
    return false;
  }
	$.ajax({
		url: "changePw.admin",
		type: "POST",
		data: {
			pw : pw,
			pw1 : pw1
		},
		success: function(response){
			if(pw1 !== pw2) {
		    alert('비밀번호 확인이 일치하지 않습니다');
		    $('#pw2').select();
		    return false;
		  } 
			if(response == "YES"){
			  alert('비밀번호가 변경되었습니다');
			  $('#myPageModal').animate({ opacity: 1 }, 300);
				$('#resetPwModal').modal('hide');
				$('#pw').val("");
				$('#pw1').val("");
				$('#pw2').val("");
			} else if(response == "NO"){
				alert("현재 비밀번호가 일치하지 않습니다");
				$('#pw').select();
				return false;
			} else if(response == "ERROR"){
				alert("비밀번호 재설정에 오류가 발생했습니다");
				$('#myPageModal').animate({ opacity: 1 }, 300);
				$('#resetPwModal').modal('hide');
				$('#pw').val("");
				$('#pw1').val("");
				$('#pw2').val("");
				return false;
			} else{
				alert("오류");
				$('#myPageModal').animate({ opacity: 1 }, 300);
				$('#resetPwModal').modal('hide');
				$('#pw').val("");
				$('#pw1').val("");
				$('#pw2').val("");
				return false;
			}
		}
	});
}
</script>
    