<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
    a {
        text-decoration: none;
        color: #007bff;
    }
    .page-header {
        padding: 20px 0;
        margin: 0;
        border-bottom: 1px solid #e9ecef;
    }
    .page-title {
        font-size: 24px;
        color: #343a40;
    }
    .cf {
        font-size: 14px;
        color: red;
        float: right;
        margin-right: 10%;
    }
    .name {
        color: #007bff;
    }
    table {
        width: 70%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
    }
    table th, table td {
        padding: 10px;
        border: 1px solid #dee2e6;
        text-align: center;
    }
    table th {
        background-color: #343a40;
        color: #fff;
    }
    table tbody tr:nth-child(odd) {
        background-color: #f8f9fa;
    }
    table tbody tr:hover {
        background-color: #e9ecef;
    }
</style>

<!-- header -->
<div class="page-header">
   <h3 class="page-title" style="font-weight: 700;">내 근퇴 현황</h3>
</div>

<div class="row">
   <div class="col-lg-12 grid-margin stretch-card">
      <div class="card">
         <div class="card-body">
<br><br>
	<h3 style="text-align: center">회원 이름 : <a class="name">${loginInfo.name}</a></h3>

<span class="cf">특정날짜를 찾으려면 Ctrl + F를 눌러 찾으세요.</span><br><br>
 
    <table>
        <thead>
            <tr>
                <th>날짜</th>
                <th>출석시간</th>
                <th>퇴실시간</th>
                <th>출결상태</th>
                <th>비고</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="attend" items="${attendLists}" varStatus="status">
                <c:set var="dateStr" value="${attend.day}" />
                <fmt:parseDate value="${dateStr}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss.S" />
                <fmt:formatDate value="${parsedDate}" var="formattedDate" pattern="yyyy-MM-dd" />
                <c:set var="day" value="${formattedDate}" />
                <tr>
                    <td>${day}</td>
                    <td><fmt:formatDate value="${attend.att_sdate}" pattern="kk:mm:ss"/></td>
                    <td><fmt:formatDate value="${attend.att_fdate}" pattern="kk:mm:ss"/></td>
                    <td>${attend.situ}</td>
                    <td></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
         </div>
      </div>
   </div>
</div>

<%@ include file = "studentBottom.jsp"%>
위의 스타일링은 다음과 같은 변화를 포함합니다: