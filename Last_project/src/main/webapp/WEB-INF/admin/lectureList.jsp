<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>
	
	<style>
	.form-group {
	  display: flex;
	  align-items: center;
	  margin-right: 1rem;
	}
	
	.form-group .btn,
	.form-group .form-control,
	.form-group .form-select {
	  margin-right: 0.3rem;
	}
	
	.form-select{
	  width: 250px;
	}
	
	th, td{
	  text-align: center;
	}
	
	.form-check-input:checked {
	  background-color: #A566FF;
	  border-color: #A566FF;
	}
	.card-body {
	  min-height: 70vh; /* viewport 높이의 50% */
	}
	</style>
	
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
    
  	<div class="page-header">
    	<h3 class="page-title">강좌목록</h3>
    </div>
    
	<div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	        <div class="row">
	          <div class="col-lg-8">
	            <div class="form-group d-flex align-items-center">
	              <button type="button" onclick="selectDel()" class="btn btn-sm btn-gradient-danger py-3">선택삭제</button>
	              <button type="button" onclick="location.href='lectureInsert.admin?pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'" class="btn btn-sm btn-gradient-success py-3">강좌개설</button>
	            </div>
	          </div>
	          <div class="col-lg-4">
	            <div class="form-group d-flex align-items-center">
	              <form action="lectureList.admin" method="post" class="container d-flex align-items-center">
	                <select name="whatColumn" class="form-select mr-2">
	                  <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체</option>
	                  <option value="lec_name" <c:if test="${param.whatColumn eq 'lec_name'}">selected</c:if>>강좌이름</option>
	                  <option value="manager" <c:if test="${param.whatColumn eq 'manager'}">selected</c:if>>매니저</option>
	                  <option value="teacher" <c:if test="${param.whatColumn eq 'teacher'}">selected</c:if>>강사</option>
	                </select>
	                <input type="text" name="keyword" value="<c:if test="${param.keyword ne 'null'}">${param.keyword}</c:if>" class="form-control mr-2" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                <input type="submit" value="검색" class="btn btn-sm btn-gradient-primary py-3 mr-2">
	                <input type="button" value="전체" onclick="location.href='lectureList.admin'" class="btn btn-sm btn-gradient-primary py-3">
	              </form>
	            </div>
	          </div>
	        </div>
	        <form name="deleteForm" action="lectureDelete.admin" method="post">
	          <input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
	          <input type="hidden" name="whatColumn" value="${param.whatColumn}">
	          <input type="hidden" name="keyword" value="${param.keyword}">
	          <table class="table table-hover">
	            <thead>
	              <tr>
	                <th><input type="checkbox" name="allcheck" onClick="allCheck(this)" class="form-check-input"></th>
	                <th>강좌번호</th>
	                <th>강좌이름</th>
	                <th>매니저</th>
	                <th>강사</th>
	                <th>기간</th>
	                <th>학생수</th>
	                <th>반이름</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach var="lecture" items="${lectureList}">
	                <tr>
	                  <td><input type="checkbox" name="rowcheck" value="${lecture.lec_num}" class="form-check-input"></td>
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
	                  <td>${lecture.class_name}</td>
	                </tr>
	              </c:forEach>
	            </tbody>
	          </table>
	        </form>
	        
         	<center>${pageInfo.pagingHtml}</center>
	      </div>
	    </div>
	  </div>
	</div>

    
<%@ include file="adminBarBottom.jsp" %>