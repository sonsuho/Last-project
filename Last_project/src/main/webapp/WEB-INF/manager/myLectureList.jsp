<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="managerBarTop.jsp" %>

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
	.fa-minus-square {
	  color: #36E0C6;
	  font-size: 20px;
	}
	.fa-plus-square{
	  color: #36E0C6;
	  font-size: 30px;
	}
	.fa-minus-square:hover, .fa-plus-square:hover {
	  color: #18CCA8; /* 마우스 오버 시 색상 변경 */
	}
	.card-body {
	  min-height: 55vh; /* viewport 높이의 50% */
	}
	th, td{
	  text-align: center;
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
		<h3 class="page-title">내 수업 정보</h3>
	</div>
	
  <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	      
			    <div class="row">
			    	<div class="col-lg-8">
			    	</div>
	          <div class="col-lg-4">
	            <div class="form-group d-flex align-items-center">
	              <form action="lectureList.manager" method="post" class="container d-flex align-items-center">
	                <select name="whatColumn" class="form-select mr-2">
	                  <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체</option>
	                  <option value="lec_name" <c:if test="${param.whatColumn eq 'lec_name'}">selected</c:if>>강좌이름</option>
	                  <option value="manager" <c:if test="${param.whatColumn eq 'manager'}">selected</c:if>>매니저</option>
	                  <option value="teacher" <c:if test="${param.whatColumn eq 'teacher'}">selected</c:if>>강사</option>
	                </select>
	                <input type="text" name="keyword" value="<c:if test="${param.keyword ne 'null'}">${param.keyword}</c:if>" class="form-control mr-2" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                <input type="submit" value="검색" class="btn btn-sm btn-gradient-primary py-3 mr-2">
	                <input type="button" value="전체" onclick="location.href='lectureList.manager'" class="btn btn-sm btn-gradient-primary py-3">
	              </form>
	            </div>
	          </div>
	        </div>
			    
			    <table class="table table-hover">
			    	<thead>
				    	<tr>
				    		<th>강좌번호</th>
				    		<th>강좌이름</th>
				    		<th>매니저</th>
				    		<th>강사</th>
				    		<th>반이름</th>
				    		<th>기간</th>
				    		<th>학생수</th>
				    		<th>학생등록</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<c:forEach var="lecture" items="${lectureList}">
				    	<tr data-bs-target="#staticBackdrop" data-lec-num="${lecture.lec_num}">
							  <td>${lecture.lec_num}</td>
							  <td>${lecture.lec_name}</td>
							  <td>${lecture.manager}</td>
							  <td>${lecture.teacher}</td>
							  <td>${lecture.class_name}</td>
							  <td>
							    <fmt:parseDate var="start" value="${lecture.lec_start}" pattern="yyyy-MM-dd" />
							    <fmt:parseDate var="end" value="${lecture.lec_end}" pattern="yyyy-MM-dd" />
							    <fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~
							    <fmt:formatDate value="${end}" pattern="yyyy-MM-dd" /> &nbsp;
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
							  <td>${lecture.student} / ${lecture.stu_cnt}</td>
							  <td>
							    <button type="button" data-lec-num="${lecture.lec_num}" class="btn btn-sm btn-gradient-success py-3 student-register-button">학생등록</button>
							  </td>
							</tr>
				    	</c:forEach>
				    </tbody>
			    </table>
			    
			    <center>${pageInfo.pagingHtml}</center>
			    
			    <!-- 수업 상세정보 모달 -->
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
										    <!-- 학생 정보 영역 -->
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

	<%@ include file = "managerBarBottom.jsp"%>

	<script>	  
	// tr 클릭 시 모달 열기
	$('table').on('click', 'tr', function(event) {
	  // 버튼 클릭 시 이벤트 전파 중지 및 빈 모달 열리지 않게 설정
	  var isButton = $(event.target).is('button');
	  if (!isButton) {
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
	  }
	});

	// 버튼 클릭 시 이벤트 전파 중지
	$('table').on('click', '.student-register-button', function(event) {
	  event.stopPropagation();
	  var lecNum = $(this).data('lec-num');
	  window.location.href = "stuInsert.manager?lec_num=" + lecNum;
	});
	</script>
	