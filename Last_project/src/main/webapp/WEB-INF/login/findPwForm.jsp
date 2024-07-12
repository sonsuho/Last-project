<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    findPwForm.jsp <br>
    
    <!-- plugins:css -->
    <link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="resources/assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="resources/assets/images/favicon.png" />
  </head>
  <body>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth">
          <div class="row flex-grow">
            <div class="col-lg-4 mx-auto">
              <div class="auth-form-light text-left p-5">
                <div class="brand-logo">
                  <img src="resources/assets/images/logo_s.png" style="width: 80px;">
                </div>
                <h4>비밀번호 찾기</h4>
                
                <form method="post" action="findPw.in">
                  <div class="form-group">
                	<input type="text" name="id" placeholder="아이디" class="form-control form-control-lg">
               	  </div>
                  <div class="form-group">
                	<input type="text" name="phone" placeholder="'-' 없이 입력하세요" class="form-control form-control-lg">
               	  </div>
               	  <div class="form-group">
					<input type="text" name="findPwKey" placeholder="인증번호를 입력하세요" class="form-control form-control-lg">
					<input type="button" class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn" id="basic-addon2">인증번호 받기</label>
				  </div>
                </form>
                
                <br>
                <div class="my-2 d-flex justify-content-end align-items-center">
                  <a href="login.in" class="auth-link text-primary">로그인 페이지로 이동</a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- content-wrapper ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="resources/assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="resources/assets/js/off-canvas.js"></script>
    <script src="resources/assets/js/misc.js"></script>
    <script src="resources/assets/js/settings.js"></script>
    <script src="resources/assets/js/todolist.js"></script>
    <script src="resources/assets/js/jquery.cookie.js"></script>
    <!-- endinject -->
    