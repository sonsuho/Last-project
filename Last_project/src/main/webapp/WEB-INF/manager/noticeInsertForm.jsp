<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${loginInfo.category == 'manager'}">
        <%@ include file = "managerBarTop.jsp"%>
    </c:when>
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file = "../student/studentTop.jsp"%>
    </c:when>
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file = "../teacher/teacherTop.jsp"%>
    </c:when>
</c:choose>

<style type="text/css">
    table {
        width: 650px;
    }
</style>

<script type="text/javascript">
    function detailLib(num) {
        location.href = "noticeDetail.manager?n_num=" + num;
    }

    function allCheck(obj) {
        var rcheck = document.getElementsByName("rowcheck");
        var check = obj.checked;
        for (var i = 0; i < rcheck.length; i++) {
            rcheck[i].checked = check;
        }
    }

    function selectDelete() {
        var flag = false;
        var rcheck = document.getElementsByName("rowcheck");
        for (var i = 0; i < rcheck.length; i++) {
            if (rcheck[i].checked == true) {
                flag = true;
                break;
            }
        }
        if (!flag) {
            alert('삭제할 항목을 선택하세요.');
            return false;
        }
        var result = confirm("삭제 하시겠습니까?");
        if (result == true) {
            document.myform.submit();
        } else {
            alert('취소했습니다');
            return false;
        }
    }
</script>

<div class="row">
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 style="text-align:center;">공지사항</h1>
                    </div>
                </div>

                <div class="row" style="margin-top: 36px;">
                    <div class="col-lg-4" style="display:flex; justify-content: flex-start; align-content: center;">
                        <c:if test="${loginInfo.category == 'manager'}">
                            <input type="button" value="선택삭제" onclick="selectDelete()" style="padding:12px; margin-right: 7px; width:80px; height:35px;" class="btn btn-gradient-primary">
                        </c:if>
                        <c:if test="${loginInfo.category == 'manager'}">
                            <a href="noticeInsert.manager?pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}" style="padding:12px; margin-right: 7px; width:80px; height:35px;" class="btn btn-gradient-primary">글쓰기</a>
                        </c:if>
                    </div>
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-6">
                        <form action="notice.manager">
                            <div class="form-group" style="display:flex; justify-content: flex-start; align-content: center;">
                                <select name="whatColumn" class="form-select" style="width:140px; margin-right: 15px;">
                                    <option value="all">전체검색</option>
                                    <option value="title">제목</option>
                                    <option value="content">내용</option>
                                </select>
                                <input type="text" name="keyword" class="form-control" style="font-size: 16px;" placeholder="검색어를 입력하세요.">
                                <input type="submit" class="btn btn-sm btn-success py-3" style="width: 70px;" value="검색">
                            </div>
                        </form>
                    </div><!-- col-lg-8 end -->
                </div><!-- row end -->

                <form name="myform" action="deleteAllNotice.manager">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="background:#f6f6f6; width:100px !important;" onclick="event.stopPropagation();">
                                    <c:if test="${loginInfo.category == 'manager'}">
                                        <input type="checkbox" name="allcheck" onclick="allCheck(this)">
                                    </c:if>
                                </th>
                                <th style="background:#f6f6f6; text-align: left !important;">제목</th>
                                <th style="background:#f6f6f6; text-align: left !important;">작성자</th>
                                <th style="background:#f6f6f6; text-align: left !important;">작성일</th>
                                <th style="background:#f6f6f6; text-align: left !important;">반</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${fn:length(noticeList) == 0}">
                                    <tr>
                                        <td colspan="5" align="center" style="height: 50">작성된 글이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="notice" items="${noticeList}">
                                        <c:if test="${loginInfo.category == 'student' && notice.lec_num == loginInfo.lec_num && loginInfo.lec_num == nb.lec_num}">
                                        </c:if>
                                        <c:if test="${loginInfo.category != 'student' || notice.lec_num == loginInfo.lec_num}">
                                            <tr onclick="detailLib('${notice.n_num}')">
                                                <td align="center">
                                                    <c:if test="${loginInfo.category == 'manager'}">
                                                        <input type="checkbox" name="rowcheck" value="${notice.n_num }">
                                                    </c:if>
                                                </td>
                                                <td><a href="noticeDetail.manager?n_num=${notice.n_num}">${notice.title}</a></td>
                                                <td>${notice.writer}</td>
                                                <td>${notice.day}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${notice.class_name eq 'All'}">
                                                            전체
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${notice.class_name}반
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </form>

                <br>
                <div style="text-align: center;">
                    ${pageInfo.pagingHtml}
                </div>
            </div>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${loginInfo.category == 'manager'}">
        <%@ include file = "managerBarBottom.jsp"%>
    </c:when>
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file = "../student/studentBottom.jsp"%>
    </c:when>
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file = "../teacher/teacherBottom.jsp"%>
    </c:when>
</c:choose>
