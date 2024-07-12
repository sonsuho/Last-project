<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>
<script>
	function etcList(mem_num) {
		location.href = "etcList.student?mem_num=" + mem_num;
	}
	function etcSendList(sender_num) {
		location.href = "etcSendList.student?sender_num=" + sender_num;
	}

	function requestList2(mem_num) {
		location.href = "request2.student?mem_num=" + mem_num;
	}

	function allDelete(obj) {
		var rcheck = document.getElementsByName("rowcheck");
		var check = obj.checked;
		for (var i = 0; i < rcheck.length; i++) {
			rcheck[i].checked = check;
		}
	}

	function selectDelete() {
		var rcheck = document.getElementsByName("rowcheck");
		var flag = false;
		for (var i = 0; i < rcheck.length; i++) {
			if (rcheck[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("삭제할 문서를 선택하세요");
			return;
		}
		document.myform.submit();
	}
</script>

		<div class="page-header">
			<h3 class="page-title">내(학생) 문서함</h3>
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="request.student">휴가.조퇴신청</a></li>
					<li class="breadcrumb-item active" aria-current="page"><a href="etc.student">기타 서류 작성하기</a></li>
				</ol>
			</nav>
		</div>
		<div class="col-lg-8 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<input class="btn btn-gradient-light btn-rounded btn-fw" type="button" value="받은 문서" onclick="etcList('${loginInfo.mem_num}')"> 
					<input class="btn btn-gradient-light btn-rounded btn-fw" type="button" value="내가 쓴 문서" onclick="etcSendList('${sender_num}')"> 
					<input class="btn btn-gradient-light btn-rounded btn-fw" type="button" value="결재 문서" onclick="requestList2('${sender_num}')">
					<p class="card-description">
					</p>
					<form method="post" name="myform" action="selectDeleteEtc.student">
						<table class="table table-hover">
						<input type="hidden" name="etc_delete" value="S">
						<input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
							<thead>
								<tr>
									<th><input type="checkbox" onclick="allDelete(this)"></th>
									<th colspan="3"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="e" items="${elist }">
								<c:if test="${fn:contains(e.etc_delete , 'S')}">
									<tr>
										<td><input type="checkbox" value="${e.etc_num }" name="rowcheck"></td>
											<td colspan="2">
											<a href="etcDetail.student?etc_num=${e.etc_num }">${e.etc_title }</a><br>
											${e.etc_content }
											</td>
											<td colspan="2">
											<fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm" /> 
											<fmt:formatDate value="${fmtdate }" pattern="yyyy-MM-dd HH:mm" />
											</td>
											<td>
										</td>
									</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<form action="etcList.student" method="post" align="center">
						<div class="input-group input-group-sm mb-3">
    <div class="input-group-prepend">
        <select name="whatColumn" class="btn btn-secondary btn-sm dropdown-toggle" id="dropdownMenuSizeButton3">
            <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색</option>
            <option value="etc_title" <c:if test="${param.whatColumn eq 'etc_title'}">selected</c:if>>제목</option>
            <option value="etc_content" <c:if test="${param.whatColumn eq 'etc_content'}">selected</c:if>>내용</option>
        </select>
    </div>
    <input type="text" class="form-control form-control-sm" placeholder="Search" name="keyword">
    <input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
    <div class="input-group-append">
        <button type="submit" class="btn btn-outline-secondary btn-sm">
            <i class="fa fa-search"></i>
        </button>
    </div>
</div>					
						</form>
					<center>${pageInfo.getPagingHtml() }</center>

				</div>
			</div>
		</div>




<%@ include file="studentBottom.jsp"%>