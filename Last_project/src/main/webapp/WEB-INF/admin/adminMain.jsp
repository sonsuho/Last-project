<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>
	
<%
    // 현재 날짜 정보 가져오기
    java.time.LocalDate currentDate = java.time.LocalDate.now();
    
    // 현재 월의 첫 날과 마지막 날 계산
    java.time.LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
    java.time.LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth());
    
    // 첫 날의 요일 가져오기 (1: 월요일, 7: 일요일)
    int firstDayOfWeekValue = firstDayOfMonth.getDayOfWeek().getValue();
    // 첫 날의 요일 (한국 형식, 1: 월요일, 7: 일요일)
    int firstDayOfWeekKorea = firstDayOfWeekValue % 7 + 1; // 일요일로 다시 시작하는 형식
%>

	<style>
		.square-container {
			  width: 30%; /* 정사각형 크기 */
			  height: 250px;
			  display: inline-block; /* 가로로 나란히 배치 */
			  margin-top: 30px; /* 간격 조절 */
			  margin-left: 10px; /* 간격 조절 */
			  margin-right: 10px; /* 간격 조절 */
			  padding: 15px; /* 간격 조절 */
			  border: 2px solid #f0f0f0;
			  border-radius: 20px;
		}
		
		.square-content {
			  margin-top: 15px;
    }
    
    .square-container:hover{
		border: 2px #dcdcdc solid;
		cursor: pointer;
		opacity: 0.8;
}

    .square-title {
    		display: flex;
			  align-items: center;
			  justify-content: space-between;
			  margin-right: 20px;
    }
    
    .lecture-title {
    		display: flex;
			  align-items: center;
			  margin-top: 12px;
    }
		
		.calendar-table {
        width: 100%;
        border-collapse: collapse;
    }

    .calendar-table th, .calendar-table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #e0e0e0;
    }

    .notice-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .notice-list li {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .lecture-date {
				margin-right: 20px;
				color: #6e6e6e;
				font-size: 12pt;
		}
		
		.modal-header {
			  display: flex;
			  justify-content: space-between;
			  align-items: center;
		}
	</style>

 	<div class="row">
	    <div class="col-lg-12 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                	
                 	<!-- Progress Section -->
                 	<div class="lecture-container">
                 	
                 			<div class="lecture-title">
				              		<font size="5pt" style="padding-left: 20px; padding-right: 30px;">클래스별 강좌 현황</font>
				              		<button class="btn btn-gradient-success btn-rounded" onclick="location.href='lectureList.admin'">강좌목록</button>
				              </div>
		                  
			                <div class="inner-container">
											    <c:forEach var="lb" items="${lecture}">
											    		<div class="square-container" data-lec-num="${lb.lec_num}" onclick="lectureModal(this)">
											    				<div class="square-content">
											    						<div class="square-title">
							    												<font style="padding-left: 20px; font-size: 20px; font-weight: bold; width: 320px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${lb.lec_name}</font>
							    												<button class="btn btn-inverse-secondary btn-sm">${lb.class_name}</button>
							    										</div>
							    										<table class="table" style="margin-top:30px;">
																	    		<tr>
																	    				<td><span class="badge badge-info" style="width:55px; opacity: 0.6;">매니저</span></td>
																	    				<td>${lb.t_name}</td>
																	    				<td><span class="badge badge-danger" style="width:55px; opacity: 0.6;">강사</span></td>
																	    				<td>${lb.m_name}</td>
																	    				<td><span class="badge badge-success" style="width:55px; opacity: 0.6;">학생수</span></td>
																    				<td>${lb.student}/${lb.stu_cnt}</td>
																	    		</tr>
																	    </table>
																	    <p style="padding-top:20px; padding-left: 20px;" align="left">
								                      		<fmt:parseDate var="start" value="${lb.lec_start}" pattern="yyyy-MM-dd" />
											                    <fmt:parseDate var="end" value="${lb.lec_end}" pattern="yyyy-MM-dd" />
											                    <span class="lecture-date">
											                    		<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~ 
											                    		<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
											                    </span>
								                      </p>
								                      <div class="progress" style="position: relative; margin-left:10px; margin-right: 10px;">
								                      		<div class="progress-bar bg-success" role="progressbar" style="opacity:0.6; width: ${(1 - lb.remainingDays/lb.totalDays)*100}%" aria-valuenow="${lb.progressPercent}" aria-valuemin="0" aria-valuemax="100"></div>
								                      		<span style="position: absolute; top: 0; left: 50%; transform: translateX(-50%); color: white; font-size: 1.2em;">${lb.progressPercent}%</span>
								                      </div>
											    				</div>
												    	</div>
											    </c:forEach>
							</div>
											
                  </div>
              </div>
          </div>
      </div>
						
	    <div class="col-lg-6 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                
                 <!-- Calendar and Notice Section -->
                  <h4><%= currentDate.getYear() %>년 <%= currentDate.getMonthValue() %>월 캘린더</h4>
                  <table class="calendar-table">
                      <thead>
                          <tr>
                              <th>Su</th>
                              <th>Mo</th>
                              <th>Tu</th>
                              <th>We</th>
                              <th>Th</th>
                              <th>Fr</th>
                              <th>Sa</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr>
                              <% 
                                  // 첫 주의 공백 채우기
                                  for (int i = 1; i < firstDayOfWeekKorea; i++) {
                              %>
                              <td></td>
                              <% } %>
                              
                              <% 
             // 날짜 출력
             int dayOfMonth = 1;
             while (dayOfMonth <= lastDayOfMonth.getDayOfMonth()) {
                 
                 // 오늘 날짜와 같으면 셀에 초록색 배경 추가
                 boolean isToday = (dayOfMonth == java.time.LocalDate.now().getDayOfMonth());
                 
                 if (isToday) { %>
                     <td style="background-color: #36E0C6;"><%= dayOfMonth %></td>
                 <% } else { %>
                     <td><%= dayOfMonth %></td>
                 <% }
                 
                 // 일주일이 끝나면 다음 줄로
                 if ((firstDayOfWeekKorea + dayOfMonth - 1) % 7 == 0) { %>
         </tr><tr>
             <% }
             dayOfMonth++;
             } 
         %>
                          </tr>
                      </tbody>
                  </table>
                      
              </div>
          </div>
      </div>
	              
	    <div class="col-lg-6 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                         
                  <h4>공지사항</h4>
                  <ul class="notice-list">
                      <li>
                          <span class="badge badge-secondary" style="width:8%">전체</span>
                          <span>쌍용강북센터 휴가 안내</span>
                          <span>2024-06-28</span>
                      </li>
                      <li>
                          <span class="badge badge-info" style="width:8%">우리반</span>
                          <span>MySQL 과제 리스트 안내</span>
                          <span>2024-06-24</span>
                      </li>
                      <li>
                          <span class="badge badge-info" style="width:8%">우리반</span>
                          <span>Spring 설치 방법</span>
                          <span>2024-06-24</span>
                      </li>
                      <li>
                          <span class="badge badge-secondary" style="width:8%">전체</span>
                          <span>국민취업지원제도 관련 안내</span>
                          <span>2024-06-19</span>
                      </li>
                      <li>
                          <span class="badge badge-secondary" style="width:8%">전체</span>
                          <span>시스템 사용 안내</span>
                          <span>2024-06-14</span>
                      </li>
                  </ul>
	                     
	            </div>
	        </div>
	    </div>
	</div>

	<!-- 강좌 상세정보 모달 -->
	<div class="modal fade" id="lectureModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="lectureModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" style="max-width: 50%;">
	    <div class="modal-content">
     	  <div class="card">
  				<div class="card-body">
			      
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="lectureModalLabel" style="color:#c8c8c8; font-weight:bold;">강좌 상세 정보</h1> &nbsp;&nbsp;&nbsp;
			        <span id="lecture-state"></span>
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
			      </div> <br>
			      
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			      </div>
															      
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

<script type="text/javascript">

function studentDetail(lec_num) {
   	$.ajax({
	      type: "POST",
	      url: "lectureDetail.admin",
	      data: { lec_num: lec_num },
	      success: function(response) {
		        // 학생 정보 리스트를(response.members) #member-list 영역에 추가하는 코드
		        $('#member-list').empty(); // 기존 데이터 제거
		        $('#member-list').append(
			          '<br><br>' +
			          '<table class="table table-hover">' +
			          '<thead><tr class="table-info">' +
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
			              '<td align=center>' + member.mem_num + '</td>' +
			              '<th>' + member.name + '</th>' +
			              '<td align=center>' + member.phone + '</td>' +
			              '<td align=center>' + member.email + '</td>' +
			              '<td align=center><label style="font-size:13px;" class="badge badge-' + state + '">' + member.state + '</label></td>' +
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
    $('#studentDetailModal').modal('show');
}

function lectureModal(element) {
	var lec_num = element.getAttribute('data-lec-num');
   $.ajax({
	     type: "POST",
	     url: "lectureDetail.admin",
	     data: {
	       lec_num: lec_num
	     },
	     success: function(response) {
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
	       
	       $('#lecture-state').html(
	    		'<label class="badge badge-' + lecState + '" style="font-size: 10pt;">' + lectureState + '</label>'
	   		); 
	       
	       $('#lecture-info').html(
	    		'<table class="table table-bordered">' + 
	         '<tr>' +
	         '<th class="table-warning" colspan=4>' + response.lecture.lec_name + '  [' + response.lecture.lec_num + ']' + '</th>' +
	         '</tr>' +
	         '<tr>' +
	         '<th rowspan=2>기간</th><td colspan=3 align=center>' + lecStartDateStr + " ~ " + lecEndDateStr + '</td>' +
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
	         '<th>학생수</th><td align=center>' + response.members.length + "/" + response.lecture.stu_cnt + '</td>' +
	         '<th>반</th><td align=center>' + response.lecture.class_name + '</td>' +
	         '</tr>' +
	         '<tr>' +
	         '<th rowspan=3>매니저</th><td align=center>' + response.lecture.m_name + ' (' + response.lecture.m_age + "/" + response.lecture.m_gender + ')</td>' +
	         '<th rowspan=3>강사</th><td align=center>' + response.lecture.t_name + ' (' + response.lecture.t_age + "/" + response.lecture.t_gender + ')</td>' +
	         '</tr>' +
	         '<tr>' +
	         '<td align=center><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.m_phone + '</td><td align=center><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.t_phone + '</td>' +
	         '</tr>' +
	         '<tr>' +
	         '<td align=center><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.m_email + '</td><td align=center><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;' + response.lecture.t_email + '</td>' +
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
	             '<td align=center>' + member.mem_num + '</td>' +
	             '<td align=center>' + member.name + '</td>' +
	             '<td align=center>' + member.phone + '</td>' +
	             '<td align=center>' + member.email + '</td>' +
	             '<td align=center><label class="badge badge-' + state + '">' + member.state + '</label></td>' +
	             '</tr>'
	           );
	         });
	       } else {
	         // response.members가 배열이 아닌 경우 처리
	         $('#member-list table').append('<tr><td colspan="5" align=center>학생 정보가 없습니다.</td></tr>');
	       }
	       $('#member-list').append('</tbody></table>');
	     }
   });
   $('#lectureModal').modal('show');
}
</script>
    
<%@ include file="adminBarBottom.jsp" %>