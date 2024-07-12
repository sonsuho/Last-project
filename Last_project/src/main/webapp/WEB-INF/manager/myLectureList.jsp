<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

	<script type="text/javascript">
	function allCheck(obj){
		var rc = document.getElementsByName("rowcheck");
		if(obj.checked){
			for(i=0; i<rc.length; i++){
				rc[i].checked = true;
			}
		} else {
			for(i=0; i<rc.length; i++){
				rc[i].checked = false;
			}
		}
	}
	function selectDel(){
		var rc = document.getElementsByName("rowcheck");
		var flag = false;
		for(i=0; i<rc.length; i++){
			if(rc[i].checked){
				flag = true;
			}
		}
		if(flag){
			deleteForm.submit();
		} else {
			alert('선택된 항목이 없습니다');
		}
	}
	</script>

	<br><a href="home.admin">관리자화면</a>

    <center>
    
    lectureList.jsp <br>
    
    <h3>강좌목록</h3>
    
    <form action="lectureList.admin" method="post">
    	<select name="whatColumn">
    		<option value="all">전체
    		<option value="lec_name">강좌이름
    		<option value="teacher">강사
    		<option value="manager">매니저
    	</select>
    	<input type="text" name="keyword">
    	<input type="submit" value="검색">
    	<input type="button" value="전체보기" onclick="location.href='lectureList.admin'">
    </form>
    
    <form name="deleteForm" action="lectureDelete.admin" method="post">
    <!-- 선택항목삭제 form -->
    <table border=1>
    	<tr>
    		<td colspan=10>
    			<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
				<input type="hidden" name="whatColumn" value="${param.whatColumn}">
				<input type="hidden" name="keyword" value="${param.keyword}">
    			<input type="button" value="선택삭제" style="float: left;" onclick="selectDel()">
    			<input type="button" value="강좌개설" style="float: right;" onclick="location.href='lectureInsert.admin?pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'">
    		</td>
    	</tr>
    	<tr>
    		<th><input type="checkbox" name="allcheck" onClick="allCheck(this)"></th>
    		<th>강좌번호</th>
    		<th>강좌이름</th>
    		<th>매니저</th>
    		<th>강사</th>
    		<th>기간</th>
    		<th>학생수</th>
    		<th>반이름</th>
    		<th>수정</th>
    		<th>삭제</th>
    	</tr>
    	<c:forEach var="lecture" items="${lectureList}">
    	<tr>
    		<td><input type="checkbox" name="rowcheck" value="${lecture.lec_num}"></td>
    		<td>${lecture.lec_num}</td>
    		<td>${lecture.lec_name}</td>
    		<td>${lecture.manager}</td>
    		<td>${lecture.teacher}</td>
    		<td>
    			<fmt:parseDate var="start" value="${lecture.lec_start}" pattern="yyyy-MM-dd" />
    			<fmt:parseDate var="end" value="${lecture.lec_end}" pattern="yyyy-MM-dd" />
    			<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~
    			<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
    		</td>
    		<td>${lecture.stu_cnt}</td>
    		<td>
    			${lecture.class_name}
    		</td>
    		<td><input type="button" value="수정" onclick="location.href='lectureUpdate.admin?lec_num=${lecture.lec_num}'"></td>
    		<td><input type="button" value="삭제" onclick="location.href='lectureDelete.admin?lec_num=${lecture.lec_num}'"></td>
    	</tr>
    	</c:forEach>
    </table>
    </form>
    
    ${pageInfo.pagingHtml}
    
    </center>
    