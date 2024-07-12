<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "managerBarTop.jsp"%>


<head>
    <meta charset="UTF-8">
    <title>내(매니저) 문서함</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .btn-group input[type="button"] {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-group input[type="button"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th input[type="checkbox"] {
            cursor: pointer;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
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
                alert("선택하세요");
                return;
            }
            document.myform.submit();
        }

        function etcList(sender_num) {
            location.href = "etcList.manager?sender_num=" + sender_num;
        }
        function requestList() {
            location.href = "request.manager";
        }
        function requestList2() {
            location.href = "request2.manager";
        }
        function etcList2(mem_num) {
            location.href = "etcList2.manager?mem_num="+mem_num;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>내(매니저) 문서함</h2>
    <div class="btn-group">
        <input type="button" value="승인 대기 문서" onclick="requestList()">
                <input type="button" value="문서함" onclick="etcList2('${loginInfo.mem_num}')">
        <input type="button" value="내가 쓴 문서" onclick="etcList('${loginInfo.mem_num}')">
        <input type="button" value="완료" onclick="requestList2()">
        
    </div>
    <hr>

    <!-- Pending Documents -->
    <form name="myform" action="selectDeleteReq2.manager" method="post">


    <!-- Completed Documents -->
    <h3>완료된 문서</h3>
    <table>
            <tr><th><input type="button" value="일괄삭제" onclick="selectDelete()"></th></tr>
        <tr>
           	<th><input type="checkbox" onclick="allDelete(this)"></th>
           	<input type="hidden" name="ap_delete" value="M">
            <th>문서명</th>
            <th>상태</th>
        </tr>
        <c:forEach var="r" items="${completedList}">
            <tr>
            	<td rowspan="2"><input type="checkbox" value="${r.req_num}" name="rowcheck"></td>
                <td>
                    <a href="${pageContext.request.contextPath}/requestDetail.manager?req_num=${r.req_num}&title=${r.title}&reason=${r.reason}&memberName=${r.memberName}&time2=${r.time2}&sign=${r.sign}&app_num=${loginInfo.mem_num}">
                        ${r.memberName}
                    </a>
                </td>
                <td>
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
        </c:forEach>
    </table>
    </form>
<form action="request2.manager" method="post" align="center">
	<select name="whatColumn" >
		<option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색
		<option value="title" <c:if test="${param.whatColumn eq 'title'}">selected</c:if>>제목
		<option value="reason" <c:if test="${param.whatColumn eq 'reason'}">selected</c:if>>내용
		<option value="ap_situ" <c:if test="${param.whatColumn eq 'ap_situ'}">selected</c:if>>상태
	</select>
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
</div>
</body>
<center>
	${pageInfo.getPagingHtml() }
</center>
<%@include file = "managerBarBottom.jsp"%>