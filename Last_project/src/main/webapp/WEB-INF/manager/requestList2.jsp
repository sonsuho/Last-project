<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="managerBarTop.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/signature_pad.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/css.css">
<head>
    <meta charset="UTF-8">
    <title>내(매니저) 문서함</title>
    <style>
        .container {
            display: flex;
            transition: all 0.5s ease;
        }
        .left-panel, .right-panel {
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: #fff;
            transition: all 1s ease;
        }
        .left-panel {
            flex: 1;
        }
        .right-panel {
            flex: 0;
            display: none;
            max-width: 0;
            overflow: hidden;
        }
        .container.expanded .left-panel {
            flex: 1;
        }
        .container.expanded .right-panel {
            display: block;
            flex: 1;
            max-width: 100%;
        }
        .sub-next-title { color: #9a9a9a;  cursor: pointer;}
		.sub-next-title:hover {color: #b66dff; transition: 0.2s; }
	
		span{
			margin-right: 5;
		}
	
		/*request form */
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
    .clear:hover {
    	background: #f6f6f6;
        opacity: 0.8;
        transition: 0.5s;
        }
    
    canvas {
        border: 1px solid #ddd;
        background-color: F9FFFF;
    }
    .err { font-size: 12px; color: red;}
    </style>
    <script>
        function allDelete(obj) {
            var rcheck = document.getElementsByName("rowcheck");
            var check = obj.checked;
            for (var i = 0; i < rcheck.length; i++) {
                rcheck[i].checked = check;
            }
        }

        function selectDelete() {
            var rcheck = document.getElementsByName("rowcheck");
            var flag = false;
            for (var i = 0; i < rcheck.length; i++) {
                if (rcheck[i].checked) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                alert("선택하세요");
                return;
            }
            document.myform.submit();
        }

        function requestList(mem_num) {
            location.href = "request.manager?mem_num=" + mem_num;
        }

        function requestList2() {
            location.href = "request2.manager";
        }

        function etcList(mem_num) {
            location.href = "etcList.manager?mem_num=" + mem_num;
        }

        function etcSendList(sender_num) {
            location.href = "etcSendList.manager?sender_num=" + sender_num;
        }

        // 화면 분할
        function openDetail(req_num, mem_num, title, reason, memberName,time1 ,time2, sign, app_num, ap_situ) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'requestDetail.manager?req_num=' + encodeURIComponent(req_num) +
                '&mem_num=' + encodeURIComponent(mem_num) +
                '&title=' + encodeURIComponent(title) +
                '&reason=' + encodeURIComponent(reason) +
                '&memberName=' + encodeURIComponent(memberName) +
                '&time1=' + encodeURIComponent(time1) +
                '&time2=' + encodeURIComponent(time2) +
                '&sign=' + encodeURIComponent(sign) +
                '&app_num=' + encodeURIComponent(app_num) +
                '&ap_situ=' + encodeURIComponent(ap_situ), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    document.getElementById('rightPanel').innerHTML = xhr.responseText;
                    document.getElementById('container').classList.add('expanded');
                }
            };
            xhr.send();
        }
    </script>
</head>
<div class="container" id="container">
    <div class="left-panel" id="leftPanel">
        <div class="page-header">
	<h3 class="page-title" style="font-weight:700;">
		<span class="sub-next-title" onclick="requestList('${loginInfo.mem_num}')">받은 결재함</span> 
		<span class="sub-next-title" onclick="etcList('${loginInfo.mem_num}')">받은 문서함</span>
		<span class="sub-next-title" onclick="etcSendList('${loginInfo.mem_num}')">내가 보낸 문서함</span>
		<span>결재 문서함</span>
	</h3>
		<nav aria-label="breadcrumb">
        	<div class="input-group-append">
            <button class="btn btn-sm btn-gradient-primary py-3" type="button" data-bs-toggle="modal" data-bs-target="#firstModal" id="openFirstModal"><i class="mdi mdi-email"></i> &nbsp;&nbsp; 문서 보내기</button>
            </div>
        </nav>
		</div>
		
         <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">

					<div class="row">
	                    
				        <div class="col-lg-4">
	                     	<form action="request2.manager" style="display:flex;">
	                     		<input type="hidden" name="whatColumn" value="all">
                				<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		                        <input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2" style="width: 400px;">
	                   			
		                        <button type="submit" class="btn btn-sm btn-success py-3" type="button" style="width: 70px;">검색</button>
	                        </form>
				        </div>
	                </div>

            <!-- Pending Documents -->
            <form name="myform" action="selectDeleteReq2.manager" method="post">
                <input type="hidden" name="ap_delete" value="M">
                <!-- Completed Documents -->
                
                <input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3">
               
               
                <table class="table table-hover">
                    <tr>
                        <th colspan="2"><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></th>
                        <th>상태</th>
                    </tr>
                    <c:choose>
                        <c:when test="${completedList == null || completedList.isEmpty()}">
                            <tr>
                                <td colspan="3" style="text-align: center;">문서가 없습니다</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${completedList}">
                                <c:if test="${fn:contains(r.ap_delete, 'M')}">
                                    <tr>
                                        <td rowspan="2"><input type="checkbox" value="${r.req_num}" name="rowcheck" class="form-check-input"></td>
                                        <td>
                                            <a href="javascript:void(0);" onclick="openDetail('${r.req_num}', '${loginInfo.mem_num}', '${r.title}', '${r.reason}', '${r.memberName}', '${r.time1}','${r.time2}', '${r.sign}', '${loginInfo.mem_num}', '${r.ap_situ}')">
                                                ${r.memberName}
                                            </a>
                                        </td>
                                        <td>
                                            <c:if test="${r.ap_situ == '승인'}">
                                                <label class="badge badge-success">승인</label>
                                            </c:if>
                                            <c:if test="${r.ap_situ == '반려'}">
                                                <label class="badge badge-danger">반려</label>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>${r.reason}</td>
                                        <td>${r.time1}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>
            </form>
            
				<center>${pageInfo.pagingHtml}</center>
			</div>
       </div>
	</div>
</div>
        <div class="right-panel" id="rightPanel">
            <!-- 문서 상세 내용이 여기에 표시됩니다 -->
            <h2>문서 내용을 선택하세요</h2>
        </div>
    </div>
    
      <!--모달  -->
<div class="modal fade" id="firstModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="requestModalLabel">결재 신청</h5>
        
         <i class="fa fa-times" id="closeModal"></i>

      </div>
      <div class="modal-body">
        <!-- request form -->
        <form:form commandName="req" action="requestForm.manager" method="post" id="reqForm" class="forms-sample">
          <input type="hidden" name="mem_num" value="${loginInfo.mem_num }">
          <input type="hidden" id="reqSign" name="sign">
          <input type="hidden" name="ap_delete" value="MA">
          <div>
            보낼사람
            <select name="app_num" class="form-select" id="exampleSelectGender" lang="5">
              <option value="">선택하세요.</option>
              <c:forEach var="a" items="${alist}">
                <option value="${a.mem_num}">${a.name}</option>
              </c:forEach>
            </select>
            <br><br>
          </div>
          <div class="fl">
            <c:set var="category" value="휴가"/>
            <div class="form_radio_btn" style="margin-right: 10px !important;">
              <input type="radio" class="radio-stl" id="radio1" name="category" value="휴가" checked>
              <label for="radio1">휴가</label>
            </div>
            <div class="form_radio_btn">
              <input type="radio" class="radio-stl" id="radio2" name="category" value="반차">
              <label for="radio2">반차</label>
            </div>
          </div>
          <br><br>
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
                <canvas id="signatureCanvas"></canvas>
              </div>
              <div class="m-signature-pad--footer">
                <button type="button" class="button clear" data-action="clear">지우기</button>
              </div>
            </div>
          </div>
          <button type="submit" id="btnSave" class="btn btn-gradient-primary me-2 save" data-action="save">신청하기</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnclose">닫기</button>
        </form:form>
      </div>
    </div>
  </div>
</div>
    
    
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 최소 날짜를 오늘 날짜로 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
    var yyyy = today.getFullYear();
    var minDate = yyyy + '-' + mm + '-' + dd;

    $('input[name="time1"]').attr('min', minDate);

    // Canvas 요소 가져오기
    var canvas = document.getElementById('signatureCanvas');
    var sign = new SignaturePad(canvas, {
        minWidth: 3,
        maxWidth: 3,
        penColor: "rgb(118, 109, 209)"
    });

    // 클리어 버튼 클릭 시 서명 패드 비우기
    $(".clear").on("click", function() {
        sign.clear();
    });

    // 저장 버튼 클릭 시 처리
    $("#btnSave").click(function(e) {
        e.preventDefault(); // 기본 폼 제출 방지

        var title = $('input[name="title"]').val().trim();
        var time1 = $('input[name="time1"]').val().trim();
        var time2 = $('input[name="time2"]').val().trim();
        var reason = $('textarea[name="reason"]').val().trim();
        var app_num = $('select[name="app_num"]').val();
        var category = $('input[name="category"]:checked').val();

        if (app_num === "") {
            alert('보낼 사람을 선택하세요.');
            return false;
        }
        if (title.length === 0) {
            alert('제목을 입력해주세요.');
            return false;
        }
        if (time1.length === 0) {
            alert('기간을 입력해주세요.');
            return false;
        }
        if (category !== '반차' && time2.length === 0) {
            alert('기간을 입력해주세요.');
            return false;
        }
        if (reason.length === 0) {
            alert('사유를 입력해주세요.');
            return false;
        }

        // 서명이 비어 있는지 확인
        if (sign.isEmpty()) {
            alert("사인해 주세요!!");
            return false;
        }

        // 사인 이미지를 서버로 전송하고 폼을 제출
        $.ajax({
            url: "signSave.student",
            method: "post",
            dataType: "json",
            data: {
                sign: sign.toDataURL()
            },
            success: function(r) {
                alert("저장완료 : " + r.filename);
                $('#reqSign').val(r.filename);
                $('#reqForm').submit(); // 폼 제출
            },
            error: function(res) {
                console.log(res);
            }
        });
    });

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

    // 모달 닫기 버튼 처리
    $("#btnclose, #closeModal").click(function() {
        $('#firstModal').modal('hide');
    });

   
});
</script>
<%@include file="managerBarBottom.jsp"%>