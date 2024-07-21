<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "managerBarTop.jsp"%>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
    }

    h2 {
        color: #333;
        text-align: center;
        margin-bottom: 20px;
    }

    .form-container {
        width: 60%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }

    th {
        background-color: #f1f1f1;
        font-weight: bold;
        text-align: center;
    }

    td input[type="text"],
    td input[type="date"],
    td textarea,
    td select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .form-errors {
        color: red;
        font-size: 12px;
        margin-top: 5px;
    }

    .submit-btn {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-align: center;
        font-size: 16px;
    }

    .submit-btn:hover {
        background-color: #0056b3;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
        color: #007bff;
        text-decoration: none;
    }

    .back-link:hover {
        text-decoration: underline;
    }
</style>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var startDateInput = document.getElementById('start_date');
		var finDateInput = document.getElementById('fin_date');

		// 시작 날짜의 값으로 종료 날짜의 최소값 설정
		var startDateValue = startDateInput.value;
		if (startDateValue) {
			finDateInput.min = startDateValue;
		}
	});
</script>


<%
    String[] group = {"A", "B", "C", "D", "E", "F", "G", "H"};
%>

<div class="form-container">
    <h2>일정 수정하기</h2>
    <form:form id="scheduleUpdateForm" commandName="calendar" action="scheduleUpdate.manager" method="post">
        <table>
            <tr>
                <th>일정 작성자</th>
                <td>
                    <input type="hidden" name="cal_num" value="${calendar.cal_num}">
                    <input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
                    <input type="text" name="name" value="<%= request.getParameter("name") %>" disabled>
                    <input type="hidden" name="name" value="<%= request.getParameter("name") %>">
                </td>
            </tr>

            <tr>
                <th>소속반</th>
                <td>
                    <select name="lesson_class">
                        <option value="">소속반을 선택하세요</option>
                        <c:set var="gList" value="<%= group %>"/>
                        <c:forEach var="i" begin="0" end="${fn:length(gList) - 1}">
                            <option value="${gList[i]}" 
                                <c:if test="${calendar.lesson_class eq gList[i]}">selected</c:if>>
                                ${gList[i]}
                            </option>
                        </c:forEach>
                    </select>
                    <form:errors path="lesson_class" cssClass="form-errors" />
                </td>
            </tr>

            <tr>
                <th>일정제목</th>
                <td>
                    <input type="text" name="title" value="${calendar.title}">
                    <form:errors path="title" cssClass="form-errors" />
                </td>
            </tr>

            <tr>
                <th>일정내용</th>
                <td>
                    <textarea name="content" cols="50" rows="8">${calendar.content}</textarea>
                    <form:errors path="content" cssClass="form-errors" />
                </td>
            </tr>

            <tr>
                <th>시작날짜</th>
                <td>
                    <input type="text"  id="start_date" name="start_date" value="${calendar.start_date}" disabled>
                    <input type="hidden" name="start_date" value="<%= request.getParameter("start_date") %>">
                </td>
            </tr>

            <tr>
                <th>종료날짜</th>
                <td>
                    <input type="date" id="fin_date" name="fin_date" value="${calendar.fin_date}">
                    <form:errors path="fin_date" cssClass="form-errors" />
                </td>
            </tr>

            <tr>
                <th>수정자</th>
                <td>
                    <input type="text" name="name" value="${loginInfo.name}" disabled>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="submit" value="일정수정하기" class="submit-btn">
                </td>
            </tr>
        </table>
    </form:form>
</div>

<a href="schedule.manager?start_date=<%= request.getParameter("start_date") %>" class="back-link">이전으로 돌아가기</a>

<%@include file = "managerBarBottom.jsp"%>
