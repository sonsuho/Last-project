<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="managerBarTop.jsp" %>

<style type="text/css">
    /* Error Message Styles */
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
    .form-container h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    .form-container h3 {
        font-size: 18px;
        margin-bottom: 20px;
    }

    .form-container input[type="text"],
    .form-container select,
    .form-container textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 16px;
    }

    .form-container select {
        width: calc(100% - 20px);
    }

    .form-container textarea {
        height: 150px;
    }

    .form-container .btn-submit {
        background-color: #28a745;
        color: #fff;
        border: none;
        padding: 12px 20px;
        cursor: pointer;
        border-radius: 4px;
        font-size: 16px;
    }

    .form-container .btn-submit:hover {
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

<!-- Header -->
<div class="page-header">
    <div class="input-group-append">
        <button class="btn btn-sm" type="button" onclick="back()">
            <i class="fa fa-chevron-left"></i> &nbsp;&nbsp; 뒤로가기
        </button>
    </div>
</div>

<!-- Form Container -->
<div class="form-container">
    <h1 style="text-align: center;">공지사항 글 수정</h1>
    <br>

    <form:form commandName="notice" action="noticeUpdate.manager" method="post">
        <input type="hidden" name="n_num" value="${notice.n_num}">
        <input type="hidden" name="lec_num" value="${notice.lec_num}">
        <input type="hidden" name="class_name" value="${notice.class_name}">

        <h3><input type="text" name="title" id="title" value="${notice.title}"></h3>

        <div style="color: #999; margin: 20px 0; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #000; font-size: 15px;">
            <div style="display: flex; justify-content: flex-start; align-items: center;">
                <p><b>${notice.writer}</b></p>
                <p style="padding: 0 10px;">|</p>
                <p>${notice.day }</p>
                <p style="padding: 0 10px;">|</p>
                <p>${notice.class_name}반</p>
            </div>
        </div>

        <div style="padding: 30px 0 50px; font-size: 16px;">
            <textarea rows="5" cols="22" name="content" id="content">${notice.content}</textarea>
        </div>
        
        <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 16px;">
                <div>
                    <input type="submit" value="수정" onclick="return libCheck()" class="btn btn-sm btn-success py-3">
                </div>
            </div>
    </form:form>
</div>

<%@ include file="managerBarBottom.jsp" %>