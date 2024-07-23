<%@page import="member.model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="managerBarTop.jsp"%>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.0.0/js/bootstrap.min.js"></script>

<style>
    .container {
        display: flex;
        transition: all 0.5s ease;
    }
    .left-panel, .right-panel {
        padding: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background: #fff;
        transition: all 1s ease;
    }
    .left-panel {
        flex: 1;
    }
    .right-panel {
        flex: 0;
        display: none;
        max-width: 0;
        overflow: hidden;
       
    }
    .container.expanded .left-panel {
        flex: 1;
    }
    .container.expanded .right-panel {
        display: block;
        flex: 1;
        max-width: 100%;
    }
    .sub-next-title { color: #9a9a9a;  cursor: pointer;}
	.sub-next-title:hover {color: #b66dff; transition: 0.2s; }
	
	span{
		margin-right: 5;
	}
	
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
    
    .btn-fixed-width {
            width: 90px;
        }
	
</style>
<script>
        function allDelete(obj) {
            var rcheck = document.getElementsByName("rowcheck");
            var check = obj.checked;
            for (var i = 0; i < rcheck.length; i++) {
                rcheck[i].checked = check;
            }
        }

        function selectDelete() {
            var rcheck = document.getElementsByName("rowcheck");
            var flag = false;
            for (var i = 0; i < rcheck.length; i++) {
                if (rcheck[i].checked) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                alert("삭제할 문서를 선택하세요");
                return;
            }
            document.myform.action = "selectDeleteEtc.manager";
            document.myform.submit();
        }


function requestList(mem_num){
	location.href="request.manager?mem_num="+mem_num;
}
function etcList(mem_num) {
    location.href = "etcList.manager?mem_num="+mem_num;
}
function etcSendList(sender_num){
	location.href="etcSendList.manager?sender_num="+sender_num;
}
function requestList2() {
    location.href = "request2.manager";
}

//화면 분할
function openDetail(etc_num) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'etcDetail.manager?etc_num=' + etc_num, true);
    xhr.onload = function() {
        if (xhr.status === 200) {
            document.getElementById('rightPanel').innerHTML = xhr.responseText;
            document.getElementById('container').classList.add('expanded');
        }
    };
    xhr.send();
}

</script>
<body>
<div class="container" id="container">
    <div class="left-panel" id="leftPanel">
        <div class="page-header">
	<h3 class="page-title" style="font-weight:700;">
		<span class="sub-next-title" onclick="requestList('${loginInfo.mem_num}')">받은 결재함</span> 
		<span>받은 문서함</span>
		<span class="sub-next-title" onclick="etcSendList('${loginInfo.mem_num}')">보낸 문서함</span>
		<span class="sub-next-title" onclick="requestList2()">결재 목록</span>
	</h3>
		<nav aria-label="breadcrumb">
        	<div class="input-group-append">
            <button class="btn btn-sm btn-gradient-primary py-3" type="button" data-bs-toggle="modal" data-bs-target="#firstModal" id="openFirstModal"><i class="mdi mdi-email"></i> &nbsp;&nbsp; 문서 보내기</button>
            </div>
        </nav>
		</div>
		
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                
                <div class="row">
                <div class="col-lg-8"></div>
				        <div class="col-lg-4">
	                     	<form action="etcList.manager" style="display:flex;">
	                     		<input type="hidden" name="whatColumn" value="all">
								<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">		                        
								<input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2" style="width: 400px;">
		                        <button type="submit" class="btn btn-sm btn-success py-3 btn-fixed-width" type="button">검색</button>
								<input type="button" value="일괄삭제" onclick="selectDelete()" class="btn btn-sm btn-gradient-danger py-3"> 
	                        </form>
				        </div>
	                </div>
		
		<form method="post" name="myform" action="selectDeleteEtc.manager">
		<input type="hidden" name="etc_delete" value="M"> 
		<input type="hidden" name="mem_num" value="${loginInfo.mem_num}">
		<table class="table table-hover">
		<thead>
			<tr class="table-danger">
				<td><input type="checkbox" onclick="allDelete(this)" class="form-check-input"></td>
				<td colspan="2">제목</td>
                <td>이름</td>
                <td colspan="2">날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${elist == null || elist.isEmpty()}">
					<tr>
						<td colspan="3" style="text-align: center;">문서가 없습니다</td>
					
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="e" items="${elist }">
						<c:if test="${fn:contains(e.etc_delete , 'M')}">
							<tr>
								<td><input type="checkbox" value="${e.etc_num }" name="rowcheck" class="form-check-input"></td>
								<td>
								<a href="javascript:void(0);" onclick="openDetail(${e.etc_num})">${e.etc_title}</a><br>
								</td>
								<td>${e.etc_content }</td>
								<td>${e.memberName}</td>
								<td>
									<fmt:parseDate var="fmtdate" value="${e.etc_sdate }" pattern="yyyy-MM-dd HH:mm" /> 
									<fmt:formatDate value="${fmtdate }" pattern="yyyy-MM-dd HH:mm" />
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</form>


                    <center>${pageInfo.getPagingHtml() }</center>
                </div>
            </div>
        </div>
    </div>
    <div class="right-panel" id="rightPanel">
        <!-- 문서 상세 내용이 여기에 표시됩니다 -->
        <h2>문서 내용을 선택하세요</h2>
    </div>
