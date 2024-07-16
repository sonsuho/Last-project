<!-- 추가 -->
<%@page import="manager.model.mCalendarBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.SimpleTimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<!-- 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>

<style>

.progress-container {
	text-align: center;
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

.notice-container {
	position: absolute;
	left : 900px;
	width: 700px;
	height: 565px;
	background: #fff;
	border-radius: 8px;
	padding: 20px;
	margin: 20px auto;
}

.notice-container h4 {
	margin-bottom: 20px;
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

.badge-general {
	background: #6c757d;
}

.badge-important {
	background: #007bff;
}

/* calendar */
th {
	text-align: center;
	background: #28a745;
	color: #fff;
	padding: 10px;
}

td {
	text-align: center;
	background: #fff;
	padding: 0px 1px 15px;
	border: 1px solid #dee2e6;
	
}

td a {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 10px;
	color: #000;
	text-decoration: none;
}

td.today {
	position: relative;
}

td.today a {
	position: relative;
	z-index: 1;
}

td.today::before {
	content: '';
	position: absolute;
	top: 40%;
	left: 50%;
	width: 42px;
	height: 42px;
	background: #FFFFFF;
	border: 1px solid #0000C9;
	border-radius: 50%;
	transform: translate(-50%, -50%);
	z-index: 0;
}

.date-wrap {
	font-family: Comic Sans MS, serif;
	width: 480px;
	height: 565px;
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
	text-align: center;
	margin-top: 10px;
}

.button_wrap button {
            padding: 10px 20px;
            margin: 0 5px;
            font-size: 16px;
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

/* CSS styles for different event colors */
.cal_num1 {
	background-image: linear-gradient(to top, #FFBA85 23%, white 23%);
}

.cal_num2 {
	background-image: linear-gradient(to top, #9BFF94 23%, white 23%);
}
.cal_num3 {
	background-image: linear-gradient(to top, #368AFF 23%, white 23%);
}
.cal_num4 {
	background-image: linear-gradient(to top, #FF85CA 23%, white 23%);
}
.cal_num5 {
	background-image: linear-gradient(to top, #FFB85A 23%, white 23%);
}
.cal_num6 {
	background-image: linear-gradient(to top, #A2FFFF 23%, white 23%);
}
.cal_num7 {
	background-image: linear-gradient(to top, #FF90FF 23%, white 23%);
}
.cal_num8 {
	background-image: linear-gradient(to top, #FFFF90 23%, white 23%);
}
.cal_num9 {
	background-image: linear-gradient(to top, #FFA2FF 23%, white 23%);
}
.cal_num10 {
	background-image: linear-gradient(to top, #FFD2FF 23%, white 23%);
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
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var allSchedules = <%=new com.google.gson.Gson().toJson(allSchedules)%>;
			
function isDateInRange(date, startDate, endDate) {
	var targetDate = new Date(date);
	return targetDate >= new Date(startDate) && targetDate <= new Date(endDate);
}
			
function isEventStart(date) {
	return allSchedules.some(function(schedule) {
		return new Date(schedule.start_date).toISOString().substring(0, 10) === date;
	});
}
			
function getEventCalNum(date) {
	var event = allSchedules.find(function(schedule) {
		return isDateInRange(date, schedule.start_date, schedule.fin_date);
	});
	return event ? 'cal_num' + (event.cal_num % 10 + 1) : '';
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
	var td = '<td class="__TODAY__ __EVENT__ __CLASS__"><a __HREF__>__DATE__ __EVENT_IMG__</a></td>';
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
			    var eventCalNum = getEventCalNum(dateStr);
			    var eventImg = eventStart ? ' <img src="resources/images/attendSymbol3.jpg" style="width:12px; height:12px; margin-left: 1px;" />' : '';
			    $tr.append(td.replace('__TODAY__', (obj.today ? 'today' : ''))
			                                    .replace('__EVENT__', (hasEvent ? 'event' : ''))
			                                    .replace('__CLASS__', obj.class + ' ' + eventCalNum)
			                                    .replace('__HREF__', 'href="' + href + ('0' + obj.date).slice(-2) + '"')
			                                    .replace('__DATE__', obj.date)
			                                    .replace('__EVENT_IMG__', eventImg));
			} else {
				$tr.append('<td></td>');
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

<%
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
	<!-- calendar -->

<!-- header -->
<div class="page-header">
	<h3 class="page-title">
		<span class="page-title-icon bg-gradient-primary text-white me-2">
			<i class="mdi mdi-home"></i>
		</span> Student Home
	</h3>
	<nav aria-label="breadcrumb">
		<ul class="breadcrumb">
			<li class="breadcrumb-item active" aria-current="page"><span></span>Overview
				<i
				class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
			</li>
		</ul>
	</nav>
</div>


<!-- Progress Section -->
<div class="element1">
	<div class="progress-container">
		<h1 style="padding-left: 50px;" align="left">강의 진행 현황</h1>
		<br>
		<p style="padding-left: 80px;" align="left">
			<font size="6">D-${remainingDays}</font>
		</p>
		<div class="progress-bar" style="width: 90%; margin-left: 60px;"
			align="center">
			<div class="progress"
				style="width: ${(1 - remainingDays/totalDays) * 100}%;"></div>
		</div>
		<p style="padding-left: 80px;" align="left">남은 강의 시간: 최소 62h 10m</p>
		<p style="padding-left: 80px;" align="left">앞으로 매일 평균: 최소 7h 10m</p>
	</div>
</div>
<br>
<br>
<div>
	<a href="request.student">요청 페이지</a>
	<br>
	<a href="rlist.messenger">메신저 페이지</a>
	<br>
</div>

<br><br>

<div class="date-wrap">
	<div class="date-month">
		<h2>
			<span id="month-this"></span>
		</h2>
		<div class="button_wrap">
			<button type="button" id="month-prev" class="month-move"><</button>
			<button type="button" id="month-next" class="month-move">></button>
		</div>
	</div>
	<table class="date-month" border="1">
		<thead>
			<tr>
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
	<span> <img src="resources/images/attendSymbol3.jpg" style="width: 15px; height: 15px" /> start event
	</span>
</div>
<!-- calendar 추가코드 -->

<div class="notice-container">
	<h4>공지사항</h4>
	<ul class="notice-list">
		<li><span class="badge badge-general">전체</span> <span>쌍용강북센터
				휴가 안내</span> <span>2024-06-28</span></li>
		<li><span class="badge badge-important">우리반</span> <span>MySQL
				과제 리스트 안내</span> <span>2024-06-24</span></li>
		<li><span class="badge badge-important">우리반</span> <span>Spring
				설치 방법</span> <span>2024-06-24</span></li>
	</ul>
</div>

<%@ include file="studentBottom.jsp"%>