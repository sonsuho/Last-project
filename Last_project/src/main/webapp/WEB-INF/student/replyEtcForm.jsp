<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "studentTop.jsp"%>

<style>
.err {
    font-size: 9pt;
    color: red;
}
/* 초기에는 숨김 */
.member-list {
    display: none;
}
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
    function checkFileInput() {
        var fileInput = document.getElementsByName('multiFile')[0];
        var uploadField = document.getElementsByName('etc_file')[0];

        if (fileInput.files.length > 0) {
            uploadField.value = '파일 존재';
        } else {
            uploadField.value = '';
        }
    }
    
    function validateForm() {
        var checkboxes = document.getElementsByName('mem_num');
        var isChecked = false;

        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                isChecked = true;
                break;
            }
        }

        if (!isChecked) {
            alert("받는 사람을 선택하세요.");
            return false;
        }

        return true;
    }


</script>

<h2 align="center">서류 요청</h2>
<form:form id="form" commandName="etc" action="replyEtc.student" method="post" enctype="multipart/form-data" acceptCharset="UTF-8" onsubmit="return validateForm();">
    <table border="1" align="center" id="fileview">
        <tr>
            <td>
               받는사람:<input type="checkbox" name="mem_num" value="${mb.mem_num}">${mb.name}
            </td>
        </tr>
        <tr>
            <td>
            	<input type="hidden" name="etc_delete" value="MS">
                <input type="hidden" name="sender_num" value="${sender_num}">
                제목: <input type="text" name="etc_title" value="re:[${eb.etc_title}]">
                <form:errors path="etc_title" cssClass="err"/>
            </td>
        </tr>
        <tr>
            <td>
                내용:
                <textarea name="etc_content" rows="5" cols="30" placeholder="내용 입력">${etc.etc_content}</textarea>
                <form:errors path="etc_content" cssClass="err"/>
            </td>
        </tr>
        <tr>
            <td>
                희망 마감 날짜: <input type="date" name="etc_fdate" value="${etc.etc_fdate}">
                <form:errors path="etc_fdate" cssClass="err"/>
            </td>
        </tr>
        <tr>
            <td>
                파일:<input type="file" name="multiFile" multiple onchange="checkFileInput()"> <br>
                업로드 경로: <input type="text" name="etc_file_path" value="C:/sts2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Last_project/resources/files/"><br>
                <input type="hidden" name="etc_file" value="" readonly>
            </td>
        </tr>
    </table>
    <center>
        <input type="submit" value="전송">
    </center>
</form:form>
<%@ include file = "studentBottom.jsp"%>