<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>

	<div class="page-header">
  	<h3 class="page-title">강좌수정</h3>
  </div>
    
   <form action="lectureUpdate.admin" method="post">
   <input type="hidden" name="lec_num" value="${lecture.lec_num}">
   <table border=1>
   	<tr>
   		<th>강좌명</th>
   		<td>
   			<input type="text" name="lec_name" value="${lecture.lec_name}">
   		</td>
   	</tr>
   	<tr>
   		<th>매니저</th>
   		<td>
   			<select name="manager">
   				<option value="">선택
   				<c:forEach var="manager" items="${managerList}">
   				<option value="${manager.mem_num}" <c:if test="${manager.mem_num eq lecture.manager}">selected</c:if>>${manager.name}
   				</c:forEach>
   			</select>
   		</td>
   	</tr>
   	<tr>
   		<th>강사</th>
   		<td>
   			<select name="teacher">
   				<option value="">선택
   				<c:forEach var="teacher" items="${teacherList}">
   				<option value="${teacher.mem_num}" <c:if test="${teacher.mem_num eq lecture.teacher}">selected</c:if>>${teacher.name}
   				</c:forEach>
   			</select>
   		</td>
   	</tr>
   	<tr>
   		<th>기간</th>
   		<td>
   			<input type="date" name="lec_start" value="${lecture.lec_start}"> ~ 
   			<input type="date" name="lec_end" value="${lecture.lec_end}">
   		</td>
   	</tr>
   	<tr>
   		<th>학생수</th>
   		<td>
   			<input type="text" name="students" value="${lecture.stu_cnt}">
   		</td>
   	</tr>
   	<tr>
   		<th>반이름</th>
   		<td>
   			<input type="text" name="class_name" value="${lecture.class_name}">
   		</td>
   	</tr>
   	<tr>
   		<th colspan=2>
   			<input type="submit" value="수정하기">
   			<input type="button" value="돌아가기" onclick="location.href='lectureList.admin'">
   		</th>
   	</tr>
   </table>
   </form>
    
<%@ include file="adminBarBottom.jsp" %>