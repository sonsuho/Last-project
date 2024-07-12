<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp" %>

	<script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function() {
	        var progressFill = document.getElementById('progressFill');
	        if (progressFill) {
	            var totalDurationDays = <%= request.getAttribute("total") %>;
	            var passedDurationDays = <%= request.getAttribute("pass") %>;
	            
	            var percentage = (passedDurationDays / totalDurationDays) * 100;
	            
	            progressFill.style.width = percentage + '%';
	            progressFill.textContent = percentage.toFixed(2) + '%';
	        } else {
	            console.error('progressFill element not found!');
	        }
	    });
	</script>
	
	<style>
	    .progress-bar {
        	width: 100%;
	        height: 20px;
	        background-color: #ddd;
	        border-radius: 10px;
	        margin-bottom: 10px;
	    }
	    
	    .progress-fill {
	        height: 100%;
	        background-color: #4CAF50; /* 진행 막대의 배경색 */
	        border-radius: 10px; /* 필요에 따라 모서리를 둥글게 */
	        transition: width 0.3s ease; /* 너비 변화에 따른 부드러운 애니메이션 효과 */
	    }
	</style>
	
	<!-- header -->
	<div class="page-header">
	    <h3 class="page-title">
	        <span class="page-title-icon bg-gradient-primary text-white me-2">
	            <i class="mdi mdi-home"></i>
	        </span> StudentMain
	    </h3>
	    <nav aria-label="breadcrumb">
	        <ul class="breadcrumb">
	            <li class="breadcrumb-item active" aria-current="page">
	                <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
	            </li>
	        </ul>
	    </nav>
	</div>
	
	<div>
	    남은 일 수: ${last} <br><br>
	    
	    <div class="progress-bar" id="progressBar">
	        <div class="progress-fill" id="progressFill"></div>
	    </div>
	    
	    <br>
	    
	    <a href="request.student">요청 페이지</a> <br>
	    <a href="rlist.messenger">메신저 페이지</a>
	</div>

<%@ include file="studentBottom.jsp" %>
