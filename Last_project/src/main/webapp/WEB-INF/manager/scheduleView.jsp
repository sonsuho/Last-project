<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${loginInfo.category == 'manager'}">
	<%@include file = "managerBarTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
	<%@include file = "../student/studentTop.jsp"%>
</c:if>


<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
    }

    table {
        width: 70%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        text-align: center;
        border: 1px solid #dee2e6;
    }

    th {
        background-color: #FFD1FF;
        color: #333;
        font-weight: bold;
    }

    td {
        background-color: #FFBFFF;
        color: #333;
    }

    textarea {
        width: 100%;
        background: white;
        text-align: left;
        padding: 10px;
        border: 1px solid #dee2e6;
        border-radius: 4px;
        resize: none;
    }

    .back-button {
        display: inline-block;
        padding: 10px 20px;
        margin: 20px auto;
        background-color: #FFD1FF;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .back-button:hover {
        background-color: #ffb3ff;
    }

    .back-button:focus {
        outline: none;
        box-shadow: 0 0 0 4px rgba(255, 209, 255, 0.5);
    }
</style>

<table>
    <tr>
        <th>번호</th>
        <td>${calendar.cal_num}</td>
        <th>소속반</th>
        <td>${calendar.lesson_class}</td>
    </tr>
    <tr>
        <th>신청자</th>
        <td>${calendar.name}</td>
        <th>일정제목</th>
        <td>${calendar.title}</td>
    </tr>
    <tr>
        <th>시작날짜</th>
        <td>${calendar.start_date}</td>
        <th>종료날짜</th>
        <td>${calendar.fin_date}</td>
    </tr>
    <tr>
        <th>내용</th>
        <td colspan="3">
            <textarea cols="80" rows="15" disabled>${calendar.content}</textarea>
        </td>
    </tr>
    <tr>
        <th colspan="4">
            <a href="schedule.manager?start_date=<%= request.getParameter("start_date")%>" class="back-button">이전으로 돌아가기</a>
        </th>
    </tr>
</table>


<c:if test="${loginInfo.category == 'manager'}">
	<%@include file = "managerBarBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
	<%@include file = "../student/studentBottom.jsp"%>
</c:if>

