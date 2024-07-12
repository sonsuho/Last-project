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
	th, td{
	  text-align: center;
	  margin: auto;
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
	  color: #18CCA8; /* 마우스 오버 시 색상 변경 */
	}
	.card-body {
	  min-height: 70vh; /* viewport 높이의 50% */
	}
	</style>
	
	<div class="page-header">
   	<h3 class="page-title">강좌개설</h3>
  </div>
    
  <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	      
	        <!-- 엑셀 업로드 -->
					<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="lectureExcelInsert.admin">
					  <div class="row">
					    <div class="col-md-5 ">
					      <div class="input-group">
					        <input type="file" id="excelInput" name="excelInput" accept=".xlsx" style="width: 200px;" class="form-control file-upload-info">
					        <span class="input-group-append">
					          <span class="btn_pack medium icon">
					            <span class="excel"></span>
					            <button type="button" onclick="check()" class="file-upload-browse btn btn-gradient-info py-3">
					            	업로드
					            	<i class="mdi mdi-upload btn-icon-prepend"></i>
					            </button>
					            <input type="button" onclick="location.href='lectureExcelDownload.admin'" value="양식다운" class="file-upload-browse btn btn-gradient-dark py-3">
					          </span>
					        </span>
					      </div>
					    </div>
					    <div class="col-md-7 d-flex justify-content-end">
						  	<div class="form-group d-flex align-items-center">
							    <i class="fa fa-plus-square" onclick="addLecture()"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							    <input type="button" value="강좌개설" class="btn btn-gradient-success py-3" onclick="submitForm('insertForm')">
						  	</div>
							</div>
					  </div>
					</form>
					
					<!-- 직접 기입해서 업로드 -->
					<form name="insertForm" action="lectureInsert.admin" method="post">
					  <table class="table table-hover">
					    <thead>
					      <tr>
					        <th width=20%>강좌명</th>
					        <th width=11%>매니저</th>
					        <th width=11%>강사</th>
					        <th width=18%>시작일</th>
					        <th width=18%>종료일</th>
					        <th width=9%>학생수</th>
					        <th width=9%>반이름</th>
					        <th>제거</th>
					      </tr>
					    </thead>
					    <tbody>
					      <tr>
					        <td><input type="text" name="lec_name" size="15" class="form-control mr-2" required></td>
					        <td>
					          <select name="manager" class="form-select mr-2" required>
					            <option value="" style="color:#b4b4b4;">매니저</option>
					            <c:forEach var="manager" items="${managerList}">
					              <option value="${manager.mem_num}">${manager.name}</option>
					            </c:forEach>
					          </select>
					        </td>
					        <td>
					          <select name="teacher" class="form-select mr-2" required>
					            <option value="" style="color:#b4b4b4;">강사</option>
					            <c:forEach var="teacher" items="${teacherList}">
					              <option value="${teacher.mem_num}" >${teacher.name}</option>
					            </c:forEach>
					          </select>
					        </td>
					        <td>
					          <div class="input-group">
					            <input type="text" id="startDate" name="lec_start" class="form-control datepicker" placeholder="시작일" required>
					            <label class="input-group-text" for="startDate">
					              <i class="fa fa-calendar-o"></i>
					            </label>
					          </div>
					        </td>
					        <td>
					          <div class="input-group">
					            <input type="text" id="endDate" name="lec_end" class="form-control datepicker" placeholder="종료일" required>
					            <label class="input-group-text" for="endDate">
					              <i class="fa fa-calendar-o"></i>
					            </label>
					          </div>
					        </td>
					        <td><input type="number" name="stu_cnt" size="1" min="10" max="30" class="form-control mr-2" required></td>
					        <td>
					          <% String[] class_name = {"A","B","C","D","E","F","G","H"}; %>
					          <select name="class_name" class="form-select mr-2" required>
					            <option value="">반</option>
					            <c:forEach var="class_name" items="<%=class_name%>">
					              <option value="${class_name}">${class_name}</option>
					            </c:forEach>
					          </select>
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

	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"/></script> -->
	<script>
		// 모든 select 요소 선택
		var selectOptions = document.querySelectorAll('select');
	
		// 각 select 요소에 change 이벤트 리스너 등록
		selectOptions.forEach(function(selectOption) {
		  selectOption.addEventListener('change', function() {
		    // 선택된 옵션의 색상 변경
		    if (this.selectedIndex == 0) {
		      this.style.color = '#b4b4b4';
		    } else {
		      this.style.color = 'black';
		    }
		  });
		});
	
		function addLecture() {
		  var container = document.querySelector('tbody');
		  var newLecture = document.createElement('tr');
		  newLecture.innerHTML = `
	      <tr>
	        <td><input type="text" name="lec_name" size="15" class="form-control mr-2" required></td>
	        <td>
	          <select name="manager" class="form-select mr-2" required>
	            <option value="" style="color:#b4b4b4;">매니저</option>
	            <c:forEach var="manager" items="${managerList}">
	              <option value="${manager.mem_num}">${manager.name}</option>
	            </c:forEach>
	          </select>
	        </td>
	        <td>
	          <select name="teacher" class="form-select mr-2" required>
	            <option value="" style="color:#b4b4b4;">강사</option>
	            <c:forEach var="teacher" items="${teacherList}">
	              <option value="${teacher.mem_num}" >${teacher.name}</option>
	            </c:forEach>
	          </select>
	        </td>
	        <td>
	          <div class="input-group">
	            <input type="text" id="startDate" name="lec_start" class="form-control" placeholder="시작일" required>
	            <label class="input-group-text" for="startDate">
	              <i class="fa fa-calendar-o"></i>
	            </label>
	          </div>
	        </td>
	        <td>
	          <div class="input-group">
	            <input type="text" id="endDate" name="lec_end" class="form-control" placeholder="종료일" required>
	            <label class="input-group-text" for="endDate">
	              <i class="fa fa-calendar-o"></i>
	            </label>
	          </div>
	        </td>
	        <td><input type="number" name="stu_cnt" size="1" min="10" max="30" class="form-control mr-2" required></td>
	        <td>
	          <select name="class_name" class="form-select mr-2" required>
	            <option value="">반</option>
	            <c:forEach var="class_name" items="<%=class_name%>">
	              <option value="${class_name}">${class_name}</option>
	            </c:forEach>
	          </select>
	        </td>
	        <td>
		      	<i class="fa fa-minus-square" onclick="removeLecture(this)"></i>
		   		</td>
	      </tr>
		  `;		  		  
		  container.appendChild(newLecture);
		}
		
		function removeLecture(button) {
		  var row = button.closest('tr');
		  row.remove();
		}

		/* 엑셀파일 체크 */
    function checkFileType(filePath){
      var fileFormat = filePath.split("."); 
      if(fileFormat.indexOf("xlsx") > -1){
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
				location.href = "lectureList.admin";
      }   
    }

		function submitForm(formName) {
			var form = document.forms[formName];
		  if (validateForm(form)) {
			  var insert = confirm("이대로 강좌를 개설하시겠습니까?");
			  if(insert){
		    	form.submit();
			  }
		  }
		}

		function validateForm(form) {
		  var isValid = true;
		  var formElements = form.elements;

		  for (var i = 0; i < formElements.length; i++) {
		    var element = formElements[i];
		    if (element.required && (element.value.trim() === '')) {
		      isValid = false;
		      element.classList.add('is-invalid');
		    } else {
		      element.classList.remove('is-invalid');
		    }
		  }

		  return isValid;
		}
	</script>

	<%@ include file="adminBarBottom.jsp" %>
	<script src="resources/js/jquery.form.js"></script>
    