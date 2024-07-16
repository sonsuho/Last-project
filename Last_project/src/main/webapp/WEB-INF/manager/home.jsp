<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "managerBarTop.jsp"%>

<%
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	LocalDate now = LocalDate.now();
	String now_month = now.format(formatter);
%>

 	<div class="page-header">
    <h3 class="page-title">
      <span class="page-title-icon bg-gradient-primary text-white me-2">
        <i class="mdi mdi-home"></i>
      </span> 
      ManagerMain
      
      <br><br>
      
      <a href="request.manager">승인 결재</a><br>
			<a href="Messenger.manager">메신저 페이지</a><br>
			<a href="etc.manager">학생에게 서류 요청하기</a><br>
			<a href="notifications.manager">알림</a><br>
			<a href="lectureList.manager">내 수업 정보</a><br>
	    <a href="stuList.manager">내 학생 정보</a><br>
	    <a href="IdInsert.manager">학생 아이디 생성</a><br>
	<a href="lectureEval.manager">강의 평가 조사</a><br>				<!-- 시험을 클릭하면 TestListController로 가서 -->
	<a href="calendar.manager?month=<%=now_month%>">학원일정</a>
    </h3>
  </div>

<%@ include file = "managerBarBottom.jsp"%>