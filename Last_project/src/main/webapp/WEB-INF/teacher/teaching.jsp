<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="teacherTop.jsp"%>

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
	    table {
	        width: 1600px;
	        height: 400px;
	    }
	    tr, th, td {
	        height: 50px;
	    }
	</style>
	
    <!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-message-video"></i>
      		</span> Class
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
    
		    <div align="center" style="padding-top: 200;">
	                    <form id="teachingForm" action="endTeaching.teacher" method="post">
	                        <p>
	                            수업 시작 시간 : ${currentTime}
	                        </p>
	                        <input type="hidden" name="lec_Num" value="${lec_Num}">
	                        <input type="submit" value="수업종료" class="btn btn-gradient-info py-3">
	                    </form>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<script type="text/javascript">
	    function confirmEndTeaching() {
	        var confirmation = confirm("수업을 종료하시겠습니까?");
	        if (confirmation) {
	            // 서버에 요청을 보내기 위해 폼을 제출
	            document.getElementById("teachingForm").submit();
	        }
	    }
	
	    window.addEventListener("beforeunload", function (event) {
	        fetch("endTeaching.teacher", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/x-www-form-urlencoded"
	            },
	            body: "lec_Num=" + encodeURIComponent("${lec_Num}")
	        }).then(response => {
	            if (!response.ok) {
	                console.error('Failed to end teaching session');
	            }
	        }).catch(error => {
	            console.error('Error ending teaching session:', error);
	        });
	
	        event.returnValue = '';
	    });
	
	    // 링크 클릭 시 확인 창을 띄우고 수업 종료
	    document.querySelectorAll('a').forEach(function(link) {
	        link.addEventListener('click', function(event) {
	            if (!confirm("수업을 종료하시겠습니까?")) {
	                event.preventDefault();
	            }
	        });
	    });
	
	    // 폼 제출 시 확인 창을 띄우고 수업 종료
	    document.getElementById("teachingForm").addEventListener('submit', function(event) {
	        if (!confirm("수업을 종료하시겠습니까?")) {
	            event.preventDefault();
	        }
	    });
	</script>

<%@ include file="teacherBottom.jsp"%>
