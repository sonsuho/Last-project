<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
	
	<script type="text/javascript">
	    function submitForm() {
	    	
	        // 새 창의 크기 설정
	        var width = 1200;  // 창의 너비
	        var height = 800; // 창의 높이
	        // 화면의 가로와 세로 크기를 가져오기
	        var screenWidth = window.screen.width;
	        var screenHeight = window.screen.height;
	        // 화면 중앙에 배치하기 위해 계산
	        var left = (screenWidth - width) / 2;
	        var top = (screenHeight - height) / 2;

	        // 새 창 열기
	        var newWindow = window.open('', 'formWindow', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);

	        // 폼 요소 생성
	        var form = document.createElement('form');
	        form.setAttribute('method', 'post');
	        form.setAttribute('action', 'testWrite2.teacher');
	        form.setAttribute('enctype', 'multipart/form-data'); // 파일 업로드를 위한 설정
	        form.setAttribute('target', 'formWindow'); // 새 창으로 열기
	
	        // document.body에 폼 추가 후 submit
	        document.body.appendChild(form);
	        form.submit();
	
	        // 폼 추가 후 바로 제거할 수도 있습니다.
	        document.body.removeChild(form);
	
	        // 이전 페이지로 이동
	        location.href = 'home.teacher';
	    }
	
	    // 페이지 로드 시 폼 제출 함수 호출
	    window.onload = function() {
	        submitForm();
	    };
	</script>
	
	<body>
	    <br>testWriteForm.jsp<br>
	</body>