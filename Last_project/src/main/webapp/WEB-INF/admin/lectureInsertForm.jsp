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
	  width: 100px;
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
    	<h3 class="page-title">강좌개설</h3>
    </div>
    
    <div class="row">
	  <div class="col-lg-12 grid-margin stretch-card">
	    <div class="card">
	      <div class="card-body">
	      
	        <!-- 엑셀 업로드 -->
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="lectureExcelInsert.admin">
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
				    <i class="fa fa-plus-square" onclick="addLecture()"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" value="Create" class="btn btn-gradient-success py-3" onclick="submitForm('insertForm')">
				  </div>
				</div>
			  </div>
			</form>
			
			<!-- 직접 기입해서 업로드 -->
			<form name="insertForm" action="lectureInsert.admin" method="post">
			  <table class="table table-hover">
			    <thead>
			      <tr>
			        <th width=26%>강좌명</th>
			        <th width=8%>매니저</th>
			        <th width=8%>강사</th>
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
			            <option value="">매니저</option>
			            <c:forEach var="manager" items="${managerList}">
			              <option value="${manager.name}">${manager.name}</option>
			            </c:forEach>
			          </select>
			        </td>
			        <td>
			          <select name="teacher" class="form-select mr-2" required>
			            <option value="">강사</option>
			            <c:forEach var="teacher" items="${teacherList}">
			              <option value="${teacher.name}">${teacher.name}</option>
			            </c:forEach>
			          </select>
			        </td>
			        <td>
			          <div class="input-group">
			            <input type="text" id="startDate" name="lec_start" class="form-control datepicker" placeholder="시작일">
			            <label class="input-group-text" for="startDate">
			              <i class="fa fa-calendar-o"></i>
			            </label>
			          </div>
			        </td>
			        <td>
			          <div class="input-group">
			            <input type="text" id="endDate" name="lec_end" class="form-control datepicker" placeholder="종료일">
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

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"/></script>
	<script>
		function addLecture() {
		  var container = document.querySelector('tbody');
		  var newLecture = document.createElement('tr');
		  newLecture.innerHTML = `
		    <td><input type="text" name="lec_name" size="15" class="form-control mr-2" required></td>
		    <td>
		      <select name="manager" class="form-select mr-2" required>
		        <option value="">매니저</option>
		        <c:forEach var="manager" items="${managerList}">
		          <option value="${manager.name}">${manager.name}</option>
		        </c:forEach>
		      </select>
		    </td>
		    <td>
		      <select name="teacher" class="form-select mr-2" required>
		        <option value="">강사</option>
		        <c:forEach var="teacher" items="${teacherList}">
		          <option value="${teacher.name}">${teacher.name}</option>
		        </c:forEach>
		      </select>
		    </td>
		    <td>
		      <div class="input-group">
		        <input type="text" id="startDate" name="lec_start" class="form-control datepicker" placeholder="시작일">
		        <label class="input-group-text" for="startDate">
		          <i class="fa fa-calendar-o"></i>
		        </label>
		      </div>
		    </td>
		    <td>
		      <div class="input-group">
		        <input type="text" id="endDate" name="lec_end" class="form-control datepicker" placeholder="종료일">
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
		  `;		  
		  container.appendChild(newLecture);
		  
		  // 새로 추가된 tr 요소에 대해 datepicker 초기화
		  var startDateId = 'startDate_' + (container.children.length - 1);
		  var endDateId = 'endDate_' + (container.children.length - 1);
		  initDatepicker(startDateId, endDateId);
		  
		}
		function removeLecture(button) {
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

		function initDatepicker(startDateId, endDateId) {
		  var $startDate = $('#' + startDateId);
		  var $endDate = $('#' + endDateId);
	
		  $startDate.datepicker({
		    startDate: 'd',
		    daysOfWeekDisabled: [0, 6],
		    todayHighlight: true,
		    autoclose: true,
		    format: "yyyy-mm-dd",
		    language: "ko",
		    onSelect: function(date) {
		      $endDate.datepicker('setStartDate', date);
		      if ($endDate.val() < date) {
		        $endDate.datepicker('setDate', date);
		      }
		    },
		    beforeShowDay: function(date) {
		      var today = new Date();
		    }
		  });
	
		  $endDate.datepicker({
		    startDate: $startDate.val(),
		    daysOfWeekDisabled: [0, 6],
		    todayHighlight: true,
		    autoclose: true,
		    format: "yyyy-mm-dd",
		    language: "ko",
		    disabled: !$startDate.val(),
		    beforeShowDay: function(date) {
		      var startDate = $startDate.datepicker('getDate');
		    }
		  });
	
		  $startDate.on('change', function() {
		    $endDate.datepicker('setStartDate', $(this).val());
		    if ($endDate.val() < $(this).val()) {
		      $endDate.datepicker('setDate', '');
		    }
		    $endDate.datepicker('setDisabled', !$(this).val());
		  });
		}

		$(function() {
		  initDatepicker('startDate', 'endDate');
		});
				
		function submitForm(formName) {
		  document.forms[formName].submit();
		}
	</script>

<%@ include file="adminBarBottom.jsp" %>
    