<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "managerBarTop.jsp"%>

<%
    String[] group = {"All", "A", "B", "C", "D", "E", "F", "G", "H"};
%>
<style type="text/css">

    .err {
        font-size: 15px;
        color: red;
    }

    /* Header Styles */
    .page-header {
        padding: 15px;
    }

    .page-header button {
        font-weight: bold;
        background-color: transparent;
    }

    .page-header button:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    /* Form Container Styles */
    .form-container {
        max-width: 800px;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    /* Form Element Styles */
    form {
        margin-bottom: 20px;
    }

    input[type="text"],
    select,
    textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 16px;
    }

    select {
        width: calc(100% - 20px); /* Adjusting for padding */
    }

    textarea {
        height: 150px;
    }

    input[type="submit"] {
        background-color: #28a745;
        color: #fff;
        border: none;
        padding: 12px 20px;
        cursor: pointer;
        border-radius: 4px;
        font-size: 16px;
    }

    input[type="submit"]:hover {
        background-color: #218838;
    }

</style>

<script type="text/javascript">
    function back() {
        history.back();
    }

    function libCheck() {
        var title = document.getElementById('title').value.trim();
        
        if (title === "") {
            alert("제목을 입력하세요.");
            document.getElementById('title').focus();
            return false;
        }
        return true;
    }
</script>

<!-- header -->
    <div class="page-header">
      <div class="input-group-append">
        <button class="btn btn-sm" type="button" onclick="back()"><i class="fa fa-chevron-left"></i> &nbsp;&nbsp; 뒤로가기</button>
      </div>
    </div>

<div class="form-container">
    <div class="row">
        <div class="col-lg-12">
            <h1 style="text-align: center;">공지사항 글 삽입</h1>
            <br><br>

            <form:form commandName="notice" action="noticeInsert.manager" method="post">

                <h3>제목 : <input type="text" name="title" id="title" value="${notice.title}" size="10"></h3>

                <div style="color: #999; margin: 20px 0; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #000; font-size: 15px;">
                    <select name="class_name">
                        <option value="">소속반을 선택하세요</option>
                        <c:set var="gList" value="<%=group%>" />
                        <c:forEach var="i" begin="0" end="${fn:length(gList) - 1}">
                            <option value="${gList[i]}" <c:if test="${notice.class_name eq gList[i]}">selected</c:if>>
                                ${gList[i]}
                            </option>
                        </c:forEach>
                    </select>

                    <form:errors path="class_name" cssClass="err" />

                   

                </div>

                <div style="padding: 30px 0 50px; font-size: 16px;">
                    <textarea rows="5" cols="22" name="content" id="content">${notice.content}</textarea>
                    <form:errors path="content" cssClass="err" />
                </div>
             <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 16px;">
                     <input type="submit" value="삽입" onclick="return libCheck()" class="btn btn-sm btn-success">
                 </div>
            </form:form>
        </div>
    </div>
</div>

<%@ include file = "managerBarBottom.jsp"%>