</div>

<!-- 모달 -->
<div class="modal fade" id="firstModal" tabindex="-1" aria-labelledby="etcModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="etcModalLabel">문서 보내기</h5>
        
         <i class="fa fa-times" id="closeModal"></i>

      </div>
      <div class="modal-body">
        <!-- request form -->
         <form:form id="form" commandName="etc" action="etc.manager" method="post" enctype="multipart/form-data" acceptCharset="UTF-8" class="forms-sample">
                    <input type="hidden" name="etc_delete" value="MS">
                	<input type="hidden" name="sender_num" value="${loginInfo.mem_num}">
                    
                    <div class="mb-3" style="position:relative;">
		            <label class="col-form-label">받는 사람</label>
		            <div class="input-group-append">
               			<button class="btn btn-sm btn-inverse-success" type="button" onclick="toggleThirdModal()"> 받는 사람 선택</button>
               		</div>
               		
                    <div class="seleted_list"></div>
               		
               		<div id="thirdModal" class="third_modal" style="display:none;">
               			<!-- 받는 사람 리스트 -->
               			<div class="wrap flex-wrap">
							<div class="form-check">
                              <label class="form-check-label">
                              <input type="checkbox" class="form-check-input" name="allcheck" onclick="allCheck(this)">전체선택</label>
                            </div>
               				<ul class="msg_list">
               					<li>
									<c:set var="loginInfo" value="${loginInfo}" />
									<c:forEach var="mb" items="${admin }">
										<c:if test="${loginInfo.category != 'student' }">
										<b>관리자</b>
											<ul>
												<li>
													<div class="form-check">
						                              <label class="form-check-label">
						                              <input type="checkbox" class="form-check-input item" name="rowcheck" value="${mb.mem_num }" onchange="rowCheck()">${mb.name }</label>
						                            </div>
												</li>
											</ul>
										</c:if>
									</c:forEach>
								</li>
								<li>
									<b>학생</b>
									<ul>
										<c:forEach var="mb" items="${studentlist }">
											<c:if test="${mb.mem_num != loginInfo.mem_num }">
												<li>
													<div class="form-check">
						                              <label class="form-check-label">
						                              <input type="checkbox" class="form-check-input item" name="rowcheck" value="${mb.mem_num }" onchange="rowCheck()">${mb.name }</label>
						                            </div> 
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
								
							</ul>
               			</div>
               		
						
						<!-- 선택된 사람 노출 -->
						<div class="wrap" style="position: relative; width: 100%;">
							<div style="padding: 5px 0 5px 10px;">
								<b>받는 사람 목록</b>
							</div>
							<div id="selectedItems">
								<!--ajax 선택된 사람 리스트 노출 -->
								
							</div>
							<div class="btn-add"><button class="btn btn-gradient-success btn-sm" onclick="return selectedPeople()">추가하기</button></div>
						</div>
					</div>
               		
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
          <button type="submit" id="btnSave" class="btn btn-gradient-primary me-2 save" data-action="save">전송</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnclose">닫기</button>
        </form:form>
      </div>
    </div>
  </div>
