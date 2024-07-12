<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>

	<style>
	.err{
		font-size: 9pt;
		color: red;
		font-weight: bold;
	}
	</style>

    lectureUpdateForm.jsp <br>
    
    <h3>강좌수정</h3>
    
    <form:form commandName="lecture" action="lectureUpdate.admin">
    <input type="hidden" name="lec_num" value="${lecture.lec_num}">
    <table border=1>
    	<tr>
    		<th>강좌명</th>
    		<td>
    			<input type="text" name="lec_name" value="${lecture.lec_name}">
    			<form:errors path="lec_name" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th>매니저</th>
    		<td>
    			<select name="manager">
    				<option value="">선택
    				<c:forEach var="manager" items="${managerList}">
    				<option value="${manager.name}" <c:if test="${manager.name eq lecture.manager}">selected</c:if>>${manager.name}
    				</c:forEach>
    			</select>
    			<form:errors path="manager" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th>강사</th>
    		<td>
    			<select name="teacher">
    				<option value="">선택
    				<c:forEach var="teacher" items="${teacherList}">
    				<option value="${teacher.name}" <c:if test="${teacher.name eq lecture.teacher}">selected</c:if>>${teacher.name}
    				</c:forEach>
    			</select>
    			<form:errors path="teacher" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th>기간</th>
    		<td>
    			<input type="date" name="lec_sdate" value="${lec_sdate}"><form:errors path="lec_sdate" cssClass="err" /> ~
    			<input type="date" name="lec_fdate" value="${lec_fdate}"><form:errors path="lec_fdate" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th>학생수</th>
    		<td>
    			<input type="text" name="students" value="${lecture.students}">
    			<form:errors path="students" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th>반이름</th>
    		<td>
    			<input type="text" name="class_name" value="${lecture.class_name}">
    			<form:errors path="class_name" cssClass="err" />
    		</td>
    	</tr>
    	<tr>
    		<th colspan=2>
    			<input type="submit" value="수정하기">
    			<input type="button" value="관리자화면" onclick="location.href='home.admin'">
    		</th>
    	</tr>
    </table>
    </form:form>
    
<%@ include file="adminBarBottom.jsp" %>