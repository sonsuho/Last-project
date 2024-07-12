<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>
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
function etcReceivList(mem_num){
	location.href="etcList.student?mem_num="+mem_num;
}
function etcSendList(sender_num){
	location.href="etcSendList.student?sender_num="+sender_num;
}

function requestList2(mem_num) {
    location.href = "request2.student?mem_num="+mem_num;
}

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
</script>

<h2>내(학생) 문서함</h2>
<hr>
<input type="button" value="받은 문서" onclick="etcReceivList('${loginInfo.mem_num}')">
<input type="button" value="내가 쓴 문서" onclick="etcSendList('${loginInfo.mem_num}')">
<input type="button" value="결재 문서" onclick="requestList2('${loginInfo.mem_num}')">
<form method="post" name="myform" action="selectDeleteSend.student">
<input type="hidden" name="etc_delete" value="S">
<input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
	<table>
		<tr><th><input type="button" value="일괄삭제" onclick="selectDelete()"></th></tr>
		<tr>
			<th colspan="4"><input type="checkbox" onclick="allDelete(this)"></th>
		</tr>
		<c:forEach var="e" items="${elist }">
		<c:if test="${fn:contains(e.etc_delete , 'S')}">
		<tr>
			<td><input type="checkbox" value="${e.etc_num}" name="rowcheck"></td>
			<td><a href="etcDetail2.student?etc_num=${e.etc_num}&sender_num=${loginInfo.mem_num}">${e.etc_title }</a></td>
			<td>${e.etc_content }</td>
			<td>
			<fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm" /> 
			<fmt:formatDate value="${fmtdate }" pattern="yyyy-MM-dd HH:mm" />
			</td>
		</tr>
		</c:if>
		</c:forEach>
	</table>
</form>
 <form action="etcSendList.student" method="post" align="center">
	<select name="whatColumn">
		<option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색
		<option value="etc_title" <c:if test="${param.whatColumn eq 'etc_title'}">selected</c:if>>제목
		<option value="etc_content" <c:if test="${param.whatColumn eq 'etc_content'}">selected</c:if>>내용
		    <input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
		
	</select>
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
<center>
	${pageInfo.getPagingHtml() }
</center>

<%@ include file = "studentBottom.jsp"%>
