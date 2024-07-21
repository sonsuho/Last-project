<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
		
    <script type="text/javascript">
        window.onload = function() {
            alert("시험 제출 성공");
            window.opener = null; // 부모 창을 참조하지 않게 설정
            window.open('', '_self'); // 현재 창을 대상 창으로 설정
            window.close(); // 현재 창 닫기
        };
    </script>
    
	<br>testSuccess.jsp<br>