<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>


<head>
    <meta charset="UTF-8">
    <title>내(학생) 문서함</title>
    <script>
        function allDelete(obj) {
            var rcheck = document.getElementsByName("rowcheck");
            var check = obj.checked;
            for (var i = 0; i < rcheck.length; i++) {
                rcheck[i].checked = check;
            }
        }

        function selectDelete(mem_num) {
            var rcheck = document.getElementsByName("rowcheck");
            var flag = false;
            for (var i = 0; i < rcheck.length; i++) {
                if (rcheck[i].checked) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                alert("선택하세요");
                return;
            }
            document.myform.submit();
        }

        function etcList(mem_num){
        	location.href="etcList.student?mem_num="+mem_num;
        }
        function etcSendList(sender_num){
        	location.href="etcSendList.student?sender_num="+sender_num;
        }

        function requestList2(mem_num) {
            location.href = "request2.student?mem_num="+mem_num;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>내(학생) 문서함</h2>
    <div class="btn-group">
        <input type="button" value="받은 문서" onclick="etcList('${loginInfo.mem_num}')">
        <input type="button" value="내가 쓴 문서" onclick="etcSendList('${loginInfo.mem_num}')">
        <input type="button" value="결재 문서" onclick="requestList2('${loginInfo.mem_num}')">
    </div>
    <hr>

    <!-- Pending Documents -->
    <form name="myform" action="selectDeleteReq2.student" method="post">
    <input type="hidden" name="ap_delete" value="S">
    <!-- Completed Documents -->
    <h3>결재 문서</h3>
    <table>
            <tr><th><input type="button" value="일괄삭제" onclick="selectDelete()"></th></tr>
        <tr>
           	<th><input type="checkbox" onclick="allDelete(this)"></th>
            <th>문서명</th>
            <th>상태</th>
        </tr>
        <c:forEach var="r" items="${rmlist}">
        <c:if test="${fn:contains(r.ap_delete , 'S')}">
            <tr>
            	<td rowspan="2"><input type="checkbox" value="${r.req_num}" name="rowcheck"></td>
                <td>
                    <a href="${pageContext.request.contextPath}/requestDetail.student?req_num=${r.req_num}&title=${r.title}&reason=${r.reason}&memberName=${r.memberName}&time2=${r.time2}&sign=${r.sign}&app_num=${loginInfo.mem_num}">
                        ${r.memberName}
                    </a>
                </td>
                <td>
                <c:if test="${r.ap_situ == null}">
                <label class="badge badge-warning">승인필요</label>
                </c:if>
                <c:if test="${r.ap_situ == '승인'}">
				<label class="badge badge-success">승인</label>
                </c:if>
                <c:if test="${r.ap_situ == '반려'}">
                <label class="badge badge-danger">반려</label>
                </c:if>
                </td>
            </tr>
            <tr>
                <td>${r.reason}</td>
                <td>${r.time1}</td>
            </tr>
            </c:if>
        </c:forEach>
    </table>
    </form>
<form action="request2.student" method="post" align="center">
	<select name="whatColumn" >
		<option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색
		<option value="title" <c:if test="${param.whatColumn eq 'title'}">selected</c:if>>제목
		<option value="reason" <c:if test="${param.whatColumn eq 'reason'}">selected</c:if>>내용
		<option value="ap_situ" <c:if test="${param.whatColumn eq 'ap_situ'}">selected</c:if>>상태
		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
	</select>
	<input type="text" name="keyword">
	<i class = "fa fa-search"><input type="submit" value="검색"></i>
</form>
</div>
</body>
<center>
	${pageInfo.getPagingHtml() }
</center>

<%@ include file = "studentBottom.jsp"%>