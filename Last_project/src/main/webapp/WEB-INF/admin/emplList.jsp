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
	
	.modal-dialog {
	  max-width: 35%; /* 모달의 최대 너비를 화면의 35%로 설정 */
	  margin: 1.75rem auto;
	}
	</style>

  	<div class="page-header">
    	<h3 class="page-title">회원목록</h3>
    </div>
    
	<div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	        <div class="row">
	          <div class="col-lg-8">
	            <div class="form-group d-flex align-items-center">
	              <button type="button" onclick="selectDel()" class="btn btn-sm btn-gradient-danger py-3">선택삭제</button>
	              <button type="button" onclick="location.href='idInsert.admin?pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'" class="btn btn-sm btn-gradient-success py-3">회원생성</button>
	            </div>
	          </div>
	          <div class="col-lg-4">
	            <div class="form-group d-flex align-items-center">
	              <form action="emplList.admin" method="post" class="container d-flex align-items-center">
	                <select name="whatColumn" class="form-select mr-2">
	                  <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체</option>
	                  <option value="name" <c:if test="${param.whatColumn eq 'name'}">selected</c:if>>이름</option>
            		  <option value="id" <c:if test="${param.whatColumn eq 'id'}">selected</c:if>>아이디</option>
	                </select>
	                <input type="text" name="keyword" value="<c:if test="${param.keyword ne 'null'}">${param.keyword}</c:if>" class="form-control mr-2" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                <input type="submit" value="검색" class="btn btn-sm btn-gradient-primary py-3 mr-2">
	                <input type="button" value="전체" onclick="location.href='emplList.admin'" class="btn btn-sm btn-gradient-primary py-3">
	              </form>
	            </div>
	          </div>
	        </div>
	        <form name="deleteForm" action="idDelete.admin" method="post">
	          <input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
	          <input type="hidden" name="whatColumn" value="${param.whatColumn}">
	          <input type="hidden" name="keyword" value="${param.keyword}">
	          <table class="table table-hover">
	            <thead>
	              <tr>
	                <th><input type="checkbox" name="allcheck" onClick="allCheck(this)" class="form-check-input"></th>
	                <th>회원번호</th>
	                <th>이름</th>
	                <th>아이디</th>
	                <th>성별</th>
	                <th>나이</th>
	                <th>카테고리</th>
	                <th>전화번호</th>
	                <th>이메일</th>
	                <th>상태</th>
		          </tr>
	            </thead>
	            <tbody>
	              <c:forEach var="empl" items="${emplList}">
	                <tr data-bs-target="#staticBackdrop" data-mem-num="${empl.mem_num}">
	                  <td><input type="checkbox" name="rowcheck" value="${empl.mem_num}" class="form-check-input"></td>
	                  <td>${empl.mem_num}</td>
                    <td>${empl.name}</td>
                    <td>${empl.id}</td>
                    <td>${empl.gender}</td>
                    <td>
                    	<fmt:parseDate var="birth" value="${empl.birth}" pattern="yyyy-MM-dd" />
                    	<c:set var="currentDate" value="<%=new java.util.Date()%>" />
											<fmt:formatDate value="${currentDate}" pattern="yyyy" var="currentYear" />
											<fmt:formatDate value="${birth}" pattern="yyyy" var="birthYear" />
											<c:set var="age" value="${currentYear - birthYear}" />
											<c:if test="${currentDate.month < birth.month || ((currentDate.month == birth.month) && (currentDate.date < birth.date))}">
											    <c:set var="age" value="${age - 1}" />
											</c:if>
											${age}
                    </td>
                    <td>
	                   	<c:if test="${empl.category eq 'manager'}">매니저</c:if>
	                   	<c:if test="${empl.category eq 'teacher'}">강사</c:if>
                    </td>
                    <td>${empl.phone}</td>
                    <td>${empl.email}</td>
                    <td><label class="badge badge-<c:if test="${empl.state eq '근무'}">info</c:if>">${empl.state}</label></td>
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
	
	<script type="text/javascript">
    function allCheck(obj) {
        var rc = document.getElementsByName("rowcheck");
        for (var i = 0; i < rc.length; i++) {
            rc[i].checked = obj.checked;
        }
    }

    function selectDel() {
        var rc = document.getElementsByName("rowcheck");
        var flag = false;
        for (var i = 0; i < rc.length; i++) {
            if (rc[i].checked) {
                flag = true;
            }
        }
        if (flag) {
            document.deleteForm.submit();
        } else {
            alert('선택된 항목이 없습니다');
        }
    }
	</script>

<%@ include file="adminBarBottom.jsp" %>
