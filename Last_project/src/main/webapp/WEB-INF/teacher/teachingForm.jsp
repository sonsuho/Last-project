<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
    
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
        		<i class="mdi mdi-home"></i>
      		</span> TeacherMain
    	</h3>
    	<nav aria-label="breadcrumb">
      		<ul class="breadcrumb">
        		<li class="breadcrumb-item active" aria-current="page">
          			<span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
        		</li>
      		</ul>
    	</nav>
  	</div>
    
    <div align="center">
    
	    <form action="teaching.teacher" method="post">
	    	
	    	<input type="button" value="새 수업" onclick="meet()"> &nbsp;&nbsp;&nbsp;							<!-- 새 수업 버튼을 누르면 구글 미팅 창이 새로 생성되고 -->
	    	
	    	<input type="text" name="url" placeholder="수업 링크 입력" style="width: 300"> &nbsp;&nbsp;&nbsp;	<!-- 구글 미팅 창에서 링크를 복사해와서 첨부한 다음  -->
	    	
	    	<input type="submit" value="전송" onclick="return urlCheck()">																<!-- 전송을 누르면 다시 teachingController로 간다 -->
	    	
	    </form>
	    
    </div>
    
<%@ include file = "teacherBottom.jsp"%>
