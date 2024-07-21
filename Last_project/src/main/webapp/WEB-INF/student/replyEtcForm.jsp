<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../common/common.jsp"%>

<!-- plugins:css -->
	<link rel="stylesheet" href="resources/assets/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="resources/assets/vendors/ti-icons/css/themify-icons.css">
	<link rel="stylesheet" href="resources/assets/vendors/css/vendor.bundle.base.css">
	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css">
	<!-- endinject -->
	<!-- Plugin css for this page -->
	

	<link rel="stylesheet" href="resources/assets/vendors/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" href="resources/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<!-- endinject -->
	<!-- Layout styles -->
	<link rel="stylesheet" href="resources/assets/css/style.css">
	<!-- End layout styles -->
	<link rel="shortcut icon" href="resources/assets/images/favicon.png" />
<style>
.err {
    font-size: 9pt;
    color: red;
}

.selected-item {
        background-color: #f2f2f2;
        padding: 5px;
        border-radius: 5px;
    }
</style>

<script type="text/javascript">
	    function checkFileInput() {
	        var fileInput = document.getElementsByName('multiFile')[0];
	        var uploadField = document.getElementsByName('etc_file')[0];
	        
	        if (fileInput.files.length > 0) {
	            uploadField.value = '파일 존재';
	        } else {
	            uploadField.value = '';
	        }
	    }
	    
	     //드래그
	    (function () {
	        var $file = document.getElementById("multiFile")
	        var dropZone = document.querySelector(".drop-zone")
	     
	        var toggleClass = function (className) {
	     
	           console.log("current event: " + className)
	     
	           var list = ["dragenter", "dragleave", "dragover", "drop"]
	     
	           for (var i = 0; i < list.length; i++) {
	              if (className === list[i]) {
	                 dropZone.classList.add("drop-zone-" + list[i])
	              } else {
	                 dropZone.classList.remove("drop-zone-" + list[i])
	              }
	           }
	        }
	     
	        var showFiles = function (files) {
	           dropZone.innerHTML = ""
	           for (var i = 0, len = files.length; i < len; i++) {
	              dropZone.innerHTML += "<p>" + files[i].name + "</p>"
	           }
	        }
	     
	        var selectFile = function (files) {
	           // input file 영역에 드랍된 파일들로 대체
	           $file.files = files
	           showFiles($file.files)
	     
	        }
	     
	        $file.addEventListener("change", function (e) {
	           showFiles(e.target.files)
	        })
	     
	        // 드래그한 파일이 최초로 진입했을 때
	        dropZone.addEventListener("dragenter", function (e) {
	           e.stopPropagation()
	           e.preventDefault()
	     
	           toggleClass("dragenter")
	        })
	     
	        // 드래그한 파일이 dropZone 영역을 벗어났을 때
	        dropZone.addEventListener("dragleave", function (e) {
	           e.stopPropagation()
	           e.preventDefault()
	     
	           toggleClass("dragleave")
	        })
	     
	        // 드래그한 파일이 dropZone 영역에 머물러 있을 때
	        dropZone.addEventListener("dragover", function (e) {
	           e.stopPropagation()
	           e.preventDefault()
	     
	           toggleClass("dragover")
	        })
	     
	        // 드래그한 파일이 드랍되었을 때
	        dropZone.addEventListener("drop", function (e) {
	           e.preventDefault()
	     
	           toggleClass("drop")
	     
	           var files = e.dataTransfer && e.dataTransfer.files
	           console.log(files)
	     
	           if (files != null) {
	              if (files.length < 1) {
	                 alert("폴더 업로드 불가")
	                 return
	              }
	              selectFile(files)
	           } else {
	              alert("ERROR")
	           }
	     
	        })
	     })();
	    
	    
	</script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 최소 날짜를 오늘 날짜로 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
    var yyyy = today.getFullYear();
    var minDate = yyyy + '-' + mm + '-' + dd;

    $('input[name="etc_fdate"]').attr('min', minDate);

});

    $('#textBox2').keyup(function() {
        var content = $(this).val();

        // 글자수 세기
        if (content.length == 0 || content == '') {
            $('.textCount').html('0자');
        } else {
            $('.textCount').html(content.length + '자');
        }

        // 글자수 제한
        if (content.length > 200) {
            // 200자 이상 입력되면 제한
            $(this).val(content.substring(0, 200));
            // 200자 초과 알림
            alert('글자수는 200자까지 입력 가능합니다.');
        }
    });
    
 // 모달 닫기 버튼 처리
     $("#Modal").click(function() {
            $('#secondModal').modal('hide'); // 모달 숨기기
            $("#formContainer").hide(); 
        });
        
    
        $("#close").click(function() {
            $('#secondModal').modal('hide');
            $("#formContainer").hide(); // 폼을 감싸는 div를 숨김
        });


    $(function() {
        $('#btnSave2').click(function() {
            var title = $('input[name="etc_title"]').val().trim();
            var content = $('textarea[name="etc_content"]').val().trim();
            var selectedDate = $('input[name="etc_fdate"]').val().trim();

            // 유효성 검사
            if (title.length === 0) {
                alert('제목을 입력해주세요.');
                return false; // 폼 제출 중단
            }
            if (content.length === 0) {
                alert('내용을 입력해주세요.');
                return false; // 폼 제출 중단
            }
            if (selectedDate.length === 0) {
                var today = new Date(); // 오늘 날짜 객체 생성
                var selected = new Date(selectedDate); // 선택한 날짜 객체 생성
                alert('날짜를 선택해주세요.');
                return false;
                
            }
                
            // 유효성 검사 통과 시 폼 제출
            return true;
        });
    });

    
