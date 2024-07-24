<%@page import="manager.model.mCalendarBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.SimpleTimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>

<style>
.btn-hover {
    width: 140px;
    font-size: 18px;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
    margin: 30px;
    height: 65px;
    text-align:center;
    border: none;
    background-size: 300% 100%;

    border-radius: 65px;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:hover {
    background-position: 100% 0;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:focus {
    outline: none;
}

.btn-hover.color-1 {
    background-image: linear-gradient(to right, #41F2B1, #2CDDDA, #2CDDDA, #41F2B1);
    box-shadow: 0 4px 15px 0 rgba(49, 196, 190, 0.75);
    opacity: 0.8;
}

.progress-bar {
    width: 100%;
    height: 20px;
    background: #e0e0e0;
    border-radius: 10px;
    margin: 20px 0;
    position: relative;
}

.progress-bar .progress {
    height: 100%;
    width: 80%;
    background: #36E0C6;
    border-radius: 10px;
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

.badge {
    padding: 5px 10px;
    border-radius: 5px;
    color: #fff;
}

.lecture-container {
		display: flex;
 align-items: center;
}
  
.right-container {
    float: right;
    padding: 30px 40px;
    border: 2px #f0f0f0 solid;
    border-radius: 15px;
    flex-basis: 40%;
    height: 80%;
    margin-top: 30px;
}

.lecture-container-all{
		display: flex;
			justify-content: space-between;
			align-items: center;
}

.progress-container {
  	flex-basis: 55%;
}

.lecture-date {
		margin-right: 20px;
		color: #b4b4b4;
		font-size: 14pt;
}

.lecture-Dday {
		float: right;
		margin-top: 6px;
		margin-right: -10px;
		font-size: 11pt;
		color: #828282;
		font-weight: bold;
}

/* calendar */
/* 기존 스타일을 새로운 클래스 이름으로 변경 */
.calendar-header {
    text-align: center;
    background: #28a745;
    color: #fff;
    padding: 10px;
}

.calendar-day {
    text-align: center;
    background: #fff;
    padding: 0px 1px 15px;
    border: 1px solid #dee2e6;
    width: 45px;
    height: 45px;
}

.calendar-day a {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 5px 1px 15px;
    color: #000;
    text-decoration: none;
}

.calendar-today {
    position: relative;
}

.calendar-today a {
    position: relative;
    z-index: 1;
}

.calendar-today::before {
    content: '';
    position: absolute;
    top: 35%;
    left: 50%;
    width: 37px;
    height: 37px;
    background: #FFFFFF;
    border: 2px solid #208738;
    border-radius: 50%;
    transform: translate(-50%, -50%);
    z-index: 0;
}

.date-wrap {
	font-family: Comic Sans MS, serif;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	float: left;
}

.date-month {
	margin-bottom: 20px;
}

.date-month h2 {
	margin: 0;
	font-size: 24px;
	color: #343a40;
}

.button_wrap {
	text-align: left;
	margin-top: 10px;
}

.button_wrap button {
	font-size: 16px;
	font-weight: bold;
	background: #007bff;
	color: #fff;
	border-radius: 4px;
	border: none;
	cursor: pointer;
}

.button_wrap button:hover {
	background: #0056b3;
}

table.date-month {
	width: 100%;
	border-collapse: collapse;
}

.event {
	background-image: linear-gradient(to top, #90ee90 23%, white 23%);
}

.saturday a {
	color: blue;
}

.sunday a {
	color: red;
}

.lesson_classAll {
	background-image: linear-gradient(to top, #BDBDBD 23%, white 23%);
}

.lesson_classA {
	background-image: linear-gradient(to top, red 23%, white 23%);
}

.lesson_classB {
	background-image: linear-gradient(to top, orange 23%, white 23%);
}

.lesson_classC {
	background-image: linear-gradient(to top, yellow 23%, white 23%);
}

.lesson_classD {
	background-image: linear-gradient(to top, green 23%, white 23%);
}

.lesson_classE {
	background-image: linear-gradient(to top, lightgreen 23%, white 23%);
}

.lesson_classF {
	background-image: linear-gradient(to top, blue 23%, white 23%);
}

.lesson_classG {
	background-image: linear-gradient(to top, purple 23%, white 23%);
}

.lesson_classH {
	background-image: linear-gradient(to top, cyan 23%, white 23%);
}
	/* calendar */    
</style>

<script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function() {
	        var progressFill = document.getElementById('progressFill');
	        if (progressFill) {
	            var totalDurationDays = <%= request.getAttribute("total") %>;
	            var passedDurationDays = <%= request.getAttribute("pass") %>;
	            
	            var percentage = (passedDurationDays / totalDurationDays) * 100;
	            
	            progressFill.style.width = percentage + '%';
	            progressFill.textContent = percentage.toFixed(2) + '%';
	        } else {
	            console.error('progressFill element not found!');
	        }
	    });
	</script>
	
	<!-- calendar -->
<%
	List<mCalendarBean> allSchedules = (List<mCalendarBean>) request.getAttribute("allSchedules");
	
	Calendar cal = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));

	cal.add(Calendar.MONTH, -1);
	java.util.Date monthago = cal.getTime();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM", Locale.getDefault());
	String prev_month = sdf.format(monthago);

	cal.add(Calendar.MONTH, +2);
	monthago = cal.getTime();
	sdf = new SimpleDateFormat("yyyy-MM", Locale.getDefault());
	String next_month = sdf.format(monthago);
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var allSchedules = <%= new com.google.gson.Gson().toJson(allSchedules) %>;

    function isDateInRange(date, startDate, endDate) {
        var targetDate = new Date(date);
        return targetDate >= new Date(startDate) && targetDate <= new Date(endDate);
    }

    function isEventStart(date) {
        return allSchedules.some(function(schedule) {
            return new Date(schedule.start_date).toISOString().substring(0, 10) === date;
        });
    }

    function getEventLesson_class(date) {
        var event = allSchedules.find(function(schedule) {
            return isDateInRange(date, schedule.start_date, schedule.fin_date);
        });
        if (event) {
            if (event.lesson_class == 'All') {
                return 'lesson_classAll';
            }
            if (event.lesson_class == 'A') {
                return 'lesson_classA';
            }
            if (event.lesson_class == 'B') {
                return 'lesson_classB';
            }
            if (event.lesson_class == 'C') {
                return 'lesson_classC';
            }
            if (event.lesson_class == 'D') {
                return 'lesson_classD';
            }
            if (event.lesson_class == 'E') {
                return 'lesson_classE';
            }
            if (event.lesson_class == 'F') {
                return 'lesson_classF';
            }
            if (event.lesson_class == 'G') {
                return 'lesson_classG';
            }
            if (event.lesson_class == 'H') {
                return 'lesson_classH';
            }
        }
        return '';
    }

    function hasEventOnDate(date) {
        return allSchedules.some(function(schedule) {
            return isDateInRange(date, schedule.start_date, schedule.fin_date);
        });
    }

    function prevMonth(date) {
        var target = new Date(date);
        target.setDate(1);
        target.setMonth(target.getMonth() - 1);
        return getYmd(target);
    }

    function nextMonth(date) {
        var target = new Date(date);
        target.setDate(1);
        target.setMonth(target.getMonth() + 1);
        return getYmd(target);
    }

    function getYmd(target) {
        var month = ('0' + (target.getMonth() + 1)).slice(-2);
        return [target.getFullYear(), month, '01'].join('-');
    }

    function fullDays(date) {
        var target = new Date(date);
        var year = target.getFullYear();
        var month = target.getMonth();
        var firstWeekDay = new Date(year, month, 1).getDay();
        var thisDays = new Date(year, month + 1, 0).getDate();
        var cell = [28, 35, 42].filter(function(n) {
            return n >= (firstWeekDay + thisDays);
        }).shift();
        var days = [];
        for (var i = 0; i < cell; i++) {
            days[i] = {
                date: '',
                dayNum: '',
                today: false,
                class: ''
            };
        }
        var now = new Date();
        var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        var inDate;
        for (var index = firstWeekDay, i = 1; i <= thisDays; index++, i++) {
            inDate = new Date(year, month, i);
            var dayClass = '';
            if (inDate.getDay() === 0) {
                dayClass = 'sunday';
            } else if (inDate.getDay() === 6) {
                dayClass = 'saturday';
            }
            days[index] = {
                date: i,
                dayNum: inDate.getDay(),
                today: (inDate.getTime() === today.getTime()),
                class: dayClass
            };
        }
        return days;
    }

    function drawMonth(date) {
        $('#month-this').text(date.substring(0, 7).replace('-', '.'));
        $('#month-prev').data('ym', prevMonth(date));
        $('#month-next').data('ym', nextMonth(date));
        $('#tbl-month').empty();
        var td = '<td class="calendar-day __TODAY__ __EVENT__ __CLASS__"><a __HREF__>__DATE__ __EVENT_IMG__</a></td>';
        var href = 'schedule.manager?start_date=' + date.substring(0, 8);
        var week = null;
        var days = fullDays(date);
        for (var i = 0, length = days.length; i < length; i += 7) {
            week = days.slice(i, i + 7);
            var $tr = $('<tr></tr>');
            week.forEach(function(obj, index) {
                if (obj.date) {
                    var dateStr = date.substring(0, 7) + '-' + ('0' + obj.date).slice(-2);
                    var hasEvent = hasEventOnDate(dateStr);
                    var eventStart = isEventStart(dateStr);
                    var eventLesson_class = getEventLesson_class(dateStr);
                    var eventImg = eventStart ? '  <img src="resources/images/attendSymbol3.jpg" style="width:12px; height:12px" />' : '';
                    $tr.append(td.replace('__TODAY__', (obj.today ? 'calendar-today' : ''))
                                .replace('__EVENT__', (hasEvent ? 'event' : ''))
                                .replace('__CLASS__', obj.class + ' ' + eventLesson_class)
                                .replace('__HREF__', 'href="' + href + ('0' + obj.date).slice(-2) + '"')
                                .replace('__DATE__', obj.date)
                                .replace('__EVENT_IMG__', eventImg));
                } else {
                    $tr.append('<td class="calendar-day"></td>');
                }
            });
            $('#tbl-month').append($tr);
        }
    }

    $(function() {
        var date = (new Date()).toISOString().substring(0, 10);
        drawMonth(date);
        $('.month-move').on('click', function(e) {
            e.preventDefault();
            drawMonth($(this).data('ym'));
        });
    });
</script>
	<!-- calendar -->

<!-- header -->
<div class="row">
	    <div class="col-lg-12 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                	
                 	<!-- Progress Section -->
                 	<div class="lecture-container-all">
                 			<div class="left-container">
				               		<div class="lecture-container">
				                     	<font style="padding-left: 20px; margin-top:-20px; font-size: 28px; font-weight: bold; width: 630px; white-space: pre-line; overflow: hidden; text-overflow: ellipsis;">${lecture.lec_name}</font>
			                     		<div class="buttons">
																	<button class="btn-hover color-1" onclick="location.href='classNow.student'">수업시작</button>
															</div>
				                  </div> <br>
				                  <div class="progress-container">
				                      <p style="padding-left: 20px;" align="left">
				                      		<fmt:parseDate var="start" value="${lecture.lec_start}" pattern="yyyy-MM-dd" />
							                    <fmt:parseDate var="end" value="${lecture.lec_end}" pattern="yyyy-MM-dd" />
							                    <span class="lecture-date">
							                    		<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~ 
							                    		<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
							                    </span>
				                      		<span class="lecture-Dday">${remainingDays}일 남았습니다</span>
				                      </p>
				                      <div class="progress-bar" style="width: 100%; margin-left: 20px;" align="center">
				                          <div class="progress" style="width: ${(1 - remainingDays/totalDays) * 100}%;"></div>
				                          <span style="position: absolute; top: 0; left: 50%; transform: translateX(-50%); color: white; font-size: 1em;">${progressPercent}%</span>
				                      </div>
				                  </div>
				              </div>
		                  
			                <div class="right-container">
											    <table width=100% class="table table-hover">
											    		<thead>
													    		<tr>
													    				<th width=50% colspan=2>${lecture.class_name}반</th>
													    				<th width=50% colspan=2>
													    						학생수 ${lecture.student} / ${lecture.stu_cnt} &nbsp;&nbsp;
													    						<button class="btn btn-inverse-secondary btn-sm" onclick="studentDetail(${lecture.lec_num})">학생정보</button>
													    				</th>
													    		</tr>
													    </thead>
													    <tbody>
													    		<tr>
													    				<td width=10%><span class="badge badge-success" style="width:100%">매니저</span></td>
													    				<th width=25%>${lecture.m_name}</th>
													    				<td width=25% align=center><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;${lecture.m_phone}</td>
													    				<td width=50%><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;${lecture.m_email}</td>
													    		</tr>
													    		<tr>
													    				<td><span class="badge badge-success" style="width:100%">강사</span></td>
													    				<th>${lecture.t_name}</th>
													    				<td align=center><i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;${lecture.t_phone}</td>
													    				<td><i class="fa fa-envelope"></i>&nbsp;&nbsp;&nbsp;${lecture.t_email}</td>
													    		</tr>
													    </tbody>
											    </table>
											</div>
											
                  </div>
              </div>
          </div>
      </div>

			<!-- calendar 추가코드 -->
			<div class="col-lg-5 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	            
									<div class="calendar-container">
	
										<div class="date-wrap">
											<div class="date-month">
												<div class="button_wrap">
													<span id="month-this" style="font-size: 27px;"></span> &nbsp;&nbsp;
													<button type="button" id="month-prev" class="month-move">∧</button>
													<button type="button" id="month-next" class="month-move">∨</button>
												</div>
											</div>
											<table class="date-month" border="1">
											    <thead>
											        <tr class="calendar-header">
											            <th>Sun</th>
											            <th>Mon</th>
											            <th>Tue</th>
											            <th>Wed</th>
											            <th>Thu</th>
											            <th>Fri</th>
											            <th>Sat</th>
											        </tr>
											    </thead>
										    <tbody id="tbl-month"></tbody>
										</table>
										<span> 
											<img src="resources/images/attendSymbol3.jpg" style="width: 15px; height: 15px" /> start event<br>
											<img src="resources/images/class.jpg" style="width: 440px; height: 50px" />
										</span>
									</div>	<!-- date-wrap -->
								</div> <!-- calendar-container -->

 							</div>
          </div>
      </div>
      
      <div class="col-lg-7 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	            
                  <div class="notice-container">
										<h4>공지사항</h4>
										<ul class="notice-list">
											<c:forEach var="notice" items="${noticeList}" end="9">
												<li>
													<c:if test="${notice.class_name eq 'All'}">
														<span class="badge badge-secondary">
															전체
														</span>
													</c:if>
													<c:if test="${notice.class_name ne 'All'}">
														<span class="badge badge-info">
															${notice.class_name}반
														</span>
													</c:if>
													
													<span><a href="noticeDetail.manager?n_num=${notice.n_num}">${notice.title}</a></span>
													<span>${notice.day}</span>
												</li>
											</c:forEach>
										</ul>
									</div>
									
			        </div>
			    </div>
			</div>
</div>

	<!-- 학생 상세정보 모달 -->
	<div class="modal fade" id="studentDetailModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="studentDetailModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" style="max-width: 50%;">
	    <div class="modal-content">
     	  <div class="card">
  				<div class="card-body">
			      
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="studentDetailModalLabel" style="color:#c8c8c8; font-weight:bold;">
			        	학생 정보 &nbsp;&nbsp; <span id="modalState"></span>
			        </h1>
			      	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      
			      <div class="modal-body">
			        <div id="member-list">
						    <!-- 회원 정보 영역 -->
						  </div>
			      </div> <br><br>
			      
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			      </div>
															      
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

<%@ include file="studentBottom.jsp"%>

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

</script>
