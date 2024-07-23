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
	.card-body{
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
	              	<fmt:parseDate var="start" value="${lecture.lec_start}" pattern="yyyy-MM-dd" />
	                <fmt:parseDate var="end" value="${lecture.lec_end}" pattern="yyyy-MM-dd" />
	                <tr data-bs-target="#staticBackdrop" data-lec-num="${lecture.lec_num}" <c:if test="${end.time < currentDate.time}">style="opacity: 0.7;"</c:if>>
	                  <td><input type="checkbox" name="rowcheck" value="${lecture.lec_num}" class="form-check-input"></td>
	                  <td>${lecture.lec_num}</td>
	                  <td>${lecture.lec_name}</td>
	                  <td>${lecture.m_name}</td>
	                  <td>${lecture.t_name}</td>
	                  <td>
	                    <fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~
	                    <fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
	                  </td>
	                  <td>${lecture.student} / ${lecture.stu_cnt}</td>
	                  <td>${lecture.class_name}</td>
	                  <td>
	                    <c:choose>
						    <c:when test="${start.time > currentDate.time}">
						      <label class="badge badge-warning">예정</label>
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
	                  	<c:if test="${end.time >= currentDate.time}">
	                  		<input type="button" value="수정" onclick="openEditModal(this)" class="form-updateBtn btn btn-sm btn-gradient-light">
	                  	</c:if>
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
					
					<!-- 강좌 정보 수정 모달 -->
					<div class="modal fade" id="editModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="editModalLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					    	<div class="card">
	     						<div class="card-body">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="color:#c8c8c8; font-weight:bold;">
							        	강좌 정보 수정 &nbsp;&nbsp;
							        </h1>
							      	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body"><br>
							        <form id="editForm">
							          <input type="hidden" name="lec_num" id="lec_num">
							          <div class="mb-3">
							            <label for="lec_name" class="form-label">강좌이름</label>
							            <input type="text" class="form-control" id="lec_name" name="lec_name" required>
							          </div>
							          <div class="d-flex align-items-center justify-content-between">
								          <div class="mb-3">
								            <label for="m_name" class="form-label">매니저</label>
								            <select class="form-select" id="manager" name="manager" style="color: black;" required>
								              <option value="">선택</option>
								              <!-- 매니저 목록 동적 생성 -->
								            </select>
								          </div>
								          <div class="mb-3">
								            <label for="t_name" class="form-label">강사</label>
								            <select class="form-select" id="teacher" name="teacher" style="color: black;" required>
								              <option value="">선택</option>
								              <!-- 강사 목록 동적 생성 -->
								            </select>
								          </div>
								        </div>
							          <div class="mb-3">
												  <label class="form-label me-3">기간</label>
												  <div class="d-flex align-items-center">
													  <input type="date" class="form-control me-3" id="lec_start" name="lec_start" required>
													  ~
													  <input type="date" class="form-control ms-3" id="lec_end" name="lec_end" required>
													</div>
												</div>
												<div class="d-flex align-items-center justify-content-between">
													<div class="mb-3">
								            <label for="stu_cnt" class="form-label">학생수</label>
								            <div class="d-flex align-items-center">
									            <input type="number" id="stu_cnt" name="stu_cnt" size="1" min="10" max="30" class="form-control mr-2" style="width:100px" required> &nbsp;&nbsp;
								          		<span id="student" style="font-size:10pt"></span>
								          	</div>
								          </div>
								          <div class="mb-3">
								            <label for="class_name" class="form-label">반이름</label>
								            <% String[] class_name = {"A","B","C","D","E","F","G","H"}; %>
								            <select class="form-select" id="class_name" name="class_name" required>
								            	<c:forEach var="class_name" items="<%=class_name%>">
								            		<option value=${class_name}>${class_name}
								            	</c:forEach>
								            </select>
								          </div>
								        </div>
							        </form>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <button type="button" class="btn btn-primary" onclick="updateLecture(document.getElementById('lec_num').value)">수정 완료</button>
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
	        	lecState = "warning";
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
  	          '<th>학생수</th><td>' + response.members.length + " / " + response.lecture.stu_cnt + '</td>' +
  	          '<th>반</th><td>' + response.lecture.class_name + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<th rowspan=3>매니저</th><td>' + response.lecture.m_name + ' (' + response.lecture.m_age + "/" + response.lecture.m_gender + ')</td>' +
  	          '<th rowspan=3>강사</th><td>' + response.lecture.t_name + ' (' + response.lecture.t_age + "/" + response.lecture.t_gender + ')</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<td><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.m_phone + '</td><td><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.t_phone + '</td>' +
  	          '</tr>' +
  	          '<tr>' +
  	          '<td><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.m_email + '</td><td><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.t_email + '</td>' +
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
	
	function openEditModal(button) {
		  var tr = button.closest('tr');
		  var lecNum = tr.dataset.lecNum;

		  $.ajax({
		    type: "GET",
		    url: "lectureUpdate.admin",
		    data: {
		      lec_num: lecNum
		    },
		    success: function(response) {
		    	document.getElementById('lec_num').value = response.lecture.lec_num;
		      document.getElementById('lec_name').value = response.lecture.lec_name;
		      populateSelectOptions('manager', response.managerList);
		      populateSelectOptions('teacher', response.teacherList);
		      document.getElementById('manager').value = response.lecture.manager;
		      document.getElementById('teacher').value = response.lecture.teacher;
		      document.getElementById('lec_start').value = response.lecture.lec_start;
		      document.getElementById('lec_end').value = response.lecture.lec_end;
		      document.getElementById('student').innerHTML = "(현재 등록된 학생수 : " + response.lecture.student + "명)";
		      document.getElementById('stu_cnt').value = response.lecture.stu_cnt;
		      document.getElementById('class_name').value = response.lecture.class_name;

		      // 모달 표시 로직
		      var modal = new bootstrap.Modal(document.getElementById('editModal'));
		      modal.show();
		    }
		  });
	}
	
	function populateSelectOptions(selectId, options) {
	  var select = document.getElementById(selectId);
	  select.innerHTML = '';

	  options.forEach(option => {
	    var optionElement = document.createElement('option');
	    optionElement.value = option.mem_num;
	    optionElement.textContent = option.name;
	    select.appendChild(optionElement);
	  });
	}

	function updateLecture(lec_num) {
	  var form = document.getElementById('editForm');
	  var formData = new FormData(form);

	  $.ajax({
	    type: "POST",
	    url: "lectureUpdate.admin",
	    data: formData,
	    processData: false,
	    contentType: false,
	    success: function(response) {
	    	var lecNum = response.lecture.lec_num;
	      if(response.lecture != "실패"){
	        alert("수정되었습니다");
	        // 수정 성공 시 해당 행 데이터 업데이트
       	  var tr = document.querySelector('tr[data-lec-num="'+response.lecture.lec_num+'"]');
       	  if (tr) {
       	    // tr 요소를 사용할 수 있습니다.
       	    tr.querySelector('td:nth-child(3)').textContent = response.lecture.lec_name;
       	    tr.querySelector('td:nth-child(4)').textContent = response.lecture.m_name;
       	    tr.querySelector('td:nth-child(5)').textContent = response.lecture.t_name;
       	 		response.lecture.lec_start = formatDate(response.lecture.lec_start);
      	 		response.lecture.lec_end = formatDate(response.lecture.lec_end);
       	    tr.querySelector('td:nth-child(6)').textContent = response.lecture.lec_start + " ~ " + response.lecture.lec_end;
       	    tr.querySelector('td:nth-child(7)').textContent = response.lecture.student + "/" + response.lecture.stu_cnt;
       	    tr.querySelector('td:nth-child(8)').textContent = response.lecture.class_name;

       	    // 모달 창 닫기
       	    $('#editModal').modal('hide');
       	  } else {
       	    console.error('tr 요소를 찾을 수 없습니다.');
       	  }
	      } else{
	        alert("수정 실패");
	      }
	    }
	  });
	}
	
	function formatDate(dateString) {
	  var date = new Date(dateString);
	  var year = date.getFullYear();
	  var month = String(date.getMonth() + 1).padStart(2, '0');
	  var day = String(date.getDate()).padStart(2, '0');
	  return year+"-"+month+"-"+day;
	}
	</script>
    
<%@ include file="adminBarBottom.jsp" %>