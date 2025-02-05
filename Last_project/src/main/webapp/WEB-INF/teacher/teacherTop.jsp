<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<%@ include file="../all/myPage.jsp" %>

<!-- 메시지 탑 메뉴 ajax -->
<%@ include file="../all/topMenuMessage.jsp" %>

	<!-- studentBarTop.jsp -->
	
<style>
	/* gnb부트스트랩 컬러 색상 바꿈 */
	.navbar .navbar-menu-wrapper .navbar-nav .nav-item .nav-link  {
		color : #333 !important;
	}

	.gnb li a{
	    font-size: 14px;
	    position: relative;   /*부모는 상대위치*/
	    font-weight: bold;
	}
	.gnb li a:hover{
		color: #000 !important;
	}
	
	.gnb li a:before{
	    content : '';
	    position: absolute;  /*before를 절대위치*/
	    background-color: dodgerblue;
	    height: 2px;
	    width : 0;
	    bottom: 0px;      	 /*bottom을 주어, 글자 밑에 위치시킴*/       
	    transition: 0.5s;    /*가상클래스에 이벤트 발생시 시간 지정*/
	    
	    
	    left : 50%;         /*만약 왼쪽에서부터 커지게하려면-> left를 0으로 두면 됨*/
	    transform: translateX(-50%);
	}
	
	.gnb li a:hover:before{ /*hover시 width:0 -> 100%가 됨*/
	    width : 100%;
	    font-weight: bold !important;
	      
	}
</style>

<script>
	function checkAttend(situ){
		if(situ == '수업중'){
			alert(" '퇴근하기'를 완료하시고 로그아웃하셔야합니다.");
			location.href = "home.teacher";
		}
		if(situ != '수업중'){
			location.href = "logout.in";
		}
	}
</script>

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

	<div class="container-scroller">
	
		<!-- 상단바 : partial:partials/_navbar.jsp -->
		<nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
		  	<!-- 왼쪽 상단 로고 -->
		    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
		      <a class="navbar-brand brand-logo" href="home.teacher">
		      	<img src="resources/assets/images/logo_s.png" style="width:85px" alt="logo" />
		      </a>
		    </div>
				<!-- 상단바 -->
		    <div class="navbar-menu-wrapper d-flex align-items-stretch">
		    
		      <!-- gnb -->
			  <ul class="navbar-nav mr-lg-2 gnb">
		          <li class="nav-item  d-none d-lg-flex">
		            <a class="nav-link" href="notice.manager">
		                공지사항
		            </a>
		          </li>
		          <li class="nav-item  d-none d-lg-flex">
		            <a class="nav-link" href="library.teacher">
		                자료실
		            </a>
		          </li>
	          </ul>
		    
		    
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
						<%@ include file="../all/alarmModal.jsp" %> 
						<!-- 로그인/로그아웃 버튼 -->
		        <li class="nav-item nav-logout d-none d-lg-block">
		          <c:if test="${loginInfo == null}">
		            <a class="nav-link" href="login.in">
		              <i class="mdi mdi-power"></i>
		            </a>
		       		</c:if>
		           <c:if test="${loginInfo != null}">
		           <%
		          	//AttendController session
		          	String situ = (String)session.getAttribute("situ");
		           
		        	%>
		           <a class="nav-link" onclick="checkAttend('<%=situ%>')">
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
			<div class="container-fluid page-body-wrapper">
		
				<!-- 사이드바 : partial:partials/_sidebar.jsp -->
				<nav class="sidebar sidebar-offcanvas fixed-top" style="top:70px;" id="sidebar">
		      <ul class="nav">
						<!-- 프로필정보 -->
						<li class="nav-item nav-profile">
							<a href="#" class="nav-link" onclick="myPage()">
								<div class="nav-profile-image">
									<img src="resources/assets/images/faces/${loginInfo.image}" alt="profile" />
									<span class="login-status online"></span>
								</div>
								<div class="nav-profile-text d-flex flex-column">
									<span class="font-weight-bold mb-2">${loginInfo.name}</span> 
									<span class="text-secondary text-small">${loginInfo.id}</span>
								</div> 
								<i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
							</a> 
						</li>
						
						<!-- 사이드바 출석 정보 -->
						<%@ include file="teacherAttendanceCheck.jsp" %>
						
						<!-- 사이드바 메인 메뉴 -->
						<li class="nav-item">
							<a class="nav-link" href="home.teacher">
								<span class="menu-title">홈</span> 
								<i class="mdi mdi-home menu-icon"></i>
							</a>
						</li>
						
						<!-- 사이드바 메뉴 구성 -->
						<li class="nav-item">
							<a class="nav-link" data-bs-toggle="collapse" href="#menu1" aria-expanded="false" aria-controls="menu1"> 
								<span class="menu-title">근태관리</span> 
								<i class="menu-arrow"></i> 
								<i class="mdi mdi-contacts menu-icon"></i>
							</a>
							<div class="collapse" id="menu1">
								<ul class="nav flex-column sub-menu">
									<li class="nav-item">
										<a class="nav-link" href="attStatus.teacher?mem_num=${loginInfo.mem_num}">내 근태 현황</a>
									</li>
								</ul>
							</div>
						</li>
						
						<li class="nav-item">
							<a class="nav-link" data-bs-toggle="collapse" href="#menu3" aria-expanded="false" aria-controls="menu3"> 
								<span class="menu-title">수업관리</span> 
								<i class="menu-arrow"></i> 
								<i class="mdi mdi-crosshairs-gps menu-icon"></i> 
							</a>
							<div class="collapse" id="menu3">
								<ul class="nav flex-column sub-menu">
									<li class="nav-item">
										<a class="nav-link" href="testList.teacher">테스트</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="evalResultList.teacher">강의평가</a>
									</li>
								</ul>
							</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-bs-toggle="collapse" href="#menu4" aria-expanded="false" aria-controls="menu4"> 
								<span class="menu-title">게시판</span> 
								<i class="menu-arrow"></i> 
								<i class="fa fa-bullhorn menu-icon"></i>
							</a>
							<div class="collapse" id="menu4">
								<ul class="nav flex-column sub-menu">
									<li class="nav-item">
										<a class="nav-link" href="notice.manager">공지사항</a>
									</li>
									
									<li class="nav-item">
										<a class="nav-link" href="library.teacher">자료실</a>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</nav>
				
			<!-- 페이지 메인 부분 : partial -->
	        <div class="main-panel" style="margin-left:260px; width:calc(100%-260px);">
	          <div class="content-wrapper">
		          