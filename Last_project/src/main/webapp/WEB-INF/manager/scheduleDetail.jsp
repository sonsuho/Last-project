<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${loginInfo.category == 'manager'}">
	<%@include file = "managerBarTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
	<%@include file = "../student/studentTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
	<%@include file = "../teacher/teacherTop.jsp"%>
</c:if>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
    }
    
    a {
        color: #007bff;
        text-decoration: none;
    }
    
    .insertS{
    	color : white;
    }

    a:hover {
        text-decoration: underline;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    th, td {
        padding: 10px;
        text-align: center;
        border: 1px solid #dee2e6;
    }

    th {
        background-color: #007bff;
        color: white;
    }
    
    td {
        background-color: #f8f9fa;
    }

    td a {
        color: #007bff;
        text-decoration: none;
    }

    td a:hover {
        text-decoration: underline;
    }

    input[type="button"] {
        padding: 5px 10px;
        margin: 5px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    input[type="button"]:hover {
        background-color: #0056b3;
    }

    .button {
        display: inline-block;
        padding: 10px 20px;
        margin: 20px auto;
        background-color: #007bff;
        color: white;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .button:hover {
        background-color: #0056b3;
    }
</style>

<script>
    function deleteSchedule(start_date, cal_num, name, loginName, category) {
        if (category != 'manager') {
            alert("일정을 삭제할 수 있는 권한이 없습니다.");
            location.href = "schedule.manager?start_date=" + start_date;
        } else {
            if (name.includes(loginName) || name.includes('공용')) {
                if (confirm("정말 해당 일정을 삭제하시겠습니까?")) {
                    location.href = "scheduleDelete.manager?start_date=" + start_date + "&cal_num=" + cal_num;
                } else {
                    alert("해당 일정이 삭제처리 되지 않았습니다.");
                }
            } else {
                alert("일정을 삭제할 수 있는 권한이 없습니다.");
                location.href = "schedule.manager?start_date=" + start_date;
            }
        }
    }

    function updateSchedule(start_date, cal_num, name, loginName, category) {
        if (category != 'manager') {
            alert("일정을 수정할 수 있는 권한이 없습니다.");
            location.href = "schedule.manager?start_date=" + start_date;
        } else {
            if (name.includes(loginName) || name.includes('공용')) {
                if (confirm("정말 해당 일정을 수정하시겠습니까?")) {
                    location.href = "scheduleUpdate.manager?start_date=" + start_date + "&cal_num=" + cal_num + "&name=" + name;
                } else {
                    alert("해당 일정이 수정처리 되지 않았습니다.");
                }
            } else {
                alert("일정을 수정할 수 있는 권한이 없습니다.");
                location.href = "schedule.manager?start_date=" + start_date;
            }
        }
    }
</script>

<%
    String start_date = request.getParameter("start_date");
    StringBuffer dateBuffer = new StringBuffer(start_date);
    StringBuffer month = dateBuffer.delete(7, 11);
%>

<!-- header -->
<div class="page-header">
   <h3 class="page-title" style="font-weight: 700;"><%=start_date %> 일정 목록</h3>
   <nav>
   		<c:if test="${loginInfo.category == 'manager'}">
			<a href="home.manager" class="button">뒤로 돌아가기</a>
		</c:if>
		
		<c:if test="${loginInfo.category == 'student'}">
			<a href="home.student" class="button">뒤로 돌아가기</a>
		</c:if>
		
		<c:if test="${loginInfo.category == 'teacher'}">
			<a href="home.teacher" class="button">뒤로 돌아가기</a>
		</c:if>
   </nav>
</div>

<div class="row">
   <div class="col-lg-12 grid-margin stretch-card">
      <div class="card">
         <div class="card-body">
<br><br>

<c:if test="${loginInfo.category != 'manager'}">

    <c:if test="${calendarLists eq '[]'}">
        <center>일정없음.</center>
    </c:if>

    <c:if test="${calendarLists ne '[]'}">
        <center>
            <table>
                <tr>
                	<th>작성자</th>
                    <th>반</th>
                    <th>제목</th>
                    <th>시작날짜</th>
                    <th>종료날짜</th>
                    <c:if test="${loginInfo.category == 'manager'}">
                        <th>수정</th>
                        <th>삭제</th>
                    </c:if>
                </tr>

                <c:forEach var="calendar" items="${calendarLists}" varStatus="status">
                    <tr>
                        <td>
                            <c:if test="${fn:contains(calendar.name, '공용')}">
                                [공용] ${calendar.name}
                            </c:if>
                            <c:if test="${not fn:contains(calendar.name, '공용')}">
                                ${calendar.name}
                            </c:if>
                        </td>
                        <td>${calendar.lesson_class}</td>
                        <td>
                            <a href="scheduleView.manager?start_date=<%= request.getParameter("start_date")%>&cal_num=${calendar.cal_num}">${calendar.title}</a>
                        </td>
                        <td>${calendar.start_date}</td>
                        <td>${calendar.fin_date}</td>

                        <c:if test="${loginInfo.category == 'manager'}">
                            <td>
                                <input type="button" value="일정 수정" onclick="updateSchedule('<%= request.getParameter("start_date")%>', '${calendar.cal_num}', '${calendar.name}', '${loginInfo.name}', '${loginInfo.category}')">
                            </td>
                            <td>
                                <input type="button" value="일정 삭제" onclick="deleteSchedule('<%= request.getParameter("start_date")%>', '${calendar.cal_num}', '${calendar.name}', '${loginInfo.name}', '${loginInfo.category}')">
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </center>
    </c:if>
</c:if>

<c:if test="${loginInfo.category == 'manager'}">
    <c:if test="${calendarLists eq '[]'}">
        <table>
            <tr>
                <th>
                    <a class="insertS" href="scheduleInsert.manager?start_date=<%= request.getParameter("start_date")%>">일정 추가</a>
                </th>
            </tr>
        </table>
    </c:if>

    <c:if test="${calendarLists ne '[]'}">
        <table>
            <tr>
                <th><a class="insertS" href="scheduleInsert.manager?start_date=<%= request.getParameter("start_date")%>">일정 추가</a></th>
            </tr>
        </table>

        <center>
            <table>
                <tr>
                    <th>번호</th>
                    <th>회원번호</th>
                    <th>반</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>시작날짜</th>
                    <th>종료날짜</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>

                <c:forEach var="calendar" items="${calendarLists}" varStatus="status">
                    <tr>
                        <td>${calendar.cal_num}</td>
                        <td>${calendar.mem_num}</td>
                        <td>${calendar.lesson_class}</td>
                        <td>
                            <c:if test="${fn:contains(calendar.name, '공용')}">
                                [공용] ${calendar.name}
                            </c:if>
                            <c:if test="${not fn:contains(calendar.name, '공용')}">
                                ${calendar.name}
                            </c:if>
                        </td>
                        <td>
                            <a href="scheduleView.manager?start_date=<%= request.getParameter("start_date")%>&cal_num=${calendar.cal_num}">${calendar.title}</a>
                        </td>
                        <td>${calendar.start_date}</td>
                        <td>${calendar.fin_date}</td>
                        <td>
                            <input type="button" value="일정 수정" onclick="updateSchedule('<%= request.getParameter("start_date")%>', '${calendar.cal_num}', '${calendar.name}', '${loginInfo.name}', '${loginInfo.category}')">
                        </td>
                        <td>
                            <input type="button" value="일정 삭제" onclick="deleteSchedule('<%= request.getParameter("start_date")%>', '${calendar.cal_num}', '${calendar.name}', '${loginInfo.name}', '${loginInfo.category}')">
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </center>
    </c:if>
</c:if>

         </div>
      </div>
   </div>
</div>

<c:if test="${loginInfo.category == 'manager'}">
	<%@include file = "managerBarBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
	<%@include file = "../student/studentBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
	<%@include file = "../teacher/teacherBottom.jsp"%>
</c:if>
