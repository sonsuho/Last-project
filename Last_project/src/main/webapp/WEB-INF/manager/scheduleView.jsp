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
        background-color: #6c757d;
        color: white;
        font-weight: bold;
    }

    td {
        background-color: #e9ecef;
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
        font-family: Arial, sans-serif;
        font-size: 14px;
    }

    .back-button {
        display: inline-block;
        padding: 10px 20px;
        margin: 20px auto;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        text-align: center;
    }

    .back-button:hover {
        background-color: #0056b3;
    }

    .back-button:focus {
        outline: none;
        box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.5);
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .page-title {
        margin: 0;
    }

    nav {
        margin: 0;
    }
</style>

<!-- header -->
<div class="page-header">
   <h3 class="page-title" style="font-weight: 700;">일정 확인</h3>
   <nav>
      <a href="schedule.manager?start_date=<%=request.getParameter("start_date")%>" class="back-button">이전으로 돌아가기</a>
   </nav>
</div>

<div class="row">
   <div class="col-lg-12 grid-margin stretch-card">
      <div class="card">
         <div class="card-body">

            <table>
               <tr>
                  <th style="width : 150px;">일정제목</th>
                  <td colspan="3">${calendar.title}</td>
               </tr>
               <tr>
                  <th>소속반</th>
                  <td>${calendar.lesson_class}</td>
                  <th>작성자</th>
                  <td>${calendar.name}</td>
               </tr>
               <tr>
                  <th>시작날짜</th>
                  <td>${calendar.start_date}</td>
                  <th>종료날짜</th>
                  <td>${calendar.fin_date}</td>
               </tr>
               <tr>
                  <th>내용</th>
                  <td colspan="3"><textarea cols="80" rows="15" disabled>${calendar.content}</textarea>
                  </td>
               </tr>
            </table>

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