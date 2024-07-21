<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
    
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
	
	.form-select{
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
	
	.fa-plus-square{
	  color: #36E0C6;
	  font-size: 30px;
	}
	
	.fa-minus-square:hover, .fa-plus-square:hover {
	  color: #F15F5F; /* 마우스 오버 시 색상 변경 */
	}
	
	.card-body {
	  min-height: 70vh; /* viewport 높이의 50% */
	}
  	
  	table{
  		width: 1600px;
  		height: 400px;
  	}
  	
  	tr, th, td{
  		height: 50px;
  	}
  	
  </style>
    
    <script type="text/javascript">
    	
    	function meet(){
    		window.open("http://meet.google.com", "구글 미팅");
    	}
    	
    	function urlCheck(){
            var urlField = document.getElementsByName('url')[0];
            if (urlField.value.trim() === '') {
                alert('수업 링크를 입력해야합니다!!');
                return false; // 폼 제출 방지
            }
            return true; // 폼 제출 허용
    	}
    
    </script>
    
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
    
		    <div align="center" style="padding-top: 200; padding-left: 500px;">
		    
			    <form action="teaching.teacher" method="post" style="display: flex;">
			    	
			    	<input type="button" value="새 수업"  class="btn btn-gradient-success py-3" onclick="meet()">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;					<!-- 새 수업 버튼을 누르면 구글 미팅 창이 새로 생성되고 -->
			    	
			    	<input type="text" name="url" placeholder="수업 링크 입력" style="width: 400px; height: 50px;"  class="form-control mr-2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<!-- 구글 미팅 창에서 링크를 복사해와서 첨부한 다음  -->
			    	
			    	<input type="submit" value="시작" class="btn btn-gradient-info py-3" onclick="return urlCheck()">													<!-- 전송을 누르면 다시 teachingController로 간다 -->
			    	
			    </form>
			    
		    </div>
		    
		    </div>
    		</div>
    		</div>
    		</div>
    		
<%@ include file = "teacherBottom.jsp"%>
