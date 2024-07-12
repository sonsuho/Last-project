<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!-- studentBarTop.jsp -->

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

    <!-- <script>
    	function reply(etc_num,mem_num,sender_num){//받았던 사람이 이제 보내는사람이 되니까 반대로
    		location.href="replyEtc.student?etc_num="+etc_num+"&mem_num="+mem_num+"&sender_num="+sender_num;
    	}
    </script> --> 

			<div class="row">
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h2 class="card-title">내(학생) 문서함</h2>
                    <br><br><br>
                    <h4 class="card-title"><b>${title }</b></h4>
                    
                    <form class="forms-sample">
                      <div class="form-group">
                        <label for="exampleInputUsername1"><b>결재자</b></label><br>
                        <i class="fa fa-user-o"></i><b>${mb.name }</b>·<c:if test="${mb.category eq 'manager'}">매니저</c:if>
                      </div>
                      <hr>
                      <div class="form-group">
                        <label for="exampleInputConfirmPassword1"><i class="fa fa-pencil-square-o"></i><b>요청내용</b></label><br>
                      	${reason }
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1"><i class="fa fa-calendar"></i><b>희망 마감 날짜</b></label><br>
                        <fmt:parseDate var="fmtdate" value="${time2 }" pattern="yyyy-MM-dd"/>
						<fmt:formatDate value="${fmtdate }"  pattern="yyyy-MM-dd"/><br>
                      </div>
						<c:if test="${ap_situ == ''}">
							<label class="badge badge-warning">승인필요</label>
						</c:if> 
						<c:if test="${ap_situ == '승인'}">
							<label class="badge badge-success">승인</label>
						</c:if> 
						<c:if test="${ap_situ == '반려'}">
							<label class="badge badge-danger">반려</label>
						</c:if>
                      <hr>
                      <div class="form-group">
                        <label for="exampleInputConfirmPassword1"><b>첨부파일</b></label>
                        <c:forEach var="upload" items="${uploadList}">		
					
						<a href="<%=request.getContextPath() %>/resources/files/${upload}" download="${upload}"><br>
							<i class= "fa fa-download"></i>
							<span>${upload}</span>
						</a>
						</c:forEach>
                      </div>
                        
                    </form>
                  </div>
                </div>
              </div>
              </div>