</script>
    
   <!--답장 모달 -->
				<div id="formContainer">
      			<form:form id="form" commandName="etc" action="replyEtc.student" method="post" enctype="multipart/form-data" acceptCharset="UTF-8" class="forms-sample">

                    <input type="hidden" name="etc_delete" value="MS">
                	<input type="hidden" name="sender_num" value="${sender_num}">
                    
                보낼 사람<br>
                <hr>
                    <label>
                        <input type="checkbox" name="mem_num" value="${mb.mem_num}" class="form-check-input" checked> ${mb.name}
                    </label><br>
                <br>
                      <div class="form-group">
                        <label for="exampleInputName1">제목</label>
                        <input type="text" class="form-control" id="exampleInputName1" placeholder="제목입력" name="etc_title" value="Re:[${eb.etc_title}]">
               			 <form:errors path="etc_title" cssClass="err"/>
                      </div>
                      
                      <div class="form-group">
                        <label>드래그나 클릭으로 업로드</label>
                        <div id="fileUpload" class="drop-zone">
                        <input name="multiFile" class="file-upload-browse btn btn-gradient-primary py-3" onchange="checkFileInput()" multiple type="file" placeholder="드래그하세요"/>
                        </div>
                        <input type="hidden" name="etc_file_path" value="C:/sts2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Last_project/resources/files/"><br>
						<input type="hidden" name="etc_file" value="" readonly>
                        <div class="input-group col-xs-12">
                          <span class="input-group-append">
                          </span>
                        </div>
                      </div>
                    
                      <div class="form-group">
                        <label for="exampleTextarea1">내용</label>
                        <div class="textLengthWrap">
            				<span class="textCount">0</span> / <span class="textTotal">200</span>자
        				</div>
                        <textarea id="textBox2" class="form-control" id="exampleTextarea1" rows="4" name="etc_content">${etc.etc_content}</textarea>
                        <form:errors path="etc_content" cssClass="err"/>
                      </div>
                      <div class="form-group">
                      <label for="exampleTextarea1">희망 마감 날짜</label>
                      	<div class="input-group">
                      	<input type="date" name="etc_fdate" value="${etc.etc_fdate}"  class="form-control">
                		<form:errors path="etc_fdate" cssClass="err"/>
                      	</div>
                      </div>
                      <button type="submit" id="btnSave2" class="btn btn-gradient-primary me-2 save" data-action="save">전송</button>
      				<button type="button" class="btn btn-secondary" data-dismiss="modal" id="close">닫기</button>
      			</form:form>
            </div>

    
    
    