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
        // 선택된 체크박스 수 확인
        var checkedCount = document.querySelectorAll('input[name="selected_mem_num"]:checked').length;

        if (checkedCount === 0) {
            alert('최소 한 명 이상 선택해야 합니다.');
            return false; // 폼 제출 방지
        }

        return true; // 폼 제출 허용
    }

    // jQuery를 이용하여 document.ready 이벤트 설정
    $(document).ready(function() {
        // 보낼 사람 선택 체크박스에 대한 클릭 이벤트 설정
        $('input[name="check_num"]').change(function() {
            // 선택된 보낼 사람 수 구하기
            var checkedCount = $('input[name="check_num"]:checked').length;

            // 선택된 보낼 사람이 하나 이상인 경우에만 보이도록 설정
            if (checkedCount > 0) {
                $('.member-list').show(); // 보이기
            } else {
                $('.member-list').hide(); // 숨기기
            }
        });
    });
</script>

<h2 align="center">서류 요청</h2>
<form:form id="form" commandName="etc" action="etc.student" method="post" enctype="multipart/form-data" acceptCharset="UTF-8" onsubmit="return validateForm();">
    <table border="1" align="center" id="fileview">
        <tr>
            <td>
                <label>
                    <input type="checkbox" class="send-to" name="check_num"> 
                </label>
                보낼 사람 선택
            </td>
        </tr>
        <tr class="member-list">
            <td>
                <!-- 보낼 사람이 선택되었을 때 보이는 부분 -->
                <h3>-목록-</h3>
                <c:forEach var="m" items="${mlist}">
                    
                        <input type="checkbox" name="selected_mem_num" value="${m.mem_num}"> ${m.name}
                    <br>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <td>
            	<input type="hidden" name="etc_delete" value="MS">
                <input type="hidden" name="sender_num" value="${sender_num}">
                제목: <input type="text" name="etc_title" value="${etc.etc_title}">
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