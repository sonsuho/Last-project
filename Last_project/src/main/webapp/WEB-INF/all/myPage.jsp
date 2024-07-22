<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

<!-- top.jsp 프로필 정보 => onclick="myPage()" -->

<style>
th {
	text-align: center !important;
}
.input_wrap {display: flex;align-items: center; width: 100%;}
.code_wrap {position: relative;}
.code_wrap .time {position: absolute;top:50%;right: 15px;font-size: 13px; transform: translate(0,-50%);}
</style>

<!-- 마이페이지 모달 -->
<div class="modal fade" id="myPageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myPageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width: 55%;">
    <div class="modal-content">
    	<div class="card">
 				<div class="card-body">
		      
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="myPageModalLabel" style="color:#c8c8c8; font-weight:bold;">
		        	마이페이지 &nbsp;&nbsp;
		        </h1>
		      	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div> <br>
		      
		      <div class="modal-body">
		      	<form action="myPageUpdate.admin" method="post" enctype="multipart/form-data">
		      		<table class="table">
		      			<tr>
		      				<th rowspan=4 width=20% style="padding:50px;">
		      					<img src="resources/assets/images/faces/${loginInfo.image}" style="width: 125px; height: 125px; object-fit: contain;" alt="profile"/> <br><br><br>
		      					<input type="button" onclick="resetImageModal()" class="btn btn-sm btn-gradient-light" value="프로필 변경">
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
		      					${loginInfo.email} &nbsp; <!-- <input type="button" value="변경" onclick="alert('이메일 변경')" class="btn btn-sm btn-rounded btn-gradient-light"> -->
		      				</td>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">전화번호</th>
		      				<td colspan=3 style="color: #323232;">
		      					<span id="myphone">${loginInfo.phone}</span> &nbsp; 
		      					<input type="button" value="변경" onclick="resetPhoneModal()" class="btn btn-sm btn-rounded btn-gradient-light">
		      				</td>
		      			</tr>
		      			<tr>
		      				<th style="background: #E8F5FF; color: #1E3269;" style="padding:30px;">주소</th>
		      				<td colspan=7 style="color: #323232;">
		      					<span id="myaddr">${loginInfo.addr}</span> &nbsp;
		      					<input type="button" value="변경" onclick="resetAddr(this)" class="btn btn-sm btn-rounded btn-gradient-light">
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
		        <h1 class="modal-title fs-5" id="resetPwModalLabel" style="color:#c8c8c8; font-weight:bold;">비밀번호 변경</h1>
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
					  <button type="submit" onclick="return changePw()" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px;">변경</button>
					  <button type="button" onclick="closeModal()" class="btn btn-lg btn-light" data-bs-dismiss="modal">닫기</button>
		      </div>
														      
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 전화번호 변경 모달 -->
<div class="modal fade" id="resetPhoneModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="resetPhoneModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
   	  <div class="card">
				<div class="card-body">
		      
		      <div class="modal-header">
		        <img src="resources/assets/images/logo_s.png" style="width: 80px;">
		        <h1 class="modal-title fs-5" id="resetPhoneModalLabel" style="color:#c8c8c8; font-weight:bold;">전화번호 변경</h1>
		      </div> <br>
		      
		      <div class="modal-body">
		        <form name="changePwForm">
		          <input type="hidden" id="mem_num" name="mem_num">
		          <div class="form-group">
                <div class="input-group align-items-center">
                  <input type="text" value="현재 전화번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
                  <div class="input-group-append">
            	    	<input type="text" id="nowphone" value="${loginInfo.phone}" class="form-control" style="width:250px; font-size: 13px; background: white;" disabled>
                  </div>
                </div>
           	  </div>
		          <div class="form-group">
                <div class="input-group align-items-center">
                  <input type="text" value="새 전화번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
                  <div class="input-group-append">
            	    	<input type="text" name="phone" id="userPhone" maxlength="11" placeholder="반드시 ' - ' 없이 입력하세요" class="form-control" style="width:250px; font-size: 13px;">
                  </div>
                </div>
           	  </div>
           	  <div class="form-group">
							  <div class="input-group align-items-center">
							    <div class="input_wrap">
							      <div class="code_wrap">
									    <input type="tel" name="code" id="code_send" placeholder="인증번호를 발급받으세요" class="form-control" style="width:204px; font-size: 13px;" disabled>
									    <input type="tel" name="code" id="code_check" placeholder="인증번호를 입력하세요" class="form-control" style="display:none; width:235px; font-size: 13px;">
									    <span class="time text-primary" id="time"></span>
									  </div>
								    <div class="input-group-append">
								      <button type="button" onclick="sendAuthCode()" id="btn_send" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px;">인증번호 발급</button>
								      <button type="button" onclick="checkAuthCode()" id="btn_check" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px; display:none;">인증하기</button>
								    </div>
								  </div>
							  </div>
							</div>
		        </form>
		      </div>
		      
		      <div class="modal-footer">
					  <button type="button" onclick="closeModal()" class="btn btn-lg btn-light" data-bs-dismiss="modal">닫기</button>
		      </div>
														      
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 프로필 변경 모달 -->
<div class="modal fade" id="resetImageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="resetImageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width: 45%;">
    <div class="modal-content">
      <div class="card">
        <div class="card-body">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="resetImageModalLabel" style="color:#c8c8c8; font-weight:bold;">프로필 변경</h1>
            <button type="button" onclick="closeModal()" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div> <br>

          <div class="modal-body">
            <table class="table">
              <c:forEach var="i" begin="1" end="29">
                <c:if test="${i%6 eq 1}"><tr></c:if>
                <c:if test="${i eq 1}"><tr><td onclick="showImageName('user.jpg')" onmouseover="hoverEffect(this)" onmouseout="removeHoverEffect(this)"><img src="resources/assets/images/faces/user.jpg" style="width: 80px; height: 80px; object-fit: contain;" alt="profile" /></td></c:if>
                <c:if test="${i eq 2}"><td onclick="showImageName('user2.jpg')" onmouseover="hoverEffect(this)" onmouseout="removeHoverEffect(this)"><img src="resources/assets/images/faces/user2.jpg" style="width: 80px; height: 80px; object-fit: contain;" alt="profile"/></td></c:if>
                <c:if test="${i ne 1 and i ne 2}"><td onclick="showImageName('face${i-2}.jpg')" onmouseover="hoverEffect(this)" onmouseout="removeHoverEffect(this)"><img src="resources/assets/images/faces/face${i-2}.jpg" style="width: 80px; height: 80px; object-fit: contain;" alt="profile"/></td></c:if>
                <c:if test="${i%6 eq 0}"></tr></c:if>
              </c:forEach>
            </table>
          </div> <br>

          <div class="modal-footer">
            <button type="submit" onclick="return changeImage()" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px;">변경</button>
            <button type="button" onclick="closeModal()" class="btn btn-lg btn-light" data-bs-dismiss="modal">닫기</button>
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

