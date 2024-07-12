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

<h2>내(매니저) 문서함</h2>

<h1>${eb.etc_title }</h1>
<form>
	<table>
		<tr>
			<td>
				보낸사람:${sender.name }(${sender.email})<br>
				받는사람:${receiver.name }(${receiver.email })<br>
			</td>
		</tr>
		<tr>
			<td>
				<fmt:parseDate var="fmtdate" value="${eb.etc_sdate }" pattern="yyyy-MM-dd HH:mm"/>
				보낸날짜:<fmt:formatDate value="${fmtdate }"  pattern="yyyy-MM-dd HH:mm"/><br>
			</td>
		</tr>
		<tr>
			<td>
				첨부파일 ${fileCount}개<br>
				<c:forEach var="upload" items="${uploadList}">		
					
					<a href="<%=request.getContextPath() %>/resources/files/${upload}" download="${upload}">
						<i class= "fa fa-download"></i>
						<span>${upload}</span>
					</a>
					
					<br>
					
				</c:forEach>
				
				<br>
    			
			</td>
		</tr>
		
	</table>
</form>
<%@include file = "managerBarBottom.jsp"%>