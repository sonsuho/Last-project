<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminBarTop.jsp" %>

	<style>
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
	  width: 150px;
	}
	th, td{
	  text-align: center;
	  margin: auto;
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
	</style>
	
	<div class="page-header">
    	<h3 class="page-title">직원 아이디 생성</h3>
    </div>
    
    <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	      
	        <!-- 엑셀 업로드 -->
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="excelInsert.admin">
			  <div class="row">
			    <div class="col-md-4 ">
			      <div class="input-group">
			        <input type="file" id="excelInput" name="excelInput" accept=".xls,.xlsx" style="width: 300px;" class="form-control file-upload-info">
			        <span class="input-group-append">
			          <span class="btn_pack medium icon">
			            <span class="excel"></span>
			            <input type="button" onclick="check()" value="Upload" class="file-upload-browse btn btn-gradient-info py-3">
			          </span>
			        </span>
			      </div>
			    </div>
			    <div class="col-md-8 d-flex justify-content-end">
				  <div class="form-group d-flex align-items-center">
				    <i class="fa fa-plus-square" onclick="addId()"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" value="Create" class="btn btn-gradient-success py-3" onclick="submitForm('insertForm')">
				  </div>
				</div>
			  </div>
			</form>
			
			<!-- 직접 기입해서 업로드 -->
			<form name="insertForm" action="idInsert.admin" method="post">
			  <table class="table table-hover">
			    <thead>
			      <tr>
			        <th width=14%>이름</th>
		    		<th width=16%>아이디</th>
		    		<th width=16%>비밀번호</th>
		    		<th width=10%>카테고리</th>
		    		<th width=20%>전화번호</th>
		    		<th width=20%>이메일</th>
		    		<th>제거</th>
			      </tr>
			    </thead>
			    <tbody>
			      <tr>
			        <td><input type="text" name="name" placeholder="이름" size="4" class="form-control mr-2" required></td>
			        <td><input type="text" name="id" placeholder="아이디" size="10" class="form-control mr-2" required></td>
			        <td><input type="password" name="pw" placeholder="비밀번호" size="5" class="form-control mr-2" required></td>
			        <td>
			          <select name="category" class="form-select mr-2" required>
			            <option value="">카테고리
			            <option value="manager">매니저
		                <option value="teacher">강사
			          </select>
			        </td>
			        <td><input type="text" name="phone" placeholder="'-' 없이 숫자만 입력" size="15" class="form-control mr-2" required></td>
			        <td>
			          <span class="input-group">
					    <input type="text" name="email" id="email" class="form-control" placeholder="email" aria-label="email" aria-describedby="basic-addon2">
					    <label class="input-group-text" id="basic-addon2">@ google.com</label>
					  </span>
			        </td>
			        <td>
			        </td>
			      </tr>
			    </tbody>
			  </table>
			</form>

	
		  </div>
	    </div>
	  </div>
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"/></script>
	<script>
		function addId() {
		  var container = document.querySelector('tbody');
		  var newId = document.createElement('tr');
		  newId.innerHTML = `
			  <tr>
		        <td><input type="text" name="name" placeholder="이름" size="4" class="form-control mr-2" required></td>
		        <td><input type="text" name="id" placeholder="아이디" size="10" class="form-control mr-2" required></td>
		        <td><input type="password" name="pw" placeholder="비밀번호" size="5" class="form-control mr-2" required></td>
		        <td>
		          <select name="category" class="form-select mr-2" required>
		            <option value="">카테고리
		            <option value="manager">매니저
	                <option value="teacher">강사
		          </select>
		        </td>
		        <td><input type="text" name="phone" placeholder="'-' 없이 숫자만 입력" size="15" class="form-control mr-2" required></td>
		        <td>
		          <span class="input-group">
				    <input type="text" name="email" id="email" class="form-control" placeholder="email" aria-label="email" aria-describedby="basic-addon2">
				    <label class="input-group-text" id="basic-addon2">@ google.com</label>
				  </span>
		        </td>
		        <td>
		          <i class="fa fa-minus-square" onclick="removeId(this)"></i>
		        </td>
		      </tr>
		  `;		  
		  container.appendChild(newId);
		}
		function removeId(button) {
		  var row = button.closest('tr');
		  row.remove();
		}

		/* 엑셀파일 체크 */
        function checkFileType(filePath){
            var fileFormat = filePath.split("."); 
            if(fileFormat.indexOf("xls") >-1 || fileFormat.indexOf("xlsx") > -1){
                return true;
            }else{
                return false;
            }
        }
    
        /*엑셀 업로드처리*/
        function check() {
            var file = document.getElementById('excelInput').value;
            if(file == "" || file == null ){
                alert('파일을 선택해주세요.');
                return false;
            }else if(!checkFileType(file)){
                alert('엑셀 파일만 업로드 가능합니다.');
                $("#excelUploadForm")[0].reset();
                return false;
            }
            if(confirm("업로드 하시겠습니까?")){
                var options = {
                    success:function(data){
                        console.log("data: ",data);
                        alert('엑셀파일이 업로드 되었습니다.');
                        w2ui['statisticInfoGrid'].reload();
                        $("#excelInput").val("");
                    },
                    type:"POST"
                };
                $("#excelUploadForm").ajaxSubmit(options);
				location.href = "emplList.admin";
            }   
        }
				
		function submitForm(formName) {
		  document.forms[formName].submit();
		}
	</script>

<%@ include file="adminBarBottom.jsp" %>
    