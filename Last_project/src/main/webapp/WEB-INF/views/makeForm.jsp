<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>

<style type="text/css">
        
        /* Flexbox container for centering content */
        #content {
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align items to the start to maintain the top alignment */
            flex-wrap: wrap; /* Allow items to wrap */
        }
        
        /* Individual chat room sections */
        .chat-section {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            width: 300px;
            background-color: #f8f9fa;
            min-height: 400px; /* Fixed height */
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* Align items to the top within the section */
        }
        
        .chat-section h1 {
            font-size: 1.5rem;
            color: #007bff;
            margin-bottom: 10px;
        }
        
        .chat-room {
            margin-bottom: 10px;
        }
        
        /* Table styles */
        table {
            margin-bottom: 20px;
            width: 100%;
        }
        
        table th {
            padding: 10px;
        }

        /* Custom styles for the form */
        .form-label {
            font-size: 1rem;
            font-weight: bold;
            color: #007bff;
            margin-right: 10px;
            margin-bottom: 0;
        }

    </style>

	<!-- header -->
	<div class="page-header">
	    <h3 class="page-title">
	        <span class="page-title-icon bg-gradient-primary text-white me-2">
	            <i class="mdi mdi-home"></i>
	        </span> Study Group 만들기
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
	                <div class="text-center">
	                    <h2 align="left" style="padding-left: 200px; font-weight: bold;">채팅방 만들기</h2> <br><br>
	                    
	                    <form action="make.chat" method="post">
	                    
							<div style="display: flex; align-items: center; padding-left: 210px;">
							    <label for="chatNameInput" class="form-label mb-0">채팅방 이름</label>
							    
							    <input type="text" class="form-control mx-2" id="chatNameInput" name="chat_name" placeholder="채팅방 이름을 입력하세요" required style="width: 25%;">
							    
							    <button type="submit" class="btn btn-primary">만들기</button>
							</div>

	                    </form>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<%@ include file="studentBottom.jsp"%>
