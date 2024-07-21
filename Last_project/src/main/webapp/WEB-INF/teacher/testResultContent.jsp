<%@page import="java.util.stream.Collectors"%>
<%@page import="test.model.NormalDistribution"%>
<%@page import="test.model.TestResultBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
    
    <%
        List<TestResultBean> trlist = (List<TestResultBean>)request.getAttribute("trlist");
    
        int zero = 0;    
        int one = 0;    
        int two = 0;    
        int three = 0;    
        int four = 0;    
        int five = 0;    
        
        for(TestResultBean testResult : trlist){
            
            if(testResult.getPoint() == 0){
                zero++;
            }else if(testResult.getPoint() == 20){
                one++;
            }else if(testResult.getPoint() == 40){
                two++;
            }else if(testResult.getPoint() == 60){
                three++;
            }else if(testResult.getPoint() == 80){
                four++;
            }else if(testResult.getPoint() == 100){
                five++;
            }
        }
        
        int fail = zero + one + two + three;
        int success = four + five;
        
        // 정규분포 데이터 계산
        double mean = (Double)request.getAttribute("mean");
        double stdDev = (Double)request.getAttribute("standard_deviation");
        List<Double> normalDistData = NormalDistribution.getNormalDistributionData(mean, stdDev, 100);
        
        // List<Double>을 문자열로 변환
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < normalDistData.size(); i++) {
            sb.append(normalDistData.get(i));
            if (i < normalDistData.size() - 1) {
                sb.append(",");
            }
        }
        String normalDistDataString = sb.toString();
    %>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 막대 차트
            const ctxBar = document.getElementById('stickChart').getContext('2d');
        	
            ctxBar.width = 20; // 너비 설정
            ctxBar.height = 20; // 높이 설정
            
            new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: ['0', '20점', '40점', '60점', '80점', '100점'],
                    datasets: [{
                        label: '# of Votes',
                        data: [<%=zero%>, <%=one%>, <%=two%>, <%=three%>, <%=four%>, <%=five%>],
                        borderWidth: 1
                    }]
                },
                options: {
                	responsive: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        
            // 파이 차트
            const ctxPie = document.getElementById('piChart').getContext('2d');
        	
            ctxPie.width = 100; // 너비 설정
            ctxPie.height = 100; // 높이 설정
            
            new Chart(ctxPie, {
                type: 'pie',
                data: {
                    labels: ['합격', '불합격'],
                    datasets: [{
                        label: '# of Votes',
                        data: [<%=success%>, <%=fail%>],
                        borderWidth: 1
                    }]
                },
                options: {
                	responsive: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        
            // 정규분포 차트
            const ctxLine = document.getElementById('normalDistChart').getContext('2d');
            
            ctxLine.width = 20; // 너비 설정
            ctxLine.height = 20; // 높이 설정
            
            new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: Array.from({length: 100}, (_, i) => (i / 10 - 3).toFixed(1)), // x축 레이블 (평균 ± 3표준편차)
                    datasets: [{
                        label: 'Normal Distribution',
                        data: [<%=normalDistDataString%>],
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 2,
                        fill: false
                    }]
                },
                options: {
                	responsive: false,
                    scales: {
                        x: {
                            beginAtZero: false
                        },
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
    
    <style type="text/css">
    	
	    .form-group {
		  display: flex;
		  align-items: center;
		  margin-right: 1rem;
		}
		
		.form-group .btn,
		.form-group .form-control,
		.form-group .form-select {
		  margin-right: 0.3rem;
		}
		
		.form-select{
		  width: 100px;
		}
		
		.datepicker .disabled, .datepicker .disabled:hover {
		    color: #ccc !important;
		    cursor: not-allowed;
		}
		
		.fa-minus-square {
		  color: #36E0C6;
		  font-size: 20px;
		}
		
		.fa-plus-square{
		  color: #36E0C6;
		  font-size: 30px;
		}
		
		.fa-minus-square:hover, .fa-plus-square:hover {
		  color: #F15F5F; /* 마우스 오버 시 색상 변경 */
		}
		
		.card-body {
		  min-height: 70vh; /* viewport 높이의 50% */
		}
    	
    	#chart {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            align-items: center;
            justify-items: center;
            padding: 20px;
        }
        
        #chart div {
            text-align: center;
        }
    	
    </style>
    
  <!-- header -->
  <div class="page-header">
    <h3 class="page-title">
      <span class="page-title-icon bg-gradient-primary text-white me-2">
        <i class="mdi mdi-home"></i>
      </span> Test Result Content
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
    	<div>
	    
	        <h1 style="display: flex;">
	        	${test_name }
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
				<button onclick="location.href='testList.teacher'" class="btn btn-gradient-info py-3" style="height: 35px; display: flex; justify-content: center; align-items: center;">
					prev
				</button>
			</h1> <br>
	        
	        <p>
	            평균 : ${mean}
	        </p>
	        
	        <p>
	            분산 : ${variance }
	        </p>
	        
	        <p>
	            표준편차 : ${standard_deviation}
	        </p>
	        
	        <div id="chart">
		        <div>
		            막대 차트 <br>
		            <canvas id="stickChart" style="width: 300px; height: 300px;"></canvas>
		        </div>
		        
		        <div>
		            파이 차트 <br>
		            <canvas id="piChart" style="width: 300px; height: 300px;"></canvas>
		        </div>
		        
		        <div>
		            정규분포 <br>
		            <canvas id="normalDistChart" style="width: 300px; height: 300px;"></canvas>
		        </div>
	        </div>
	        
	        <br>
	        
	        <p>
	            <font size="5">불합격자 : </font>
	            <font size="5" color="red"> 
		            <c:forEach var="student" items="${fail}">
		                ${student}
		            </c:forEach>
	            </font>
	        </p>
	        
	    </div>
	   </div>
	  </div>
	 </div>
	</div>
    
<%@ include file = "teacherBottom.jsp"%>

