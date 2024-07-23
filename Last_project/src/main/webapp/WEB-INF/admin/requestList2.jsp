<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "adminBarTop.jsp"%>
<head>
    <meta charset="UTF-8">
    <title>관리자 문서함</title>
    <style>
        .container {
            display: flex;
            transition: all 0.5s ease;
        }
        .left-panel, .right-panel {
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: #fff;
            transition: all 1s ease;
        }
        .left-panel {
            flex: 1;
        }
        .right-panel {
            flex: 0;
            display: none;
            max-width: 0;
            overflow: hidden;
        }
        .container.expanded .left-panel {
            flex: 1;
        }
        .container.expanded .right-panel {
            display: block;
            flex: 1;
            max-width: 100%;
        }
        .sub-next-title { color: #9a9a9a;  cursor: pointer;}
		.sub-next-title:hover {color: #b66dff; transition: 0.2s; }
	
		span{
			margin-right: 5;
		}
		.btn-fixed-width {
            width: 90px;
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
            document.myform.action = "selectDeleteReq2.admin";
            document.myform.submit();
        }

        function requestList() {
            location.href = "request.admin?mem_num=1";
        }    
        function requestList2() {
            location.href = "request2.admin";
        }
        
        // 화면 분할
        function openDetail(req_num, mem_num, title, reason, memberName, time1,time2, sign, app_num, pageNumber ,ap_situ) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'requestDetail.admin?req_num=' + encodeURIComponent(req_num) +
                '&mem_num=' + encodeURIComponent(mem_num) +
                '&title=' + encodeURIComponent(title) +
                '&reason=' + encodeURIComponent(reason) +
                '&memberName=' + encodeURIComponent(memberName) +
                '&time1=' + encodeURIComponent(time1) +
                '&time2=' + encodeURIComponent(time2) +
                '&sign=' + encodeURIComponent(sign) +
                '&app_num=' + encodeURIComponent(app_num) +
                '&pageNumber=' + encodeURIComponent(pageNumber) +
                '&ap_situ=' + encodeURIComponent(ap_situ), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    document.getElementById('rightPanel').innerHTML = xhr.responseText;
                    document.getElementById('container').classList.add('expanded');
                }
            };
            xhr.send();
        }
        
        function msitu(req_num, app_num, mem_num){
            location.href="changeCompanion.admin?req_num="+req_num+"&app_num="+app_num+"&mem_num="+mem_num;
        }

        function psitu(req_num, app_num, mem_num){
            location.href="changeApproval.admin?req_num="+req_num+"&app_num="+app_num+"&mem_num="+mem_num;
        }
    </script>
</head>
<body>
<div class="container" id="container">
    <div class="left-panel" id="leftPanel">
       <div class="page-header">
	<h3 class="page-title" style="font-weight:700;">
		<span class="sub-next-title" onclick="requestList()">받은 결재함</span> 
		<span>결재 목록</span>
	</h3>
		<nav aria-label="breadcrumb">
        	<div class="input-group-append">
            </div>
        </nav>
		</div>
       <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">

					<div class="row">
				        <div class="col-lg-4">
	                     	<form action="request2.admin" style="display:flex;">
	                     		<input type="hidden" name="whatColumn" value="all">
                        		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		                        <input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2" style="width: 400px;">
	                   			
		                        <button type="submit" class="btn btn-sm btn-success py-3 btn-fixed-width" type="button">검색</button>&nbsp;
                        		<input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3">
	                        </form>
				        </div>
	                </div>
    
                    <!-- Pending Documents -->
                    <form name="myform" action="selectDeleteReq2.admin" method="post">
                        <input type="hidden" name="ap_delete" value="A">
                        <table class="table table-hover">
                            <thead>
                               <tr class="table-danger">
                                <td><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></td>
                                
                                <td>제목/내용</td>
                                <td>상태/날짜</td>
                            </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${completedList == null || completedList.isEmpty()}">
                                        <tr>
                                            <td colspan="3" style="text-align: center;">대기중인 문서가 없습니다</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="r" items="${completedList}">
                                            <c:if test="${fn:contains(r.ap_delete , 'A')}">
                                                <tr>
                                                    <td rowspan="2"><input type="checkbox" value="${r.req_num}" name="rowcheck" class="form-check-input"></td>
                                                    <td>
                                                        <a href="javascript:void(0);" onclick="openDetail('${r.req_num}', '${loginInfo.mem_num}', '${r.title}', '${r.reason}', '${r.memberName}','${r.time1}', '${r.time2}', '${r.sign}', '${loginInfo.mem_num}','${pageInfo.pageNumber }' ,'${r.ap_situ}')">
                                                            ${r.memberName}
                                                        </a>
                                                        <br><br>
                                                 		${r.reason}
                                                    </td>
                                                    <td>
                                                        <c:if test="${r.ap_situ == '승인'}">
                                                			<label class="badge badge-success">승인</label>
                                            			</c:if>
                                            			<c:if test="${r.ap_situ == '반려'}">
                                                			<label class="badge badge-danger">반려</label>
                                            			</c:if>
                                            			<br><br>
                                                    		${r.time1}
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </form>
                    
                    <center>${pageInfo.pagingHtml}</center>
                </div>
            </div>
        </div>
    </div>
    <div class="right-panel" id="rightPanel">
        <!-- 문서 상세 내용이 여기에 표시됩니다 -->
        <h2>문서 내용을 선택하세요</h2>
    </div>
</div>
<%@include file = "adminBarBottom.jsp"%>