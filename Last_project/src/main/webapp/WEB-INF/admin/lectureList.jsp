<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>
	
	<style>
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
	  width: 250px;
	}
	
	th, td{
	  text-align: center;
	}
	
	.form-check-input:checked {
	  background-color: #A566FF;
	  border-color: #A566FF;
	}
	.card-body {
	  min-height: 70vh; /* viewport 높이의 50% */
	}
	.modal-dialog {
	  max-width: 35%; /* 모달의 최대 너비를 화면의 35%로 설정 */
	  margin: 1.75rem auto;
	}
	.modal-header h1 {
	  display: flex;
	  align-items: center;
	}
	.modal-header h1 span {
	  vertical-align: middle;
	}
	.modal-header {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	.badge{
		font-size: 13px;
	}
	</style>
	
  	<div class="page-header">
    	<h3 class="page-title">강좌목록</h3>
    </div>
    
	<div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	        <div class="row">
	          <div class="col-lg-8">
	            <div class="form-group d-flex align-items-center">
	              <button type="button" onclick="selectDel()" class="btn btn-sm btn-gradient-danger py-3">선택삭제</button>
	              <button type="button" onclick="location.href='lectureInsert.admin?pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'" class="btn btn-sm btn-gradient-success py-3">강좌개설</button>
	            </div>
	          </div>
	          <div class="col-lg-4">
	            <div class="form-group d-flex align-items-center">
	              <form action="lectureList.admin" method="post" class="container d-flex align-items-center">
	                <select name="whatColumn" class="form-select mr-2">
	                  <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체</option>
	                  <option value="lec_name" <c:if test="${param.whatColumn eq 'lec_name'}">selected</c:if>>강좌이름</option>
	                  <option value="manager" <c:if test="${param.whatColumn eq 'manager'}">selected</c:if>>매니저</option>
	                  <option value="teacher" <c:if test="${param.whatColumn eq 'teacher'}">selected</c:if>>강사</option>
	                </select>
	                <input type="text" name="keyword" value="<c:if test="${param.keyword ne 'null'}">${param.keyword}</c:if>" class="form-control mr-2" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                <input type="submit" value="검색" class="btn btn-sm btn-gradient-primary py-3 mr-2">
	                <input type="button" value="전체" onclick="location.href='lectureList.admin'" class="btn btn-sm btn-gradient-primary py-3">
	              </form>
	            </div>
	          </div>
	        </div>
	        <form name="deleteForm" action="lectureDelete.admin" method="post">
	          <input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
	          <input type="hidden" name="whatColumn" value="${param.whatColumn}">
	          <input type="hidden" name="keyword" value="${param.keyword}">
	          <table class="table table-hover">
	            <thead>
	              <tr>
	                <th><input type="checkbox" name="allcheck" onClick="allCheck(this)" class="form-check-input"></th>
	                <th>강좌번호</th>
	                <th>강좌이름</th>
	                <th>매니저</th>
	                <th>강사</th>
	                <th>기간</th>
	                <th>학생수</th>
	                <th>반이름</th>
	                <th>상태</th>
	                <th>수정</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach var="lecture" items="${lectureList}">
	                <tr data-bs-target="#staticBackdrop" data-lec-num="${lecture.lec_num}">
	                  <td><input type="checkbox" name="rowcheck" value="${lecture.lec_num}" class="form-check-input"></td>
	                  <td>${lecture.lec_num}</td>
	                  <td>${lecture.lec_name}</td>
	                  <td>${lecture.manager}</td>
	                  <td>${lecture.teacher}</td>
	                  <td>
	                    <fmt:parseDate var="start" value="${lecture.lec_start}" pattern="yyyy-MM-dd" />
	                    <fmt:parseDate var="end" value="${lecture.lec_end}" pattern="yyyy-MM-dd" />
	                    <fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~
	                    <fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
	                  </td>
	                  <td>${lecture.student} / ${lecture.stu_cnt}</td>
	                  <td>${lecture.class_name}</td>
	                  <td>
	                    <c:choose>
										    <c:when test="${start.time > currentDate.time}">
										      <label class="badge badge-success">예정</label>
										    </c:when>
										    <c:when test="${start.time <= currentDate.time and end.time >= currentDate.time}">
										      <label class="badge badge-info">진행</label>
										    </c:when>
										    <c:otherwise>
										      <label class="badge badge-danger">종료</label>
										    </c:otherwise>
										  </c:choose>
	                  </td>
	                  <td>
	                  	<input type="button" value="수정" onclick="location.href='lectureUpdate.admin?lec_num=${lecture.lec_num}'" class="form-updateBtn btn btn-sm btn-gradient-light">
	                  </td>
	                </tr>
	              </c:forEach>
	            </tbody>
	          </table>
	        </form>
	        
         	<center>${pageInfo.pagingHtml}</center>
         	
         	<!-- 강좌 상세정보 모달 -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" style="max-width: 50%;">
					    <div class="modal-content">
			      	  <div class="card">
	     						<div class="card-body">
							      
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="color:#c8c8c8; font-weight:bold;">
							        	강좌 상세 정보 &nbsp;&nbsp; <span id="modalState"></span>
							        </h1>
							      	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div> <br>
							      
							      <div class="modal-body">
										  <div id="lecture-info">
										  	<!-- 강좌 정보 영역 -->
										  </div>
										  <br>
							        <div id="member-list">
										    <!-- 회원 정보 영역 -->
										  </div>
							      </div>
							      
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							      </div>
																			      
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
					
	      </div>
	    </div>
	  </div>
	</div>

	<script type="text/javascript">
	$(document).ready(function() {
	  // 체크박스 클릭 시 이벤트 전파 중지 및 빈 모달 열리지 않게 설정
	  $('table').on('click', '.form-check-input', function(event) {
	    event.stopPropagation(); // 이벤트 전파 중지
	  });
	  $('table').on('click', '.form-updateBtn', function(event) {
	    event.stopPropagation(); // 이벤트 전파 중지
	  });

	  // tr 클릭 시 모달 열기
	  $('table').on('click', 'tr', function(event) {
	    // 체크박스를 클릭한 경우 모달을 열지 않음
	    if ($(event.target).is('.form-check-input')) {
	      return; // 함수 종료
	    }

	    var button = $(this); // 클릭된 tr 요소
	    var lecNum = button.data('lec-num'); // 클릭된 tr의 data-lec-num 값 가져오기

	    $.ajax({
	      type: "POST",
	      url: "lectureDetail.admin",
	      data: {
	        lec_num: lecNum
	      },
	      success: function(response) {
	        console.log(response);
	        console.log(response.lecture);
	        console.log(response.members);
	        // response.lecture : 강좌 정보
	        // response.members : 학생 정보 리스트

	        // 모달 내부의 영역에 response 데이터 추가
	        var lecStartDate = new Date(response.lecture.lec_start);
	        var lecEndDate = new Date(response.lecture.lec_end);
	        var lecStartDateStr = lecStartDate.toLocaleDateString();
	        var lecEndDateStr = lecEndDate.toLocaleDateString();
	        
	        // 오늘 날짜 계산 (밀리초 단위)
	        var today = new Date();
	        var totalTime = lecEndDate - lecStartDate;
	        var elapsedTime = today - lecStartDate;

	        // 전체 기간 중 오늘 날짜가 몇 퍼센트인지 계산
	        var progressPercent = (elapsedTime / totalTime) * 100;
	        progressPercent = Math.min(Math.max(progressPercent, 0), 100); // 0% ~ 100% 범위로 제한
	        
	        var lecState;
	        var lectureState;
	        
	        if(today < lecStartDate){
	        	lecState = "success";
	        	lectureState = "예정";
	        } else if(today >= lecStartDate && today <= lecEndDate){
	        	lecState = "info";
	        	lectureState = "진행";
	        }else if(today > lecEndDate){
	        	lecState = "danger";
	        	lectureState = "종료";
	        }
	        
	        $('#modalState').html(
        		'<label class="badge badge-' + lecState + '">' + lectureState + '</label>'
       		); 
	        
	        $('#lecture-info').html(
        		'<table class="table table-bordered">' + 
  	          '<tr>' +
  	          '<th class="table-warning" colspan=4>' + response.lecture.lec_name + '  [' + response.lecture.lec_num + ']' + '</th>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<th rowspan=2>기간</th><td colspan=3>' + lecStartDateStr + " ~ " + lecEndDateStr + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<td colspan=3>' +
  		          '<div class="progress" style="position: relative;">' +
  		            '<div class="progress-bar bg-warning" role="progressbar" style="width: ' + progressPercent + '%" aria-valuenow="' + progressPercent + '" aria-valuemin="0" aria-valuemax="100"></div>' +
  		            '<span style="position: absolute; top: 0; left: 50%; transform: translateX(-50%); color: #8B5927; font-size: 1.3em;">' + Math.round(progressPercent) + '%</span>' +
  		          '</div>' +
  		        '</td>' + 
  	          '</tr>' +
  	          '<tr>' +
  	          '<th>학생수</th><td>' + response.members.length + "/" + response.lecture.stu_cnt + '</td>' +
  	          '<th>반</th><td>' + response.lecture.class_name + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<th rowspan=3>매니저</th><td>' + response.lecture.manager + '</td>' +
  	          '<th rowspan=3>강사</th><td>' + response.lecture.teacher + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<td>' + response.lecture.m_phone + '</td><td>' + response.lecture.t_phone + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<td>' + response.lecture.m_email + '</td><td>' + response.lecture.t_email + '</td>' +
  	          '</tr>' +
  	          '</table>'
	        );

	        // 학생 정보 리스트를 #member-list 영역에 추가하는 코드
	        $('#member-list').empty(); // 기존 데이터 제거
	        $('#member-list').append(
	          '<br><br>' +
	          '<table class="table table-hover">' +
	          '<thead><tr>' +
	          '<th class="table-info" colspan=5>학생 정보</th>' +
	          '</tr><tr>' +
	          '<th>회원번호</th><th>이름</th><th>전화번호</th><th>이메일</th><th>상태</th>' +
	          '</tr></thead><tbody>'
	        );
	        var state;
	        if (response.members && Array.isArray(response.members) && response.members.length > 0) {
	          $.each(response.members, function(index, member) {
	        	  if(member.state == "진행"){
	        		  state = "info";
	        	  } else if(member.state == "퇴실"){
	        		  state = "danger";
	        	  }
	            $('#member-list table').append(
	              '<tr>' +
	              '<td>' + member.mem_num + '</td>' +
	              '<td>' + member.name + '</td>' +
	              '<td>' + member.phone + '</td>' +
	              '<td>' + member.email + '</td>' +
	              '<td><label class="badge badge-' + state + '">' + member.state + '</label></td>' +
	              '</tr>'
	            );
	          });
	        } else {
	          // response.members가 배열이 아닌 경우 처리
	          $('#member-list table').append('<tr><td colspan="5">학생 정보가 없습니다.</td></tr>');
	        }
	        $('#member-list').append('</tbody></table>');
	      }
	    });
	    $('#staticBackdrop').modal('show');
	  });
	});

	
	function allCheck(obj){
		var rc = document.getElementsByName("rowcheck");
		if(obj.checked){
			for(i=0; i<rc.length; i++){
				rc[i].checked = true;
			}
		} else {
			for(i=0; i<rc.length; i++){
				rc[i].checked = false;
			}
		}
	}
	function selectDel(){
		var rc = document.getElementsByName("rowcheck");
		var flag = false;
		for(i=0; i<rc.length; i++){
			if(rc[i].checked){
				flag = true;
			}
		}
		if(flag){
			var del = confirm("정말 삭제하시겠습니까?");
			if(del){
				deleteForm.submit();
			}
		} else {
			alert('선택된 항목이 없습니다');
		}
	}
	</script>
    
<%@ include file="adminBarBottom.jsp" %>