</div>

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
	        var rcheck = document.getElementsByName("rowcheck");
	        var check = obj.checked;
	        for (var i = 0; i < rcheck.length; i++) {
	            rcheck[i].checked = check;
	        }
	    }
	    
	    function toggleThirdModal() {
	        const thirdModal = document.getElementById('thirdModal');
	        thirdModal.style.display = thirdModal.style.display === 'none' ? 'block' : 'none';
	    }
	        
	        
	    function selectedPeople(){
			var flag = false;
			
			var rcheck = document.getElementsByName("rowcheck");
			
			for(var i=0; i<rcheck.length; i++){
				if(rcheck[i].checked == true){
					flag = true;
					break;
				}
			}
			
			if(!flag) {
				alert("받는 사람을 선택하세요.");
				return false;
			}
	        
	     // 선택된 사람들 가져오기
		    var selectedItems = [];
		    for (var i = 0; i < rcheck.length; i++) {
		        if (rcheck[i].checked) {
		            var personName = rcheck[i].parentNode.textContent.trim(); // 체크박스 레이블의 이름 가져오기
		            var personId = rcheck[i].value; // 체크박스의 값(ID) 가져오기
		            selectedItems.push({id: personId, name: personName});
		        }
		    }

		    // selected_list 영역에 추가하기
		    var selectedList = document.querySelector(".seleted_list");
		    selectedList.innerHTML = ""; // 기존 내용 초기화
		    selectedItems.forEach(function(person) {
		        var personElement = document.createElement("div");
		        personElement.textContent = person.name;
		        personElement.setAttribute("data-id", person.id); // ID를 데이터 속성으로 추가
		        selectedList.appendChild(personElement);
		    });
			
			
			//받는사람 모달 팝업 닫기 
			$('#thirdModal').hide();
			return false;
	    }
	    
	 // 체크박스 선택 했을 시 배열에 담기
	    function allCheck(checkbox) {
	   	    // 전체 선택 체크박스가 체크되었는지 여부를 확인
	   	    let isChecked = $(checkbox).prop('checked');
	   	    
	   	    // rowcheck 체크박스들의 값을 모두 선택 또는 해제
	   	    $('input[name="rowcheck"]').prop('checked', isChecked);
	   	    
	   	    // 모든 체크된 체크박스의 값을 업데이트
	   	    updateSelectedItems();
	    }
	     
	    
	    // 받는 사람 선택에서 체크박스 선택 
	     function rowCheck(){
	     	updateSelectedItems();
	     };
	     
	     // ajax 
	     // 받는 사람 체크된 사람 mem_num 배열로 만들어 이름 가져오기 
	     // 오른쪽에 리스트로 보여주기 
	     function updateSelectedItems() {
	  		let selectedItems = [];
	  		
	  		$('input[name="allcheck"]:checked').each(function() {
	  		    let value = $(this).val(); // 체크박스의 값 가져오기
	  		    if (!isNaN(value)) { // 숫자인지 확인
	  		        selectedItems.push(parseInt(value)); // 숫자로 변환하여 배열에 추가
	  		    }
	  		});
	  		
	  		
	  		$('input[name="rowcheck"]:checked').each(function() {
	              selectedItems.push( parseInt($(this).val()) );
	        });
	  		
	  		$.ajax({
	  			url : 'selectedList.student',
	  			method : 'POST',
	  			contentType : 'application/json',
	  			data : JSON.stringify(selectedItems),
	  			dataType: 'json',
	  			success: function(response){
	  				
	  				 $('#selectedItems').empty(); // 기존 리스트 초기화
	  				 
	                 $.each(response, function(index, item) {
	                     $('#selectedItems').append('<div><span><img src="resources/user.png" width="36px; margin-right: 7px;"></span>' + item.name + '</div>' );
	                 });
	  				
	  			},
	  			error : function(e) {
	  				console.error('Error:', e);
	  			}
	  		});//ajax
	  	}//updateSelectedItems()
	   
	    
	</script>
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
    
    
    
    document.getElementById('btnclose').addEventListener('click', function() {
        $('#firstModal').modal('hide');
      });
    
    document.getElementById('closeModal').addEventListener('click', function() {
        $('#firstModal').modal('hide');
      });
    
    
   
    $(function() {
        $('#btnSave').click(function() {
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

<%@include file="managerBarBottom.jsp"%>