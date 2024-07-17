<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp" %>

<%
    // 현재 날짜 정보 가져오기
    java.time.LocalDate currentDate = java.time.LocalDate.now();
    
    // 현재 월의 첫 날과 마지막 날 계산
    java.time.LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
    java.time.LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth());
    
    // 첫 날의 요일 가져오기 (1: 월요일, 7: 일요일)
    int firstDayOfWeekValue = firstDayOfMonth.getDayOfWeek().getValue();
    // 첫 날의 요일 (한국 형식, 1: 월요일, 7: 일요일)
    int firstDayOfWeekKorea = firstDayOfWeekValue % 7 + 1; // 일요일로 다시 시작하는 형식
%>
	
	<style>
	    .content-container {
	        justify-content: space-around;
	        gap: 20px;
	    }
	
	    .element1, .element2 {
	        width: 100%;
	        background: #fff;
	        border-radius: 8px;
	        padding: 20px;
	        margin-bottom: 20px;
	        border: 1px solid #e0e0e0;
	    }
	    
	    .element2{
	    	display: flex;
	        justify-content: space-between;
	        align-items: flex-start;
	        flex-wrap: wrap;
	        gap: 50px;	
	    }
	
	    .progress-container {
	        text-align: center;
	    }
	
	    .progress-bar {
	        width: 100%;
	        height: 20px;
	        background: #e0e0e0;
	        border-radius: 10px;
	        margin: 20px 0;
	        position: relative;
	    }
	
	    .progress-bar .progress {
	        height: 100%;
	        width: 80%;
	        background: #36E0C6;
	        border-radius: 10px;
	    }
	
	    .calendar-container, .notice-container {
	        background: #fff;
	        border: 1px solid #e0e0e0;
	        border-radius: 8px;
	        padding: 20px;
	        width: 48%;
	    }
	
	    .calendar-container h4, .notice-container h4 {
	        margin-bottom: 20px;
	    }
	
	    .calendar-table {
	        width: 100%;
	        border-collapse: collapse;
	    }
	
	    .calendar-table th, .calendar-table td {
	        padding: 10px;
	        text-align: center;
	        border: 1px solid #e0e0e0;
	    }
	
	    .notice-list {
	        list-style: none;
	        padding: 0;
	        margin: 0;
	    }
	
	    .notice-list li {
	        display: flex;
	        justify-content: space-between;
	        padding: 10px 0;
	        border-bottom: 1px solid #e0e0e0;
	    }
	
	    .badge {
	        padding: 5px 10px;
	        border-radius: 5px;
	        color: #fff;
	    }
	
	    .badge-general {
	        background: #6c757d;
	    }
	
	    .badge-important {
	        background: #007bff;
	    }
	</style>
	
	<!-- header -->
	<div class="page-header">
	    <h3 class="page-title">
	        <span class="page-title-icon bg-gradient-primary text-white me-2">
	            <i class="mdi mdi-home"></i>
	        </span> Student Home
	    </h3>
	    <nav aria-label="breadcrumb">
	        <ul class="breadcrumb">
	            <li class="breadcrumb-item active" aria-current="page">
	                <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
	            </li>
	        </ul>
	    </nav>
	</div>
	
	<div class="row">
	    <div class="col-lg-12 grid-margin stretch-card">
	        <div class="card">
	            <div class="card-body">
	                <div class="content-container">
	                	
	                    <!-- Progress Section -->
	                    <div class="element1">
	                        <div class="progress-container">
	                            <h1 style="padding-left: 50px;" align="left">강의 진행 현황</h1><br>
	                            <p style="padding-left: 80px;" align="left"><font size="6">D-${remainingDays}</font></p>
	                            <div class="progress-bar" style="width: 90%; margin-left: 60px;" align="center">
	                                <div class="progress" style="width: ${(1 - remainingDays/totalDays) * 100}%;"></div>
	                            </div>
	                            <p style="padding-left: 80px;" align="left">남은 강의 시간: ${remainingDays * 8} 시간</p>
	                        </div>
	                    </div>
						
						<br>
						
	                    <!-- Calendar and Notice Section -->
	                    <div class="element2">
	                        <div class="calendar-container">
	                            <h4><%= currentDate.getYear() %>년 <%= currentDate.getMonthValue() %>월 캘린더</h4>
	                            <table class="calendar-table">
	                                <thead>
	                                    <tr>
	                                        <th>Su</th>
	                                        <th>Mo</th>
	                                        <th>Tu</th>
	                                        <th>We</th>
	                                        <th>Th</th>
	                                        <th>Fr</th>
	                                        <th>Sa</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <tr>
	                                        <% 
	                                            // 첫 주의 공백 채우기
	                                            for (int i = 1; i < firstDayOfWeekKorea; i++) {
	                                        %>
	                                        <td></td>
	                                        <% } %>
	                                        
	                                        <% 
								                // 날짜 출력
								                int dayOfMonth = 1;
								                while (dayOfMonth <= lastDayOfMonth.getDayOfMonth()) {
								                    
								                    // 오늘 날짜와 같으면 셀에 초록색 배경 추가
								                    boolean isToday = (dayOfMonth == java.time.LocalDate.now().getDayOfMonth());
								                    
								                    if (isToday) { %>
								                        <td style="background-color: #36E0C6;"><%= dayOfMonth %></td>
								                    <% } else { %>
								                        <td><%= dayOfMonth %></td>
								                    <% }
								                    
								                    // 일주일이 끝나면 다음 줄로
								                    if ((firstDayOfWeekKorea + dayOfMonth - 1) % 7 == 0) { %>
								            </tr><tr>
								                <% }
								                dayOfMonth++;
								                } 
								            %>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                        
	                        <div class="notice-container">
	                            <h4>공지사항</h4>
	                            <ul class="notice-list">
	                                <li>
	                                    <span class="badge badge-general">전체</span>
	                                    <span>쌍용강북센터 휴가 안내</span>
	                                    <span>2024-06-28</span>
	                                </li>
	                                <li>
	                                    <span class="badge badge-important">우리반</span>
	                                    <span>MySQL 과제 리스트 안내</span>
	                                    <span>2024-06-24</span>
	                                </li>
	                                <li>
	                                    <span class="badge badge-important">우리반</span>
	                                    <span>Spring 설치 방법</span>
	                                    <span>2024-06-24</span>
	                                </li>
	                            </ul>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<%@ include file="studentBottom.jsp" %>
