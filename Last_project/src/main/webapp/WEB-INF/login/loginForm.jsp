<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

    <!-- plugins:css -->
    <link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="resources/assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="resources/assets/images/favicon.png" />
    <style>
		.err{
			color: red;
			font-size: 15;
		}
		.input_wrap {display: flex;align-items: center; width: 100%;}
		.code_wrap {position: relative;}
		.code_wrap .time {position: absolute;top:50%;right: 15px;font-size: 13px; transform: translate(0,-50%);}
		</style>

    <div class="container-scroller">
	  <div class="container-fluid page-body-wrapper full-page-wrapper">
	    <div class="content-wrapper d-flex align-items-center auth">
	      <div class="row flex-grow">
	        <div class="col-lg-4 mx-auto">
	          <div class="auth-form-light text-left p-5">
	            <div class="brand-logo">
	              <img src="resources/assets/images/logo_s.png" style="width: 80px;">
	            </div>
	            
	            <!-- 로그인 form -->
	            <form:form commandName="login" action="login.in" method="post" class="pt-3">
	              <div class="form-group">
	                <input type="text" name="id" value="${login.id}" placeholder="아이디" class="form-control form-control-lg">
	              </div>
	              <div class="form-group">
	                <input type="password" name="pw" value="${login.pw}" placeholder="비밀번호" class="form-control form-control-lg">
	              </div>
	              
	              <c:if test="${login.id == ''}">															<!-- 아이디 누락시 -->
	                <form:errors path="id" cssClass="err"/>
	              </c:if>
	              <c:if test="${login.id != ''}">															<!-- 아이디 입력하고 비밀번호 누락시 -->
	                <c:if test="${login.pw == ''}">
	                  <form:errors path="pw" cssClass="err"/>
	                </c:if>
	              </c:if>
	              <c:if test="${fail == 'fail'}">															<!-- 아이디 비밀번호 다 입력했는데 -->
	                <span style="font-size: 15; color: red;">아이디 또는 비밀번호를 잘못 입력했습니다.</span>			<!-- 해당하는 아이디가 없거나 -->
	              </c:if>	
	              
	              <div class="mt-3 d-grid gap-2">
	                <input type="submit" value="로그인" class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn">
	              </div>
	              
	              <br>
	              
	              <div class="my-2 d-flex justify-content-end align-items-center">
	                <font class="auth-link text-secondary">비밀번호를 잊으셨나요?</font> 
									<button type="button" class="btn btn-link auth-link text-primary" style="padding-left: 15px; padding-right: 0px;" data-bs-toggle="modal" data-bs-target="#staticBackdrop">비밀번호 찾기</button>
	              </div>
	              
	            </form:form>
	            
							<!-- 비밀번호 찾기 모달 -->
							<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered">
							    <div class="modal-content">
					      	  <div class="card">
			     						<div class="card-body">
									      
									      <div class="modal-header">
									        <img src="resources/assets/images/logo_s.png" style="width: 80px;">
									        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="color:#c8c8c8; font-weight:bold;">비밀번호 찾기</h1>
									      </div> <br>
									      
									      <div class="modal-body">
									        <form method="post" action="findPw.in">
									          <div class="form-group">
					                    <div class="input-group align-items-center">
					                      <input type="text" value="아이디" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
					                      <div class="input-group-append">
					                	    	<input type="text" name="id" id="userId" placeholder="아이디를 입력하세요" class="form-control" style="width:275px; font-size: 13px;">
					                      </div>
									          	</div>
									          </div>
									          <div class="form-group">
					                    <div class="input-group align-items-center">
					                      <input type="text" value="전화번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
					                      <div class="input-group-append">
					                	    	<input type="text" name="phone" id="userPhone" maxlength="11" placeholder="반드시 ' - ' 없이 입력하세요" class="form-control" style="width:275px; font-size: 13px;">
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
									        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="clearInputFields()">닫기</button>
									      </div>
																					      
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
							
							<!-- 비밀번호 변경 모달 -->
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
									        <form name="changePwForm" method="post" action="changePw.in">
									          <input type="hidden" id="mem_num" name="mem_num">
									          <div class="form-group">
					                    <div class="input-group align-items-center">
					                      <input type="text" value="새 비밀번호" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
					                      <div class="input-group-append">
					                	    	<input type="password" name="pw" id="pw1" placeholder="비밀번호를 입력하세요" class="form-control" style="width:275px; font-size: 13px;">
					                      </div>
									          	</div>
									          </div>
									          <div class="form-group">
					                    <div class="input-group align-items-center">
					                      <input type="text" value="비밀번호 확인" class="form-control" style="font-size: 13px; font-weight: bold;" disabled>
					                      <div class="input-group-append">
					                	    	<input type="password" name="pw2" id="pw2" placeholder="비밀번호를 입력하세요" class="form-control" style="width:275px; font-size: 13px;">
					                      </div>
					                    </div>
					               	  </div>
					               	  <div class="form-group">
														  <div class="input-group align-items-center">
															  <button type="submit" onclick="return changePw()" class="btn btn-lg btn-gradient-primary" style="padding-top:16px; padding-bottom:16px;">변경하기</button>
														  </div>
														</div>
									        </form>
									      </div>
									      
									      <div class="modal-footer">
									        
									      </div>
																					      
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
	            
	          </div>
	        </div>
	      </div>
	    </div>
	    <!-- content-wrapper ends -->
	  </div>
	  <!-- page-body-wrapper ends -->
	</div>
	
	
    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="resources/assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->
    
    <!-- inject:js -->
    <script src="resources/assets/js/off-canvas.js"></script>
    <script src="resources/assets/js/misc.js"></script>
    <script src="resources/assets/js/settings.js"></script>
    <script src="resources/assets/js/todolist.js"></script>
    <script src="resources/assets/js/jquery.cookie.js"></script>
    <script src="resources/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
			/* 비밀번호 찾기 모달 시작 */    
    	var code; // 인증번호 담을 변수
    	var mem_num; // 회원번호 담을 변수
    	// 비밀번호 찾기 => 인증번호 발급 클릭시
    	function sendAuthCode() {
    	  // 아이디와 전화번호 유효성 검사 진행
    	  var userId = document.getElementById('userId').value;
    	  var userPhone = document.getElementById('userPhone').value;
  		  // 1. 아이디 또는 전화번호 입력 안한경우
  		  if(userId.length == 0){
  				alert('아이디를 입력하세요');
  				$('#userId').focus();
  		  	return false;
  		  }else if(userPhone.length == 0){
  			  alert('전화번호를 입력하세요');
  				$('#userPhone').focus();
  		  	return false;
  		  }
  		  // 2. 전화번호가 010으로 시작하지 않거나 11자리가 아닌경우
  		  else if(!isValidUserPhone(userPhone)){
  			  alert('전화번호가 올바르지 않습니다');
  				$('#userPhone').select();
  			  return false;
  		  }
  		  else {  			  
	  			$.ajax({
  			    type: "POST",
  			    url: "findPw.in",
  			    data: {
  			      userId: userId,
  			      userPhone: userPhone
  			    },
  			    success: function(response) {
  			    	var responseArray = response.split(",");
  			      if (responseArray[0]=="NO") {
  			    		// 3. 아이디+전화번호 등록된 회원이 없는경우
  			    		alert("일치하는 회원정보가 없습니다");
  			      } else {
  			    		// 4. 인증번호 발송 (인증번호가 response에 담김)
  			    		code = responseArray[0];
  			    		mem_num = responseArray[1];
  			        alert("인증번호가 발송되었습니다");
  			      	startTimer();
  			      	$('#btn_send').hide();
  			      	$('#code_send').hide();
  			      	$('#btn_check').show();
  			      	$('#code_check').show();
  			      	$('#mem_num').val(mem_num);
  			      }
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
    			/* 비밀번호 변경 모달 */
    			alert('인증번호 일치');
    			$('#staticBackdrop').modal('hide');
    			$('#resetPwModal').modal('show');
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
    	// 비밀번호 찾기 모달창 닫기버튼 누를때
    	function clearInputFields() {
    		$('#userId').val('');
    		$('#userPhone').val('');
    		$('#code').val('');
    		clearInterval(countdown);
   		  $('#time').text('');
	   		$('#btn_check').hide();
		    $('#code_check').hide();
			  $('#btn_send').show();
			  $('#code_send').show();
   		  seconds = 0;
			}
    	/* 비밀번호 찾기 모달 끝 */
    
    	function changePw() {
			  var pw1 = $('#pw1').val();
			  var pw2 = $('#pw2').val();
			
			  if (pw1 === "") {
			    alert('새 비밀번호를 입력하세요');
			    $('#pw1').focus();
			    return false;
			  } else if (pw2 === "") {
			    alert('비밀번호 확인을 입력하세요');
			    $('#pw2').focus();
			    return false;
			  } else if (pw1 !== pw2) {
			    alert('비밀번호가 일치하지 않습니다');
			    $('#pw2').select();
			    return false;
			  } else {
				  alert('비밀번호 변경 성공!');
			    document.changePwForm.submit();
			  }
			}
		</script>
    <!-- endinject -->
    