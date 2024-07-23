<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="managerBarTop.jsp"%>
	
	<style type="text/css">
	    .form-group {
	        display: flex;
	        align-items: center;
	        margin-right: 1rem;
	    }
	
	    .form-group .btn,
	    .form-group .form-control,
	    .form-group .form-select {
	        margin-right: 0.3rem;
	    }
	
	    .form-select {
	        width: 100px;
	    }
	
	    .datepicker .disabled, .datepicker .disabled:hover {
	        color: #ccc !important;
	        cursor: not-allowed;
	    }
	
	    .fa-minus-square {
	        color: #36E0C6;
	        font-size: 20px;
	    }
	
	    .fa-plus-square {
	        color: #36E0C6;
	        font-size: 30px;
	    }
	
	    .fa-minus-square:hover, .fa-plus-square:hover {
	        color: #F15F5F; /* 마우스 오버 시 색상 변경 */
	    }
	
	    .card-body {
	        min-height: 70vh; /* viewport 높이의 50% */
	    }
	
	    .content {
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        flex-direction: column;
	    }
	
	    .content h1 {
	        font-size: 2rem;
	        color: #007bff;
	        margin-bottom: 20px;
	    }
	
	    .content form {
	        display: flex;
	        flex-direction: column;
	        align-items: flex-start;
	    }
	
	    .content form .form-check {
	        display: flex;
	        align-items: center;
	        margin-bottom: 10px;
	    }
	
	    .content form .form-check input[type="checkbox"] {
	        margin-right: 10px;
	        appearance: none;
	        width: 20px;
	        height: 20px;
	        border: 2px solid #007bff;
	        border-radius: 3px;
	        position: relative;
	        background-color: white; /* 기본 체크 표시 제거 */
	    }
	
	    .content form .form-check input[type="checkbox"]:checked {
	        background-color: #007bff; /* 체크된 상태에서 배경색 */
	    }
	
	    .content form .form-check input[type="checkbox"]:checked::after {
	        content: '\2713';
	        color: white;
	        font-size: 16px;
	        position: absolute;
	        top: -2px;
	        left: 2px;
	    }
	
	    .content form .form-check-label {
	        margin-left: 10px;
	    }
	
	    .content form input[type="submit"] {
	        margin-top: 20px;
	        padding: 10px 20px;
	        background-color: #007bff;
	        color: white;
	        border: none;
	        border-radius: 5px;
	        cursor: pointer;
	    }
	
	    .content form input[type="submit"]:hover {
	        background-color: #0056b3;
	    }
	</style>
	
	<script type="text/javascript">
		
	function evalCheck() {
	    // 모든 체크박스 요소를 가져옵니다.
	    var checkboxes = document.getElementsByName('lec_nums');
	    var checked = false;
	
	    // 체크된 체크박스가 하나 이상 있는지 확인합니다.
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            checked = true;
	            break;
	        }
	    }
	
	    // 하나 이상 체크되지 않았을 경우 알림 후 폼 제출을 막습니다.
	    if (!checked) {
	        alert('강의를 선택해주세요.');
	        return false; // 폼 제출 막기
	    }
	
	    return true; // 폼 제출 허용
	}
		
	</script>
	
	<!-- header -->
	<div class="page-header">
	    <h3 class="page-title">
	        <span class="page-title-icon bg-gradient-primary text-white me-2">
	            <i class="mdi mdi-clipboard-text"></i>
	        </span> Lecture Evaluation Write
	    </h3>
	    <nav aria-label="breadcrumb">
	        <ul class="breadcrumb">
	            <li class="breadcrumb-item active" aria-current="page">
	                <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
	            </li>
	        </ul>
	    </nav>
	</div>
	
	<div class="row">
	    <div class="col-lg-12 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                <div class="content">
	                    <h1>강의 평가 조사</h1>
	                    <form action="lectureEval.manager" method="post">
	                        <c:forEach var="i" begin="0" end="${fn:length(classes) - 1}">
	                            <div class="form-check">
	                                <input type="checkbox" class="form-check-input" name="lec_nums" value="${classes[i]}">
	                                <label class="form-check-label">${lec_names[i]}</label>
	                            </div>
	                        </c:forEach>
	
	                        <div align="center">
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                            <input type="submit" value="평가" onclick="return evalCheck()">
	                        </div>
	                    </form>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<%@ include file="managerBarBottom.jsp"%>
