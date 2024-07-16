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
                    <button class="btn btn-gradient-info" type="button" data-bs-toggle="modal" data-bs-target="#secondModal" id="openSecondModal" onclick="reply('${eb.etc_num }','${sender.mem_num}','${receiver.mem_num}')"><i class="mdi mdi-email"></i> &nbsp;&nbsp;답장</button>
<%--                      <input type="button" value="답장" onclick="reply('${eb.etc_num }','${sender.mem_num}','${receiver.mem_num}')" class="btn btn-gradient-info"> --%>
                    <br><br><br>
                    <h4 class="card-title"><b>${eb.etc_title }</b></h4>
                    
                    <form class="forms-sample">
                      <div class="form-group">
                        <label for="exampleInputUsername1"></label>
                        <i class="fa fa-user-o"></i><b>${sender.name }</b>·<c:if test="${sender.category eq 'manager'}">매니저</c:if>
                      </div>
                      <hr>
                      <div class="form-group">
                        <label for="exampleInputConfirmPassword1"><i class="fa fa-pencil-square-o"></i><b>요청내용</b></label><br>
                      	${eb.etc_content }
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1"><i class="fa fa-calendar"></i><b>보낸날짜</b></label><br>
                        <fmt:parseDate var="fmtdate" value="${eb.etc_sdate }" pattern="yyyy-MM-dd HH:mm"/>
						<fmt:formatDate value="${fmtdate }"  pattern="yyyy-MM-dd HH:mm"/>
                      </div>
                      <hr>
                      <div class="form-group">
                        <label for="exampleInputConfirmPassword1"><b>첨부파일</b> ${fileCount}개</label>
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
              
<script>
  
	</script>

