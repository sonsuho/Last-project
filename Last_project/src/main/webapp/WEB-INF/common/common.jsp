<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- 접속자 아이디 : <%= session.getAttribute("loginInfo")%> <br>
접속자 아아디 : ${sessionScope.loginInfo } <br>
접속자 아아디 : ${loginInfo} <br>

<c:if test="${loginInfo == null}">
	
	<a href="start.jsp">시작페이지</a> 
	<a href="loginForm.member">로그인</a> <br>
	
</c:if>

<c:if test="${loginInfo != null}">
	
	<a href="start.jsp">시작페이지</a> 
	<a href="logout.jsp">로그아웃</a> <br>
	
</c:if>
 --%>