<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="managerBarTop.jsp"%>

<head>
    <meta charset="UTF-8">
    <title>내(매니저) 문서함</title>
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

        function requestList(mem_num) {
            location.href = "request.manager?mem_num=" + mem_num;
        }

        function requestList2() {
            location.href = "request2.manager";
        }

        function etcList(mem_num) {
            location.href = "etcList.manager?mem_num=" + mem_num;
        }

        function etcSendList(sender_num) {
            location.href = "etcSendList.manager?sender_num=" + sender_num;
        }

        // 화면 분할
        function openDetail(req_num, mem_num, title, reason, memberName, time2, sign, app_num, ap_situ) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'requestDetail.manager?req_num=' + encodeURIComponent(req_num) +
                '&mem_num=' + encodeURIComponent(mem_num) +
                '&title=' + encodeURIComponent(title) +
                '&reason=' + encodeURIComponent(reason) +
                '&memberName=' + encodeURIComponent(memberName) +
                '&time2=' + encodeURIComponent(time2) +
                '&sign=' + encodeURIComponent(sign) +
                '&app_num=' + encodeURIComponent(app_num) +
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
        	location.href="changeCompanion.manager?req_num="+req_num+"&app_num="+app_num+"&mem_num="+mem_num;
        }

        function psitu(req_num, app_num, mem_num){
        	location.href="changeApproval.manager?req_num="+req_num+"&app_num="+app_num+"&mem_num="+mem_num;
        }
    </script>
</head>
<div class="container" id="container">
    <div class="left-panel" id="leftPanel">
        <div class="page-header">
            <h3 class="page-title">내(매니저) 문서함</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active" aria-current="page"></li>
                </ol>
            </nav>
        </div>
        <div class="col-lg-10 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                <input type="button" value="승인 대기 문서" onclick="requestList('${loginInfo.mem_num}')" class="btn btn-sm btn-gradient-success py-3">
                <input type="button" value="문서함" onclick="etcList('${loginInfo.mem_num}')" class="btn btn-sm btn-gradient-success py-3">
                <input type="button" value="내가 쓴 문서" onclick="etcSendList('${loginInfo.mem_num}')" class="btn btn-sm btn-gradient-success py-3">
                <input type="button" value="결재함" onclick="requestList2()" class="btn btn-sm btn-gradient-success py-3">
            	<p class="card-description"></p>
            

            <!-- Pending Documents -->
            <form name="myform" action="selectDelete.manager" method="post">
                <input type="hidden" name="ap_delete" value="M">
                <!-- Completed Documents -->
                
                <input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3">
               
               
                <table class="table table-hover">
                    <tr>
                        <th colspan="2"><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></th>
                        <th>상태</th>
                    </tr>
                    <c:choose>
                        <c:when test="${pendingList == null || pendingList.isEmpty()}">
                            <tr>
                                <td colspan="3" style="text-align: center;">문서가 없습니다</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${pendingList}">
                                <c:if test="${fn:contains(r.ap_delete, 'M')}">
                                    <tr>
                                        <td rowspan="2"><input type="checkbox" value="${r.req_num}" name="rowcheck" class="form-check-input"></td>
                                        <td>
                                            <a href="javascript:void(0);" onclick="openDetail('${r.req_num}', '${loginInfo.mem_num}', '${r.title}', '${r.reason}', '${r.memberName}', '${r.time2}', '${r.sign}', '${loginInfo.mem_num}', '${r.ap_situ}')">
                                                ${r.memberName}
                                            </a>
                                        </td>
                                        <td>
                                        	<c:choose>
                                            <c:when test="${r.ap_situ == null}">
                                                <label class="badge badge-warning">승인필요</label>
                                            </c:when>
                                            <c:otherwise>
                                                ${r.ap_situ}
                                            </c:otherwise>
                                        	</c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>${r.reason}</td>
                                        <td>${r.time1}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>
            </form>
            <form action="request.manager" method="post" align="center">
                <input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
                <div class="input-group input-group-sm mb-3">
                    <div class="input-group-prepend">
                        <select name="whatColumn" class="btn btn-secondary btn-sm dropdown-toggle" id="dropdownMenuSizeButton3">
                            <option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색</option>
                            <option value="title" <c:if test="${param.whatColumn eq 'title'}">selected</c:if>>제목</option>
                            <option value="reason" <c:if test="${param.whatColumn eq 'reason'}">selected</c:if>>내용</option>
                            <option value="ap_situ" <c:if test="${param.whatColumn eq 'ap_situ'}">selected</c:if>>상태</option>
                        </select>
                    </div>
                    <input type="text" class="form-control form-control-sm" placeholder="Search" name="keyword">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-outline-secondary btn-sm">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
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
<%@include file="managerBarBottom.jsp"%>
