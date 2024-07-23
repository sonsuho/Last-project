<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>

	<style>
		.square-container {
			  width: 349px; /* 정사각형 크기 */
			  height: 250px;
			  display: inline-block; /* 가로로 나란히 배치 */
			  margin-top: 30px; /* 간격 조절 */
			  margin-left: 10px; /* 간격 조절 */
			  margin-right: 10px; /* 간격 조절 */
			  padding: 15px; /* 간격 조절 */
			  border: 2px solid #f0f0f0;
			  border-radius: 20px;
		}
		
		th{
			text-align: center !important;
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

	   <!--  <div class="col-lg-12 grid-margin stretch-card"> -->
	        <div class="card">
	            <div class="card-body">
	                	
                 	<!-- Progress Section -->
                 	<div class="lecture-container">
                 	
                 			<div class="lecture-title">
				              		<font size="5pt" style="padding-left: 20px; padding-right: 30px;">클래스별 강좌 현황</font>
				              		<button class="btn btn-gradient-success btn-rounded" onclick="location.href='lectureList.admin'">강좌목록</button>
				              </div>
		                  <% Date currentDate = new Date(); %>
			                <div class="inner-container">
											    <c:forEach var="lb" items="${lecture}">
											    		<fmt:parseDate var="end" value="${lb.lec_end}" pattern="yyyy-MM-dd" />
											    		<c:set var="nowTime" value="<%=currentDate.getTime()%>" />
											    		<div class="square-container" data-lec-num="${lb.lec_num}" onclick="lectureModal(this)" <c:if test="${end.time < nowTime}">style="opacity: 0.5;"</c:if>>
											    				<div class="square-content">
											    						<div class="square-title">
							    												<font style="padding-left: 20px; font-size: 18px; font-weight: bold; width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${lb.lec_name}</font>
							    												<button class="btn btn-inverse-dark btn-sm">${lb.class_name}</button>
							    										</div>
							    										<table class="table" style="margin-top:30px;">
																	    		<tr>
																	    				<td><span class="badge badge-info" style="width:55px; opacity: 0.6;">매니저</span></td>
																	    				<td>${lb.m_name}</td>
																	    				<td><span class="badge badge-danger" style="width:55px; opacity: 0.6;">강사</span></td>
																	    				<td>${lb.t_name}</td>
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
      <!-- </div> -->

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
	
<%@ include file="adminBarBottom.jsp" %>

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
			        	  } else if(member.state == "수료"){
			        		  state = "dark";
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
	         '<th class="table-warning" colspan=4 >' + response.lecture.lec_name + '  [' + response.lecture.lec_num + ']' + '</th>' +
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
	       	  } else if(member.state == "수료"){
	       		  state = "dark";
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
    