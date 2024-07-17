<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "managerBarTop.jsp"%>

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
   <h3 class="page-title" style="font-weight: 700;">내 휴가 내역</h3>
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
                <th>시작날짜</th>
                <th>마감날짜</th>  
                <th>요청사유</th>
                <th>승인여부</th>
                <th>결재일자</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="vacation" items="${vacationLists}" varStatus="status">

            	<c:set var="time1" value="${vacation.time1}" />
                <fmt:parseDate value="${time1}" var="parsedDate" pattern="yyyy-MM-dd HH:mm" />
                <fmt:formatDate value="${parsedDate}" var="formattedDate" pattern="yyyy-MM-dd" />
                <c:set var="startDay" value="${formattedDate}" />

                <c:set var="time2" value="${vacation.time2}" />
                <fmt:parseDate value="${time2}" var="parsedDate2" pattern="yyyy-MM-dd HH:mm" />
                <fmt:formatDate value="${parsedDate2}" var="formattedDate2" pattern="yyyy-MM-dd" />
                <c:set var="finDay" value="${formattedDate2}" />

                <tr>
                    <td>${startDay}</td>
                    <td>${finDay}</td>
                    <td>${vacation.reason}</td>
                    <td>${vacation.ap_situ}</td>
                    <td>${vacation.ap_date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
         </div>
      </div>
   </div>
</div>

<%@ include file = "managerBarBottom.jsp"%>