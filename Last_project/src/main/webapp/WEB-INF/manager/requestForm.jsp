<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="managerBarTop.jsp"%>
 
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/signature_pad.min.js" type="text/javascript"></script>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/css.css"> --%>

requestForm.jsp<br>
<style>
    .fl { display: flex; justify-content: flex-start; }
    .form_radio_btn {
        width: 90px;
        height: 38px;
        border: 1px solid #EAE7E7;
        border-radius: 10px;
        font-size: 14px;
    }
    .radio-stl { display: none; }
    .form_radio_btn label {
        display: block;
        width: inherit;
        height: inherit;
        border: 1px solid #ccc;
        border-radius: 10px;
        text-align: center;
        display: flex; justify-content: center; align-items: center;
    }
    /* Hover */
    .form_radio_btn label:hover {
        color: #666;
    }
    input[type=radio]:checked + label {
        background-color: #C6C0FF;
        border: 1px solid #C6C0FF;
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
    
    canvas {
        border: 1px solid #ddd;
    }
    .err { font-size: 12px; color: red; }
    
</style>

<h3>결재 요청</h3>
<form:form commandName="req" action="requestForm.manager" method="post" id="reqForm">
    <input type="hidden" name="mem_num" value="${loginInfo.mem_num }">
    <input type="hidden" id="reqSign" name="sign">
    
    <div>
        보낼사람
        <select name="app_num">
            <option value="">선택하세요.</option>
            <c:forEach var="a" items="${alist}">
                <option value="${a.mem_num}">${a.name}</option>
            </c:forEach>
        </select>
    </div>
    
    <div class="fl">
        <c:set var="category" value="휴가"/>
        <div class="form_radio_btn">
            <input type="radio" class="radio-stl" id="radio1" name="category" value="휴가" checked>
            <label for="radio1">휴가</label>
        </div>
        <div class="form_radio_btn">
            <input type="radio" class="radio-stl" id="radio2" name="category" value="반차">
            <label for="radio2">반차</label>
        </div>
    </div>
    
    <div>
        <p>*제목</p>
        <div class="fl">
            <input type="hidden" name="ap_delete" value="MA">
            <input type="text" id="title" name="title" value="${req.title }">
            <form:errors path="title" cssClass="err"/>
        </div>
    </div>
    
    <div>
        <p>*기간</p>
        <div class="fl">
            <input type="date" id="time1" name="time1" value="${req.time1 }"> ~ 
            <input type="date" id="time2" name="time2" value="${req.time2 }">
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
    
</form:form>

<script>
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
            } else {
                $.ajax({
                    url : "signSave.student",
                    method : "post",
                    dataType : "json",
                    data : {
                        sign : sign.toDataURL()
                    },
                    success : function(r){
                        alert("저장완료 : " + r.filename);
                        document.getElementById("reqSign").value = r.filename;
                        document.getElementById('reqForm').submit();
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
        var ratio = Math.max(window.devicePixelRatio || 1, 1);
        canvas.width = canvas.offsetWidth * ratio;
        canvas.height = canvas.offsetHeight * ratio;
        canvas.getContext("2d").scale(ratio, ratio);
    }
    
    $(window).on("resize", function(){
        resizeCanvas();
    });
    
    resizeCanvas();
    
    window.onload = function() {
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
    };

  
    $("#time1").on("change", function(){
        var time1Value = $(this).val();
        $("#time2").attr("min", time1Value);
        
      
        var time2Value = $("#time2").val();
        if (time2Value && time2Value < time1Value) {
            $("#time2").val(""); 
        }
    });

    $(document).ready(function() {
        var time1Value = $("#time1").val();
        var time2Value = $("#time2").val();
        if (time2Value && time2Value < time1Value) {
            $("#time2").val(""); 
        }
    });

</script>

<%@ include file="managerBarBottom.jsp"%>