function resetAddr(btn) {
	btn.style.display = 'none';

  var addrTd = document.getElementById("myaddr");
  var newAddrInput = document.createElement("input");
  newAddrInput.type = "text";
  newAddrInput.value = addrTd.textContent;
  newAddrInput.classList.add("form-control");
  newAddrInput.style.width = "500px";
  newAddrInput.style.marginRight = "20px";

  var saveBtn = document.createElement("button");
  saveBtn.type = "button";
  saveBtn.classList.add("btn", "btn-sm", "btn-rounded", "btn-gradient-light");
  saveBtn.textContent = "저장";
  saveBtn.onclick = function() {
    changeAddr(newAddrInput.value);
  };

  var wrapper = document.createElement("div");
  wrapper.classList.add("d-flex", "align-items-center");
  wrapper.appendChild(newAddrInput);
  wrapper.appendChild(saveBtn);

  addrTd.innerHTML = "";
  addrTd.appendChild(wrapper);
}

function changeAddr(addr){
	$.ajax({
    url: "changeAddr.admin",
    type: "POST",
    data: { addr: addr },
    success: function(response) {
      // 화면 업데이트
      if(response != "NO"){
    	  alert("주소가 변경되었습니다");
	      var addrTd = document.getElementById("myaddr");
	      addrTd.textContent = addr;
	      addrTd.innerHTML = addr + " &nbsp; <input type='button' value='변경' onclick='resetAddr()' class='btn btn-sm btn-rounded btn-gradient-light'>";
      } else{
    	  alert("주소 변경에 실패했습니다.");
      }
    },
    error: function(xhr, status, error) {
      alert("주소 변경에 실패했습니다.");
    }
  });
}

function resetPwModal() {
	$('#myPageModal').animate({ opacity: 0.5 }, 300);
	$('#resetPwModal').modal('show');
}

var selectedImage = null;
var image = null;

function resetImageModal() {
	$('#myPageModal').animate({ opacity: 0.5 }, 300);
	$('#resetImageModal').modal('show');
}

function hoverEffect(element) {
  element.style.cursor = 'pointer';
  element.style.backgroundColor = '#f0f0f0';
}

