<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
	
	<%
	    request.setCharacterEncoding("UTF-8");
	%>
	
	<script type="text/javascript">
	    function submitForm() {
	    	
	        // 새 창의 크기 설정
	        var width = 1350;  // 창의 너비
	        var height = 900; // 창의 높이
	        // 화면의 가로와 세로 크기를 가져오기
	        var screenWidth = window.screen.width;
	        var screenHeight = window.screen.height;
	        // 화면 중앙에 배치하기 위해 계산
	        var left = (screenWidth - width) / 2;
	        var top = (screenHeight - height) / 2;

	        // 새 창 열기
	        var newWindow = window.open('', 'formWindow', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
	    	
	        // test_num 값을 읽어와 넘겨준다
	        var testNum = '<%= request.getAttribute("test_num") %>';
	        
	        // 폼 요소 생성
	        var form = document.createElement('form');
	        form.setAttribute('method', 'post');
	        form.setAttribute('action', 'testContent2.student');
	        form.setAttribute('target', 'formWindow'); // 새 창으로 열기
	        
	        // hidden 필드 추가
	        var hiddenField = document.createElement('input');
	        hiddenField.setAttribute('type', 'hidden');
	        hiddenField.setAttribute('name', 'test_num');
	        hiddenField.setAttribute('value', testNum);
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
