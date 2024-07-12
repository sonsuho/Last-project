<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 수진언니 코드로 설정해놨습니다  -->
    
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/signature_pad.min.js" type="text/javascript"></script>

<!-- requestForm.jsp<br> -->
<style>
	.fl { display:flex; justify-content: flex-start;}
	.form_radio_btn {
		width: 90px;
		height: 38px;
		color: #999;
		border-radius: 10px;
		font-size: 14px;
	}
	.radio-stl { display:none;}
	.form_radio_btn label{
		display:block;
		width: inherit;
		height: inherit;
		border-radius: 6px;
		text-align: center;
		display:flex; justify-content: center; align-items: center;
		font-weight: 700;
		background: #f6f6f6;
	}
	/* Hover */
	.form_radio_btn label:hover {
		background: #f6f6f6;
		opacity: 0.8;
		transition: 0.5s;
	}
	input[type=radio]:checked + label {
	
		background-color: #D4D0FF;
		color: #000;
	}
	
	.cal-stl {
		height: 40px;
		outline: none;
		border: 1px solid #f6f6f6;
		border-radius: 10px;
		background: #f6f6f6;
		display: flex;
		justify-content: center;
	}
	.input_stl {
		height: 38px;
		line-heightL 38px;
		border-radius: 10px;
		border: 1px solid #ccc;
	}
	.clear { border: none; font-size: 0.85rem; margin-top: 5px; border-radius: 5px; padding: 3px 7px;}
	
	canvas {
		border: 1px solid #ddd;
	}
	.err { font-size: 12px; color: red;}
	
</style>

<%@ include file="studentTop.jsp" %>

<!-- ------------------------------------------------------------------------------------- -->
        <!-- 페이지 메인 부분 : partial -->
        <div class="main-panel" style="margin-left:260px; width:calc(100%-260px);">
          <div class="content-wrapper">
          
			<!-- header -->
		    <div class="page-header">
		      <h3 class="page-title">
		      	<b>휴가 신청</b>
		      </h3>
		    </div>
		    
		    <div class="col-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    
                    <form:form commandName="req" action="request.student" method="post" id="reqForm" class="forms-sample">
                   	  <!-- 회원번호 챙겨보내기 -->
                      <input type="hidden" name="mem_num" value="${loginInfo.mem_num }">
					  <input type="hidden" id="reqSign" name="sign">
                    
                   	  <div class="fl">
						  <c:set var="category" value="휴가"/>
						  <div class="form_radio_btn" style="margin-right: 10px !important;">
							<input type="radio" class="radio-stl" id="radio1" name="category" value="휴가" checked>
							<label for="radio1">휴가</label>
						  </div>
						  <div class="form_radio_btn">
							<input type="radio" class="radio-stl" id="radio2" name="category" value="조퇴">
							<label for="radio2">조퇴</label>
						  </div>
					  </div>
					  
					  <br><br><br>
					  
			    	  <!-- 기간 -->
                      <div class="form-group">
                         <label>*기간</label>
                         <input type="hidden" name="category" value="휴가">
                         <input type="text" id="daterange" class="form-control" name="time1" value="${req.time1 }"> ~ 
                         <input type="text" id="time2" class="form-control" name="time2" value="${req.time2 }">
                         <form:errors path="time1" cssClass="err"/>
                      </div>
                       
                      <!-- 사유 -->                     
                      <div class="form-group">
                        <label for="exampleInputEmail3">*사유</label>
                        <input type="text" class="form-control" id="exampleInputEmail3" name="reason" placeholder="사유를 입력하세요." value="${req.reason }">
                      </div>
                                            
                      <!-- 서명 -->
                      <div class="form-group">
                       	<div id="signature-pad" class="m-signature-pad">
                       	<label>*사인</label>
							<div class="m-signature-pad--body">
								<canvas></canvas>
							</div>
							<div class="m-signature-pad--footer">
								<button type="button" class="button clear" data-action="clear">지우기</button>
								<!-- <button type="button" class="button save" data-action="save">저장</button> -->
							</div>
						 </div>
                      </div>
                      <button type="submit" style="width:100%;" id="btnSave" class="btn btn-gradient-primary me-2 save" data-action="save">신청하기</button>
                    </form:form>
                  </div>
                </div>
              </div>
		    
		    
<%-- 		    
<h3>결재 요청</h3>

	<form:form commandName="req" action="request.student" method="post" id="reqForm">
		<input type="hidden" name="mem_num" value="${loginInfo.mem_num }">
		<input type="hidden" id="reqSign" name="sign">
		
		<div class="fl">
			<c:set var="category" value="휴가"/>
			<div class="form_radio_btn">
				<input type="radio" class="radio-stl" id="radio1" name="category" value="휴가" checked>
				<label for="radio1">휴가</label>
			</div>
			<div class="form_radio_btn">
				<input type="radio" class="radio-stl" id="radio2" name="category" value="조퇴">
				<label for="radio2">조퇴</label>
			</div>
		</div>
		
		<div>
			<p>*기간</p>
			<div class="fl">
				<input type="date" id="time1" name="time1" value="${req.time1 }"> ~ <input type="date" id="time2" name="time2" value="${req.time2 }">
				<form:errors path="time1" cssClass="err"/>
			</div>
		</div>
				
		<div>
			<p>*사유</p>
			<input type="text" class="input_stl" name="reason" placeholder="사유를 입력하세요." value="${req.reason }">
			<form:errors path="reason" cssClass="err"/>
		</div>
		
		<br>
		
		<div>*서명</div>
		<div id="signature-pad" class="m-signature-pad">
			<div class="m-signature-pad--body">
				<canvas></canvas>
			</div>
			<div class="m-signature-pad--footer">
				<div class="description">사인해 주세요</div>
				<button type="button" class="button clear" data-action="clear">지우기</button>
				<!-- <button type="button" class="button save" data-action="save">저장</button> -->
			</div>
		</div>
		
		<br><br>
		
		<div>
			<input type="button" id="btnSave" class="button save" data-action="save" value="요청하기">
		</div>
		
	</form:form> --%>


<%@ include file="studentBottom.jsp" %>


<script>
	
	$(function() {
	  $('input[name="daterange"]').daterangepicker({
	    opens: 'left'
	  }, function(start, end, label) {
	    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
	  });
	});

	var canvas = $("#signature-pad canvas")[0];
	var sign = new SignaturePad(canvas, {
		minWidth: 5,
		maxWidth: 5,
		penColor: "rgb(118, 109, 209)"
	});
	
	$("[data-action]").on("click", function(){
		if ( $(this).data("action")=="clear" ){
			sign.clear();
			
		} else if ( $(this).data("action")=="save" ){
			if (sign.isEmpty()) {
				alert("사인해 주세요!!");
			} else {$.ajax({
				url : "signSave.student",
				method : "post",
				dataType : "json",
				data : {
					sign : sign.toDataURL()},
					success : function(r){
						alert("저장완료 : " + r.filename);
						
						document.getElementById("reqSign").value = r.filename;
						
						document.getElementById('reqForm').submit();
						//sign.clear();
					},
					error : function(res){
						console.log(res);
					}
				});
			}
		}
	});
	
	function resizeCanvas(){
		var canvas = $("#signature-pad canvas")[0];
		var ratio =  Math.max(window.devicePixelRatio || 1, 1);
		canvas.width = canvas.offsetWidth * ratio;
		canvas.height = canvas.offsetHeight * ratio;
		canvas.getContext("2d").scale(ratio, ratio);
	}
	
	$(window).on("resize", function(){
		resizeCanvas();
	});
	
	resizeCanvas();
	


</script>
