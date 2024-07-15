<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>
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
        width : 100%;
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
</style>

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

    // 화면 분할
    function openDetail(etc_num) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'etcDetail.student?etc_num=' + etc_num, true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                document.getElementById('rightPanel').innerHTML = xhr.responseText;
                document.getElementById('container').classList.add('expanded');
            }
        };
        xhr.send();
    }
    
 
    
	function reply(etc_num,mem_num,sender_num){//받았던 사람이 이제 보내는사람이 되니까 반대로
		location.href="replyEtc.student?etc_num="+etc_num+"&mem_num="+mem_num+"&sender_num="+sender_num;
	}
	function etcForm(){
		location.href="etc.student";
	}

</script>


<div class="container" id="container">
    <div class="left-panel" id="leftPanel">
<div class="page-header">
	<h3 class="page-title" style="font-weight:700;">
		<span>받은 문서함</span> 
		<span class="sub-next-title" onclick="etcSendList('${loginInfo.mem_num}')">보낸 문서함</span>
		<span class="sub-next-title" onclick="requestList2('${loginInfo.mem_num}')">결재 문서함</span>
	</h3>
		<nav aria-label="breadcrumb">
        	<div class="input-group-append">
            <button class="btn btn-sm btn-gradient-primary py-3" type="button" data-bs-toggle="modal" data-bs-target="#firstModal" id="openFirstModal" onclick="etcForm()"><i class="mdi mdi-email"></i> &nbsp;&nbsp; 문서 보내기</button>
            </div>
        </nav>
</div>
<hr>
        
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    
                    <div class="row">
				        <div class="col-lg-4">
	                     	<form action="etcList.student" style="display:flex;">
	                     		<input type="hidden" name="whatColumn" value="all">
	                     		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		                        <input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2" style="width: 400px;">
	                   			
		                        <button type="submit" class="btn btn-sm btn-success py-3" type="button" style="width: 70px;">검색</button>
	                        </form>
				        </div>
	                </div>
	                
                    <form method="post" name="myform" action="selectDeleteEtc.student">
                        <input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
                        <input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3">
                        <table class="table table-hover">
                            <input type="hidden" name="etc_delete" value="S">
                            <input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
                            <thead>
                                <tr>
                                    <th colspan="5"><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${elist == null || elist.isEmpty()}">
                                        <tr>
                                            <td colspan="5" style="text-align: center;">문서가 없습니다</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="e" items="${elist }">
                                            <c:if test="${fn:contains(e.etc_delete , 'S')}">
                                                <tr>
                                                    <td><input type="checkbox" value="${e.etc_num }" name="rowcheck" class="form-check-input"></td>
                                                    <td colspan="2">
                                                        <a href="javascript:void(0);" onclick="openDetail(${e.etc_num})">${e.etc_title}</a><br>
                                                        ${e.etc_content }
                                                    <td>${e.memberName }</td>
                                                    </td>
                                                    <td colspan="2">
                                                        <fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm" /> 
                                                        <fmt:formatDate value="${fmtdate }" pattern="yyyy-MM-dd HH:mm" />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
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
<%@ include file="studentBottom.jsp"%>
