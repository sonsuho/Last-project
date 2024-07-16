<%@page import="member.model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="managerBarTop.jsp"%>
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
                alert("삭제할 문서를 선택하세요");
                return;
            }
            document.myform.submit();
        }


function requestList(mem_num){
	location.href="request.manager?mem_num="+mem_num;
}
function requestList2() {
    location.href = "request2.manager";
}
function etcList(mem_num) {
    location.href = "etcList.manager?mem_num="+mem_num;
}
function etcSendList(sender_num){
	location.href="etcSendList.manager?sender_num="+sender_num;
}

//화면 분할
function openDetail(etc_num) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'etcDetail.manager?etc_num=' + etc_num, true);
    xhr.onload = function() {
        if (xhr.status === 200) {
            document.getElementById('rightPanel').innerHTML = xhr.responseText;
            document.getElementById('container').classList.add('expanded');
        }
    };
    xhr.send();
}

</script>
<body>
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
		
	<form method="post" name="myform" action="selectDeleteEtc.manager">
		<input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3"> 
		<input type="hidden" name="etc_delete" value="M"> 
		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		<table class="table table-hover">
			<tr>
				<th colspan="6"><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></th>
			</tr>
			<c:choose>
				<c:when test="${elist == null || elist.isEmpty()}">
					<tr>
						<td colspan="3" style="text-align: center;">문서가 없습니다</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="e" items="${elist }">
						<c:if test="${fn:contains(e.etc_delete , 'M')}">
							<tr>
								<td><input type="checkbox" value="${e.etc_num }" name="rowcheck" class="form-check-input"></td>
								<td>
								<a href="javascript:void(0);" onclick="openDetail(${e.etc_num})">${e.etc_title}</a><br>
								</td>
								<td>${e.etc_content }</td>
								<td>${e.memberName}</td>
								<td>
									<fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm" /> 
									<fmt:formatDate value="${fmtdate }" pattern="yyyy-MM-dd HH:mm" />
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</form>

	<form action="etcList.manager" method="post" align="center">
		<div class="input-group input-group-sm mb-3">
			<div class="input-group-prepend">
		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		<select name="whatColumn" class="btn btn-secondary btn-sm dropdown-toggle" id="dropdownMenuSizeButton3">
			<option value="all" <c:if test="${param.whatColumn eq 'all'}">selected</c:if>>전체검색
			
			<option value="etc_title" <c:if test="${param.whatColumn eq 'etc_title'}">selected</c:if>>제목
			
			<option value="etc_content" <c:if test="${param.whatColumn eq 'etc_content'}">selected</c:if>>내용
			
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
                    <center>${pageInfo.getPagingHtml() }</center>
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