function removeHoverEffect(element) {
  if (element !== selectedImage) {
    element.style.backgroundColor = 'transparent';
  }
}

function changeImage() {
  if(image != null){
	  $.ajax({
		  type: "POST",
		  data: {
			  image: image
		  },
		  url: "changeImage.admin",
		  success: function(response){
			  if(response != "NO"){
				  alert("이미지가 변경되었습니다 (새로고침한 뒤 적용됩니다)");
			  }else{
				  alert("다시 시도해주세요");
			  }
		  }
	  });
  } else{
	  alert("이미지를 선택하세요");
	  return false;
  }
	closeModal();
  return true;
}

function showImageName(imageName) {
  if (selectedImage) {
    selectedImage.style.opacity = '1';
  }
  selectedImage = event.currentTarget;
  selectedImage.style.opacity = '0.5';
  image = imageName;
}

function closeModal(){
	$('#myPageModal').animate({ opacity: 1 }, 300);
	$('#userPhone').val('');
	$('#code').val('');
	clearInterval(countdown);
  $('#time').text('');
	$('#btn_check').hide();
  $('#code_check').val('');
  $('#code_check').hide();
  $('#btn_send').show();
  $('#code_send').show();
  seconds = 0;
  if (selectedImage) {
    selectedImage.style.opacity = '1';
  }
  selectedImage = null;
  image = null;
  $('#resetImageModal').modal('hide');
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

function resetPhoneModal(){
	$('#myPageModal').animate({ opacity: 0.5 }, 300);
	$('#resetPhoneModal').modal('show');
}
   
var code; // 인증번호 담을 변수
// 인증번호 발급 클릭시
function sendAuthCode() {
  var userPhone = document.getElementById('userPhone').value;
  if(userPhone.length == 0){ // 1. 새 전화번호 입력 안한경우
	  alert('새 전화번호를 입력하세요');
		$('#userPhone').focus();
  	return false;
  } else if(!isValidUserPhone(userPhone)){ // 2. 전화번호가 010으로 시작하지 않거나 11자리가 아닌경우
	  alert('전화번호가 올바르지 않습니다');
		$('#userPhone').select();
	  return false;
  } else {  			  
		$.ajax({
	    type: "POST",
	    url: "sendSms.in",
	    data: {
	      userPhone: userPhone
	    },
	    success: function(response) {
	    	alert("인증번호가 발송되었습니다");
	    	code = response;
      	startTimer();
      	$('#btn_send').hide();
      	$('#code_send').hide();
      	$('#btn_check').show();
      	$('#code_check').show();
	    },
	    error: function() {
	      alert("오류 발생 :: 다시 시도해주세요");
	    }
		});
  }
  function isValidUserPhone(userPhone) {
		return /^(010)\d{8}$/.test(userPhone);
	}
}
function checkAuthCode(){
	if($('#code_check').val()==""){
		alert('발급된 인증번호를 입력하세요');
		$('#code_check').focus();
		return false;
	} else if($('#code_check').val()!=code){
		alert('인증번호가 일치하지 않습니다');
		$('#code_check').select();
		return false;
	} else if($('#code_check').val()==code){
		alert('인증번호 일치');
		$.ajax({
			type: "POST",
			data: {
				userPhone: $('#userPhone').val()
			},
			url: "changePhone.admin",
			success: function(response) {
				if(response != "NO"){
					alert('전화번호가 성공적으로 변경되었습니다');
					document.getElementById('myphone').innerHTML = response;
					document.getElementById('nowphone').value = response;
				} else{
					alert("오류 발생 :: 다시 시도해주세요");
				}
				$('#resetPhoneModal').modal('hide');
				closeModal();
	    }
		});
	}
}
// 타이머 변수
var seconds; // 남은시간
var countdown; // 카운트다운 관리
// 타이머 시작 함수
function startTimer() {
  clearInterval(countdown);
  seconds = 180; // 3분(180초)
  updateCountdown();
  countdown = setInterval(updateCountdown, 1000); // 1초마다 업데이트
}
// 시간을 업데이트하고 화면에 표시하는 함수
function updateCountdown() {
  if (seconds >= 0) {
	  var minutes = Math.floor(seconds/60).toString().padStart(2,'0');
    var remainingSeconds = (seconds%60).toString().padStart(2,'0');
    $('#time').text(minutes+":"+remainingSeconds);
    seconds--;
  } else {
	  clearInterval(countdown);
	  $('#time').text('');
    $('#btn_check').hide();
    $('#code_check').hide();
	  $('#btn_send').show();
	  $('#code_send').show();
    alert('인증번호를 다시 요청하세요');
  }
}
</script>
    