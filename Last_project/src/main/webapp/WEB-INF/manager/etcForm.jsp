<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "managerBarTop.jsp"%>

<style>
.err {
    font-size: 9pt;
    color: red;
}
/* 초기에는 숨김 */
.member-list {
    display: none;
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
	    
	    window.onload = function() {
	        var today = new Date(); // 오늘 날짜 객체 생성
	        var dd = today.getDate(); // 오늘 날짜에서 '일' 부분 가져오기
	        var mm = today.getMonth() + 1; // 오늘 날짜에서 '월' 부분 가져오기 (0부터 시작하므로 +1)
	        var yyyy = today.getFullYear(); // 오늘 날짜에서 '년' 부분 가져오기

	        // 월과 일이 한 자리 수일 경우 앞에 0을 붙여서 두 자리로 만듭니다.
	        if (dd < 10) {
	            dd = '0' + dd;
	        }
	        if (mm < 10) {
	            mm = '0' + mm;
	        }

	        // 최소 날짜를 오늘 날짜로 설정
	        var minDate = yyyy + '-' + mm + '-' + dd;
	        document.getElementsByName('etc_fdate')[0].setAttribute('min', minDate);
	    };
	    
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
	    
	    function allCheck(obj) {
	        var rcheck = document.getElementsByName("selected_mem_num");
	        var check = obj.checked;
	        for (var i = 0; i < rcheck.length; i++) {
	            rcheck[i].checked = check;
	        }
	    }
	    
	    
	</script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
    // jQuery를 이용하여 document.ready 이벤트 설정
    $(document).ready(function() {
        // 보낼 사람 선택 체크박스에 대한 클릭 이벤트 설정
        $('input[name="check_num"]').change(function() {
            // 선택된 보낼 사람 수 구하기
            var checkedCount = $('input[name="check_num"]:checked').length;

            // 선택된 보낼 사람이 하나 이상인 경우에만 보이도록 설정
            if (checkedCount > 0) {
                $('.member-list').show(); // 보이기
            } else {
                $('.member-list').hide(); // 숨기기
            }
        });

        // 폼 제출 전에 보낼 사람이 선택되었는지 확인
        $('#form').submit(function(e) {
            var selectedCount = $('input[name="selected_mem_num"]:checked').length;
            if (selectedCount === 0) {
                alert('보낼 사람을 한 명 이상 선택해주세요.');
                e.preventDefault(); // 폼 제출 중단
            }
        });
    });
    
    $(function(){
        $('#textBox').keyup(function (e) {
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
   
   
    });
    
    

    
</script>
    
    <div class="col-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">문서 보내기</h4>
        <form:form id="form" commandName="etc" action="etc.manager" method="post" enctype="multipart/form-data" acceptCharset="UTF-8" class="forms-sample">
                    <input type="hidden" name="etc_delete" value="MS">
                	<input type="hidden" name="sender_num" value="${sender_num}">
                    
                    <label>
                        <input type="checkbox" class="send-to" name="check_num" class="form-check-input"> 
                    </label>
                보낼 사람 선택
        <div class="member-list">
                <!-- 보낼 사람이 선택되었을 때 보이는 부분 -->
                <input type="checkbox" onclick="allCheck(this)" class="form-check-input">전체선택
                <hr>
                <c:forEach var="m" items="${mlist}">
                    <label>
                        <input type="checkbox" name="selected_mem_num" value="${m.mem_num}" class="form-check-input"> ${m.name}
                    </label><br>
                </c:forEach><br><br>
               </div>
               
                      <div class="form-group">
                        <label for="exampleInputName1">제목</label>
                        <input type="text" class="form-control" id="exampleInputName1" placeholder="제목입력" name="etc_title" value="${etc.etc_title}">
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
                        <textarea id="textBox" class="form-control" id="exampleTextarea1" rows="4" name="etc_content">${etc.etc_content}</textarea>
                        <form:errors path="etc_content" cssClass="err"/>
                      </div>
                      <div class="form-group">
                      <label for="exampleTextarea1">희망 마감 날짜</label>
                      	<div class="input-group">
                      	<input type="date" name="etc_fdate" value="${etc.etc_fdate}"  class="form-control">
                		<form:errors path="etc_fdate" cssClass="err"/>
                      	</div>
                      </div>
                      <button type="submit" class="btn btn-gradient-primary me-2">보내기</button>
                      <button class="btn btn-light">취소</button>
                    </form:form>
                  </div>
                </div>
              </div>
    
    
    
<%@include file = "managerBarBottom.jsp"%>