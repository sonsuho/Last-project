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
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${loginInfo.category == 'manager'}">
	<%@include file = "managerBarTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
	<%@include file = "../student/studentTop.jsp"%>
</c:if>


<%
    List<mCalendarBean> allSchedules = (List<mCalendarBean>) request.getAttribute("allSchedules");
%>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    th {
        text-align: center;
        background: #28a745;
        color: #fff;
        padding: 10px;
    }

    td {
        text-align: center;
        background: #fff;
        padding: 10px;
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
        background-image: url('resources/images/today.jpg');
        background-size: 10px 10px;
        background-repeat: no-repeat;
        background-position: top 12px left 32px ;
    }

    .date-wrap {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
        background: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
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
        background: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .button_wrap button:hover {
        background: #0056b3;
    }

    table.date-month {
        width: 100%;
        border-collapse: collapse;
    }

    table.date-month th, table.date-month td {
        width: 14.28%;
    }

    .event {
        background-color: #90ee90;
    }

    .event-start img {
        width: 20px;
        height: 20px;
        margin-left: 5px;
    }

    .saturday a {
        color: blue;
    }

    .sunday a {
        color: red;
    }

    /* CSS styles for different event colors */
    .cal_num1 { background-color: #FFBA85; }
    .cal_num2 { background-color: #9BFF94; } /* Green */
    .cal_num3 { background-color: #368AFF; } /* Blue */
    .cal_num4 { background-color: #FF85CA; } /* Pink */
    .cal_num5 { background-color: #FFB85A; } /* Orange */
    .cal_num6 { background-color: #A2FFFF; } /* Aqua */
    .cal_num7 { background-color: #FF90FF; } /* Magenta */
    .cal_num8 { background-color: #FFFF90; } /* Yellow */
    .cal_num9 { background-color: #FFA2FF; } /* Sky Blue */
    .cal_num10 { background-color: #FFD2FF; } /* Purple */
</style>

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
                    var eventImg = eventStart ? ' <img src="resources/images/attendSymbol_2.jpg" style="width:20px; height:20px" />' : '';
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
<br>
<center>
    <div class="date-wrap">
        <div class="date-month">
            <h2>
                <span id="month-this"><%=request.getParameter("month") %></span>
            </h2>
            <div class="button_wrap">
                <button type="button" id="month-prev" class="month-move" data-ym="<%=prev_month %>+'-01'"> < </button>
                <button type="button" id="month-next" class="month-move" data-ym="<%=next_month %>+'-01'"> > </button>
            </div>
        </div>
        <table class="date-month" border="1">
            <thead>
                <tr>
                    <th>일</th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th>토</th>
                </tr>
            </thead>
            <tbody id="tbl-month"></tbody>
        </table>
        <span>
            <img src="resources/images/today.jpg" style="width:10px; height:10px" /> today <br>
            <img src="resources/images/attendSymbol_2.jpg" style="width:15px; height:15px" /> start event
        </span>
    </div> 
</center>

<%@include file = "managerBarBottom.jsp"%>