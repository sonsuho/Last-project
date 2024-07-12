<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "managerBarTop.jsp"%>
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
                alert("삭제할 문서를 선택하세요");
                return;
            }
            document.myform.submit();
        }

function etcList(sender_num){
	location.href="etcList.manager?sender_num="+sender_num;
}

function requestList(){
	location.href="request.manager";
}
function requestList2() {
    location.href = "request2.manager";
}
function etcList2(mem_num) {
    location.href = "etcList2.manager?mem_num="+mem_num;
}
</script>
<body>

<h2>내(매니저) 문서함</h2>
<div class="btn-group">
<input type="button" value="승인 대기 문서" onclick="requestList()">
<input type="button" value="문서함" onclick="etcList2('${loginInfo.mem_num}')">
<input type="button" value="내가 쓴 문서" onclick="etcList('${loginInfo.mem_num}')">
<input type="button" value="완료" onclick="requestList2()">
</div>
<hr>
<form method="post" name="myform" action="selectDeleteEtc.manager">
	<input type="button" value="일괄삭제" onclick="selectDelete()">
	<input type="hidden" name="etc_delete" value="M">
	<input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
	<table>
		<tr>
			<th><input type="checkbox" onclick="allDelete(this)"></th>
			<th colspan="3"></th>
		</tr>
		
		<c:forEach var="e" items="${elist }">
		<tr>
			<td><input type="checkbox" value="${e.etc_num }" name="rowcheck" ></td>
			<td><a href="etcDetail.manager?etc_num=${e.etc_num }">${e.etc_title }</a></td>
			<td>${e.etc_content }</td>
			<td>
			<fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm"/>
			<fmt:formatDate value="${fmtdate }"  pattern="yyyy-MM-dd HH:mm"/>
			</td>
		</tr>
		</c:forEach>
	</table>
</form>

 <form action="etcList.manager" method="post" align="center">
	<select name="whatColumn" >
		<option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색
		<option value="etc_title" <c:if test="${param.whatColumn eq 'etc_title'}">selected</c:if>>제목
		<option value="etc_content" <c:if test="${param.whatColumn eq 'etc_content'}">selected</c:if>>내용
	</select>
	<input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
</body>
<center>
	${pageInfo.getPagingHtml() }
</center>

<%@include file = "managerBarBottom.jsp"%>