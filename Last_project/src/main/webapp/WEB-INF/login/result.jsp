<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

	<br>result.jsp<br>
	
	${loginInfo.name}
	${loginInfo.category}
	
	<c:choose>
	    <c:when test="${loginInfo.category == 'admin'}">
	        <c:redirect url="home.admin"/>
	    </c:when>
	    
	    <c:when test="${loginInfo.category == 'manager'}">
	        <c:redirect url="home.manager"/>
	    </c:when>
	    
	    <c:when test="${loginInfo.category == 'teacher'}">
	        <c:redirect url="home.teacher"/>
	    </c:when>
	    
	    <c:when test="${loginInfo.category == 'student'}">
	        <c:redirect url="home.student"/>
	    </c:when>
	</c:choose>