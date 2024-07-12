<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
	
	<%
	    request.setCharacterEncoding("UTF-8");
	%>
	
	<script type="text/javascript">
	    function submitForm() {
	        // test_num 값을 읽어와 넘겨준다
	        var evalNum = '<%= request.getAttribute("eval_num") %>';
	        
	        // 폼 요소 생성
	        var form = document.createElement('form');
	        form.setAttribute('method', 'post');
	        form.setAttribute('action', 'evalContent2.student');
	        form.setAttribute('target', '_blank'); // 새 창으로 열기
	        
	        // hidden 필드 추가
	        var hiddenField = document.createElement('input');
	        hiddenField.setAttribute('type', 'hidden');
	        hiddenField.setAttribute('name', 'eval_num');
	        hiddenField.setAttribute('value', evalNum);
	        form.appendChild(hiddenField);
	        
	        // document.body에 폼 추가 후 submit
	        document.body.appendChild(form);
	        
	        // 폼이 제출되면 이벤트 핸들러 추가
	        form.onsubmit = function() {
	            // 폼 추가 후 바로 제거할 수도 있습니다.
	            document.body.removeChild(form);
	        };
	        
	        // 폼 제출
	        form.submit();
	        
	        // 이전 페이지로 이동
	        history.back();
	    }
	    
	    // 페이지 로드 시 폼 제출 함수 호출
	    window.onload = function() {
	        submitForm();
	    };
	</script>
	
	<body>
	    <br>testContent.jsp<br>
	</body>
    