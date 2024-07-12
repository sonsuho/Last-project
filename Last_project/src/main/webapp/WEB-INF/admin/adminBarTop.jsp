<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  

	<!-- adminBarTop.jsp -->   
	<!-- content는 각각 jsp에 작성한뒤 include file="top.jsp" , include file="bottom.jsp" 해서 사용하기 -->
	<!-- 컨트롤+F 눌러서 `admin`은 각자 코드에 맞게 수정하고 사용하기 -->
	
	<!-- plugins:css -->
	<link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
	<link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
	<!-- endinject -->
	<!-- Plugin css for this page -->
	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" href="resources/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<!-- endinject -->
	<!-- Layout styles -->
	<link rel="stylesheet" href="resources/assets/css/style.css">
	<!-- End layout styles -->
	<link rel="shortcut icon" href="resources/assets/images/favicon.png" />
	
	<script src="resources/js/jquery.js"></script>
	<script>
		$(function(){
			getTime();
		});
		function getTime() {
        var d = new Date();
        var hur = d.getHours().toString().padStart(2,'0');
        var min = d.getMinutes().toString().padStart(2,'0');
        var sec = d.getSeconds().toString().padStart(2,'0');
        var timeBoard = document.getElementById("Now_Time");
        var time = hur + ":" + min + ":" + sec;
        timeBoard.innerHTML = time;
        setTimeout(getTime, 1000);
    }
	</script>
	
	<div class="container-scroller">
	
	  <!-- 상단바 : partial:partials/_navbar.jsp -->
	  <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	  	<!-- 왼쪽 상단 로고 -->
	    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
	      <a class="navbar-brand brand-logo" href="home.admin">
	      	<img src="resources/assets/images/logo_s.png" style="width:85px" alt="logo" />
	      </a>
	    </div>
	    <!-- 상단바 -->
	    <div class="navbar-menu-wrapper d-flex align-items-stretch" style="border-bottom:1px solid #ddd;">
	    	<!-- 좌측 : 선택된 게시판 class 추가하기 text-primary -->
	    	<!-- 
	    	<ul class="navbar-nav navbar-nav-left">
	    		<li class="nav-item d-none d-lg-block">
	    			<a class="nav-link" style="color: #000;" href=""><b>● 공지사항</b></a> 
	    		</li>
	    		<li class="nav-item d-none d-lg-block">
	    			<a class="nav-link" href=""><b>·질문게시판</b></a> 
	    		</li>
	    	</ul>
	    	 -->
	    	<!-- 우측 -->
	      <ul class="navbar-nav navbar-nav-right">
	        <!-- 전체화면 -->
	        <li class="nav-item d-none d-lg-block full-screen-link">
	          <a class="nav-link">
	            <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
	          </a>
	        </li>
	        <!-- 메신저알림 -->
					<%@ include file="../all/message.jsp" %> 
					<!-- 게시판알림 -->
					<%@ include file="../all/board.jsp" %> 
	        <!-- 로그인/로그아웃 버튼 -->
	        <li class="nav-item nav-logout d-none d-lg-block">
	          <c:if test="${loginInfo == null}">
	            <a class="nav-link" href="login.in">
	              <i class="mdi mdi-power"></i>
	            </a>
	       		</c:if>
	          <c:if test="${loginInfo != null}">
	            <a class="nav-link" href="logout.in">
	              <i class="mdi mdi-power"></i>
	            </a>
	       		</c:if>
	        </li>
	        <!-- 보고있는 페이지 상단으로 이동하는 버튼 -->
	        <li class="nav-item nav-settings d-none d-lg-block">
	          <a class="nav-link" href="#">
	            <i class="mdi mdi-format-line-spacing"></i>
	          </a>
	        </li>
	      </ul>
	      <!-- 무슨버튼인지 모르겠음 -->
	      <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
	        <span class="mdi mdi-menu"></span>
	      </button>
	    </div>
	  </nav>
	  
	  <!-- ------------------------------------------------------------------------------------- -->
	  <!-- 상단바 제외한 전체 : partial -->
	  <div class="container-fluid page-body-wrapper" >
	  
	    <!-- 사이드바 : partial:partials/_sidebar.jsp -->
	    <nav class="sidebar sidebar-offcanvas fixed-top" style="top:70px; border-right:1px solid #ddd;" id="sidebar">
	      <ul class="nav">
	      	<!-- 프로필정보 -->
	        <li class="nav-item nav-profile">
	          <a href="#" class="nav-link">
	            <div class="nav-profile-image">
	              <img src="resources/assets/images/faces/face1.jpg" alt="profile" />
	              <span class="login-status online"></span>
	              <!--change to offline or busy as needed-->
	            </div>
	            <div class="nav-profile-text d-flex flex-column">
	              <span class="font-weight-bold mb-2">${loginInfo.name}</span>
	              <span class="text-secondary text-small">${loginInfo.id}</span>
	            </div>
	            <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
	          </a>
	        </li>
	        <li>
	        	<center>
			        <!-- 시간 -->
							<h2 id="Now_Time"></h2>
						</center>
					</li>
	        <!-- 사이드바 메인 메뉴 -->
	        <li class="nav-item">
	          <a class="nav-link" href="home.admin">
	            <span class="menu-title">AdminMain</span>
	            <i class="mdi mdi-home menu-icon"></i>
	          </a>
	        </li>
	        <!-- 사이드바 메뉴 구성 -->
	        <li class="nav-item">
	          <a class="nav-link" data-bs-toggle="collapse" href="#menu1" aria-expanded="false" aria-controls="menu1">
	            <span class="menu-title">학원관리</span>
	            <i class="menu-arrow"></i>
	            <i class="fa fa-desktop menu-icon"></i> <!-- 큰메뉴1 우측 아이콘 -->
	          </a>
	          <div class="collapse" id="menu1">
	            <ul class="nav flex-column sub-menu">
	              <li class="nav-item">
	                <a class="nav-link" href="lectureList.admin">강좌목록</a>
	              </li>
	              <li class="nav-item">
	                <a class="nav-link" href="lectureInsert.admin">강좌개설</a>
	              </li>
	            </ul>
	          </div>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" data-bs-toggle="collapse" href="#menu2" aria-expanded="false" aria-controls="menu2">
	            <span class="menu-title">사용자관리</span>
	            <i class="menu-arrow"></i>
	            <i class="fa fa-users menu-icon"></i> <!-- 큰메뉴2 우측 아이콘 -->
	          </a>
	          <div class="collapse" id="menu2">
	            <ul class="nav flex-column sub-menu">
	              <li class="nav-item">
	                <a class="nav-link" href="idInsert.admin">직원아이디생성</a>
	              </li>
	              <li class="nav-item">
	                <a class="nav-link" href="emplList.admin">직원목록</a>
	              </li>
	            </ul>
	          </div>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" data-bs-toggle="collapse" href="#menu3" aria-expanded="false" aria-controls="menu3">
	            <span class="menu-title">결재함</span>
	            <i class="menu-arrow"></i>
	            <i class="fa fa-clipboard menu-icon"></i> <!-- 큰메뉴3 우측 아이콘 -->
	          </a>
	          <div class="collapse" id="menu3">
	            <ul class="nav flex-column sub-menu">
	              <li class="nav-item">
	                <a class="nav-link" href="">요청목록</a>
	              </li>
	            </ul>
	          </div>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" data-bs-toggle="collapse" href="#menu4" aria-expanded="false" aria-controls="menu4">
	            <span class="menu-title">커뮤니티 관리</span>
	            <i class="menu-arrow"></i>
	            <i class="fa fa-list-alt menu-icon"></i> <!-- 큰메뉴3 우측 아이콘 -->
	          </a>
	          <div class="collapse" id="menu4">
	            <ul class="nav flex-column sub-menu">
	              <li class="nav-item">
	                <a class="nav-link" href="">신고글 목록</a>
	              </li>
	              <li class="nav-item">
	                <a class="nav-link" href="">삭제글 목록</a>
	              </li>
	            </ul>
	          </div>
	        </li>
	      </ul>
	    </nav>
	    
	    <!-- ------------------------------------------------------------------------------------- -->
	    <!-- 페이지 메인 부분 : partial -->
	    <div class="main-panel" style="margin-left:260px; width:calc(100%-260px);">
	      <div class="content-wrapper">
	          