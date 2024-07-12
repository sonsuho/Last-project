<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
	
	<!-- header -->
  	<div class="page-header">
    	<h3 class="page-title">
      		<span class="page-title-icon bg-gradient-primary text-white me-2">
        		<i class="mdi mdi-home"></i>
      		</span> 수업 중!!!
    	</h3>
    	<nav aria-label="breadcrumb">
      		<ul class="breadcrumb">
        		<li class="breadcrumb-item active" aria-current="page">
          			<span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
        		</li>
      		</ul>
    	</nav>
  	</div>
	
	<div>
	
		<form action="endTeaching.teacher">
		
			<p>
				수업 시작 시간 : ${currentTime}
			</p>
			
			<input type="hidden" name="lec_Num" value="${lec_Num}">
			
			<input type="submit" value="수업종료">
			
		</form>
		
	</div>
	
	<script type="text/javascript">
	    window.addEventListener("beforeunload", function (event) {
	        // Send a fetch request to end the teaching session
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
	
	        // If you want to display a confirmation dialog
	        event.returnValue = "수업을 종료하시겠습니까?";
	    });
	</script>
	
<%@ include file = "teacherBottom.jsp"%>
