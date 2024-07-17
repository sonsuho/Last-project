<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

<!-- plugins:css -->
<link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
<link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
<!-- endinject -->
<!-- Plugin css for this page -->
<link rel="stylesheet" href="resources/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
<!-- End plugin css for this page -->
<!-- inject:css -->
<!-- endinject -->
<!-- Layout styles -->
<link rel="stylesheet" href="resources/assets/css/style.css">
<!-- End layout styles -->
<link rel="shortcut icon" href="resources/assets/images/favicon.png" />

<!-- jQuery and Bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Additional Scripts -->
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/signature_pad.min.js"></script>

<!-- Custom Styles -->
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

<!-- Modal HTML Structure -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="requestModalLabel">휴가 신청</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Existing leave request form -->
        <form:form commandName="req" action="request.student" method="post" id="reqForm" class="forms-sample">
          <input type="hidden" name="mem_num" value="${loginInfo.mem_num }">
          <input type="hidden" id="reqSign" name="sign">
          <input type="hidden" name="ap_delete" value="MS">
          <div>
            보낼사람
            <select name="app_num" class="form-select" id="exampleSelectGender" lang="5">
              <option value="">선택하세요.</option>
              <c:forEach var="m" items="${mlist}">
                <option value="${m.mem_num}">${m.name}</option>
              </c:forEach>
            </select>
            <br><br><br>
          </div>
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
          <div class="form-group">
            <label>*제목</label><br>
            <input type="text" id="title" name="title" class="form-control" value="${req.title }">
            <form:errors path="title" cssClass="err"/>
          </div>
          <div class="form-group">
            <label>*기간</label>
            <input type="date" id="time1" class="form-control" name="time1" value="${req.time1 }">
            <span id="toText">~</span>
            <input type="date" id="time2" class="form-control" name="time2" value="${req.time2 }">
            <form:errors path="time1" cssClass="err"/>
          </div>
          <div class="form-group">
            <label for="exampleInputEmail3">*사유</label>
            <textarea class="form-control" id="exampleInputEmail3" rows="5" cols="10" name="reason" placeholder="사유를 입력하세요.">${req.reason }</textarea>
            <form:errors path="reason" cssClass="err"/>
          </div>
          <div class="form-group">
            <div id="signature-pad" class="m-signature-pad">
              <label>*사인</label>
              <div class="m-signature-pad--body">
                <canvas></canvas>
              </div>
              <div class="m-signature-pad--footer">
                <button type="button" class="button clear" data-action="clear">지우기</button>
              </div>
            </div>
          </div>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          <button type="submit" id="btnSave" class="btn btn-gradient-primary me-2 save" data-action="save">신청하기</button>
        </form:form>
      </div>
    </div>
  </div>
</div>

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#requestModal">
  휴가 신청하기
</button>

<script>
$(document).ready(function() {
    // 신청 완료 시 모달 닫기
    $("#reqForm").on("submit", function(event) {
      event.preventDefault(); // 기본 form 제출 방지
      var form = $(this);

      var canvas = $("#signature-pad canvas")[0]; // canvas 요소 가져오기
      var sign = new SignaturePad(canvas, {
        minWidth: 5,
        maxWidth: 5,
        penColor: "rgb(118, 109, 209)"
      });

      if (sign.isEmpty()) {
        alert("사인해 주세요!!");
      } else {
        $.ajax({
          url: "signSave.student",
          method: "post",
          dataType: "json",
          data: {
            sign: sign.toDataURL()
          },
          success: function(r) {
            alert("저장완료 : " + r.filename);
            document.getElementById("reqSign").value = r.filename;
            form.submit(); // 폼 제출
          },
          error: function(res) {
            console.log(res);
          }
        });
      }
    });

    // 클리어 버튼 클릭 시 서명 패드 비우기
    $(".clear").on("click", function() {
      var canvas = $("#signature-pad canvas")[0]; // canvas 요소 가져오기
      var sign = new SignaturePad(canvas);
      sign.clear();
    });

    // Canvas 리사이즈 함수
    function resizeCanvas() {
      var canvas = $("#signature-pad canvas")[0]; // canvas 요소 가져오기
      var ratio = Math.max(window.devicePixelRatio || 1, 1);
      canvas.width = canvas.offsetWidth * ratio;
      canvas.height = canvas.offsetHeight * ratio;
      canvas.getContext("2d").scale(ratio, ratio);
    }

    $(window).on("resize", function() {
      resizeCanvas();
    });

    resizeCanvas();

    // window.onload 함수 제거 후 직접 코드로 최소 날짜 설정
    var today = new Date(); // 오늘 날짜 객체 생성
    var dd = today.getDate(); // 오늘 날짜에서 '일' 부분 가져오기
    var mm = today.getMonth() + 1; // 오늘 날짜에서 '월' 부분 가져오기 (0부터 시작하므로 +1)
    var yyyy = today.getFullYear(); // 오늘 날짜에서 '년' 부분 가져오기

    // 월과 일이 한 자리 수일 경우 앞에 0을 붙여서 두 자리로 만듭니다.
    if (dd < 10) {
      dd = '0' + dd;
    }
    if (mm < 10) {
      mm = '0' + mm;
    }

    // 최소 날짜를 오늘 날짜로 설정
    var minDate = yyyy + '-' + mm + '-' + dd;
    document.getElementsByName('time1')[0].setAttribute('min', minDate);

    // 시간 입력란의 값 변화 감지 및 처리
    $("#time1").on("change", function() {
      var time1Value = $(this).val();
      $("#time2").attr("min", time1Value);
      var time2Value = $("#time2").val();
      if (time2Value && time2Value < time1Value) {
        $("#time2").val(""); 
      }
    });

    // 라디오 버튼 변화 감지 및 처리
    $("input[name='category']").on("change", function() {
      if ($("#radio2").is(":checked")) {
        $("#time2, #toText").hide().val(""); // 숨기고 값 초기화
      } else {
        $("#time2, #toText").show(); // 다시 보이기
      }
    });
  });
  
</script>