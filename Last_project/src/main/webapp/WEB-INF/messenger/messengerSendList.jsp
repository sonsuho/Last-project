<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!-- messengerSendList.jsp<br> -->
<script>
	function goRecvList(){
		location.href="rlist.messenger";
	}
	
</script>
<style>
	.sub-next-title { color: #9a9a9a; margin-right: 10px; cursor: pointer;}
	.sub-next-title:hover {color: #b66dff; transition: 0.2s;}
	
	<!-- pop up -->
	.pop-msg-title { font-size: 1.4rem; font-weight: bold;}
	.pl20 {padding-left: 20px; box-sizing: border-box;}
	.btn-reply { width: 100px; color: #198ae3 !important; font-weight: bold !important; padding: 10px 0 !important;}
	.second_modal {
		background:#fff; position: absolute; z-index:100; width:400px; height: 350px; display:flex; justify-content: space-between; padding: 16px 20px; box-sizing: border-box;  border-radius: 10px; box-shadow: 2px 5px 10px #ddd;
	}
	.second_modal .wrap {
		width: 200px;
	}
	.second_modal .wrap:first-child {border-right: 1px solid #000;}
	.second_modal .flex-wrap {
		width: 100%; height: 100%; overflow-x: auto; 
	}
	ul, li { list-style: none;}
	.msg_list {padding: 0;}
	
	
	.btn-add {border: 1px solid #ddd; border-radius: 6px; position: absolute; bottom:0; right:45;}
	
	table th, table td {
        padding: 8px;
        text-align: left;
    }
    table .ellipsis {
        white-space: nowrap;    
        overflow: hidden;    
        text-overflow: ellipsis;  
        max-width: 120px;         
    }
    table .ellipsis2 {
    	max-width: 200px !important;
    }
    
    .seleted_list { display: flex; justify-content:flex-start; flex-wrap: wrap;}
    .seleted_list div { width: 15%; background: #f6f6f6; display: flex; justify-content: center; align-content: center; border-radius: 50px; margin-right: 7px; padding: 5px; color: #666; margin-top:10px; font-size: 14px;}
    .seleted_list div:last-child { margin-right:0;}
    
    #selectedItems {display:flex; flex-wrap: wrap; overflow-y:auto;}
    #selectedItems div { padding: 15px 7px 0; box-sizing: border-box;}
</style>

<c:choose>
    <c:when test="${loginInfo.category == 'admin'}">
        <%@ include file="../admin/adminBarTop.jsp" %>
    </c:when>
    
    <c:when test="${loginInfo.category == 'manager'}">
        <%@ include file="../manager/managerBarTop.jsp" %>
    </c:when>
         
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file="../teacher/teacherTop.jsp" %>
    </c:when>
    
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file="../student/studentTop.jsp" %>
    </c:when>
</c:choose>
          
			<!-- header -->
		    <div class="page-header">
		      <h3 class="page-title" style="font-weight:700;">
		      	<span class="sub-next-title" onclick="goRecvList()">받은 메시지함</span> 보낸 메시지함
		      </h3>
		      <nav aria-label="breadcrumb">
                <div class="input-group-append">
                  <button class="btn btn-sm btn-gradient-primary py-3" type="button" data-bs-toggle="modal" data-bs-target="#firstModal" id="openFirstModal"><i class="fa fa-send"></i> &nbsp;&nbsp; 메시지 보내기</button>
                </div>
              </nav>
		    </div>
		    
		    <div class="row">
		      
		      <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    
                    <div class="row">
	                    <div class="col-lg-8">
	                    	<div style="margin-top: 5px;">
	                           <button type="button" class="btn btn-gradient-light btn-sm" onclick="delSelectedCheck()"><img src="resources/images/delete.png" style="width:24px; height:24px; margin-right: 7px;">삭제</button>
		                     </div>
	                    </div>
				        <div class="col-lg-4">
	                     	<form action="slist.messenger" style="display:flex;">
	                     		<input type="hidden" name="whatColumn" value="all">
		                        <input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                   			
		                        <button type="submit" class="btn btn-sm btn-success py-3" type="button" style="width: 70px;">검색</button>
	                        </form>
				        </div>
	                </div>
	    
                    
					<form name="msgForm" action="deleteSend.messenger" method="post">        
					  <table class="table table-hover">
					    <thead>
					      <tr>
					        <th width="50px;">
					          <label class="form-check-label">
					            <input type="checkbox" class="form-check-input item" value="" onclick="delAllCheck(this)">
					          </label>
					        </th>
					        <th width="110px;" style="text-align: left !important;">받는사람</th>
					        <th style="text-align: left !important;">제목</th>
					        <th style="text-align: left !important;">내용</th>
					        <th width="220px;" style="text-align: left !important;">보낸 날짜</th>
					      </tr>
					    </thead>
					    <tbody>
					      <c:choose>
					        <c:when test="${fn:length(slist) == 0}">
					          <tr>
					            <th colspan="5" style="text-align:center;">메시지가 없습니다.</th>
					          </tr>
					        </c:when>
					        <c:otherwise>
					          <c:forEach var="slist" items="${slist}">
					            <c:if test="${slist.del_chk != 1}">
					              <tr onclick="goDetailMsg('${slist.msg_num}')">
					                <td onclick="event.stopPropagation();">
					                  <label class="form-check-label">
					                    <input type="checkbox" class="form-check-input item" name="delcheck" value="${slist.msg_num}">
					                  </label>
					                </td>
					                <td>${slist.recv_name}</td>
					                <td class="ellipsis">${slist.title}</td>
					                <td class="ellipsis ellipsis2">${slist.content}</td>
					                <td>
					                	<c:set var="sendTimeStr" value="${slist.send_time}" />
										<fmt:parseDate value="${sendTimeStr}" var="sendTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
										<fmt:formatDate value="${sendTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					                </td>
					              </tr>
					            </c:if>
					          </c:forEach>
					        </c:otherwise>
					      </c:choose>
					    </tbody>
					  </table>
					</form>
                  </div>
                </div><!-- card end -->
              </div>
		    
		      <!-- 페이지네이션 -->
		      <div class="col-lg-12 grid-margin">
                <center>${pageInfo.pagingHtml }</center>
		  	  </div>
		  	  
            </div><!-- row end -->
            
            
	    <!--  메세지 보내기  -->
	    <!---- 첫번째 모달 팝업 ----->
		<div class="modal fade" id="firstModal" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content"  style="background:#fff">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"><b>메시지 보내기</b></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="send.messenger" method="post" enctype="multipart/form-data">
		          <div class="mb-3">
		            <label class="col-form-label">제목</label>
		            <input class="form-control" id="msg_title" name="title" required/>
		          </div>
		          <div class="mb-3" style="position:relative;">
		            <label class="col-form-label">받는 사람</label>
		            <div class="input-group-append">
               			<button class="btn btn-sm btn-inverse-success" type="button" onclick="return secondModal()"> 받는 사람 선택</button>
               		</div>
               		
               		<div class="seleted_list"></div>
               		
               		<div id="secondModal" class="second_modal" style="display:none;">
               			<!-- 받는 사람 리스트 -->
               			<div class="wrap flex-wrap">
							<div class="form-check">
                              <label class="form-check-label">
                              <input type="checkbox" class="form-check-input" name="allcheck" onclick="allCheck(this)">전체선택</label>
                            </div>
               				<ul class="msg_list">
								<li>
									<b>매니저</b>
									<ul>
										<c:forEach var="mb" items="${teacherlist }">
											<li>
												<div class="form-check">
					                              <label class="form-check-label">
					                              <input type="checkbox" class="form-check-input item" name="rowcheck" value="${mb.mem_num }" onchange="rowCheck()">${mb.name }</label>
					                            </div>
											</li>
										</c:forEach>
									</ul>
								</li>
								<li>
									<b>강사</b>
									<ul>
										<c:forEach var="mb" items="${managerlist }">
											<li>
												<div class="form-check">
					                              <label class="form-check-label">
					                              <input type="checkbox" class="form-check-input item" name="rowcheck" value="${mb.mem_num }" onchange="rowCheck()">${mb.name }</label>
					                            </div> 
											</li>
										</c:forEach>
									</ul>
								</li>
								<li>
									<b>학생</b>
									<ul>
										<c:forEach var="mb" items="${studentlist }">
											<li>
												<div class="form-check">
					                              <label class="form-check-label">
					                              <input type="checkbox" class="form-check-input item" name="rowcheck" value="${mb.mem_num }" onchange="rowCheck()">${mb.name }</label>
					                            </div>
											</li>
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
		          <div class="mb-3">
		            <label class="col-form-label">내용</label>
		            <textarea class="form-control" id="msg_content" name="content" cols="20" rows="6" required></textarea>
		          </div>
		          <div class="mb-3">
		            <label class="col-form-label">파일첨부</label>
		            <div class="form-group">
                        <div class="input-group col-xs-12">
                          <input type="file" id="recipient-name" name="msg_upload" multiple="multiple" onchange="checkFileInput()"> <br>
						  <input type="hidden" name="upload" value="" readonly>
                        </div>
                    </div>
		          </div>
		          
			      <button type="submit" style="width:100%;" class="btn btn-gradient-primary" onclick="return listChk()" ><i class="fa fa-send"></i> &nbsp;&nbsp;메시지 보내기</button>
			     
		        </form>
		      </div>
		    </div>
		  </div>
		</div>

			
		<!-- 메시지 디테일 모달 -->
	    <div class="modal fade" id="detailModal">
	        <div class="modal-dialog modal-dialog-centered">
	        	
	            <div class="modal-content" style="background:#fff;">
	                <div class="modal-body" style="padding: 40px 30px;">
	                <!-- ajax 데이터 노출 -->
	                
	                </div>
	                <div class="modal-footer">
	                	
	                </div>
	            </div>
	        </div>
	    </div>

		    
<c:choose>
    <c:when test="${loginInfo.category == 'admin'}">
        <%@ include file="../admin/adminBarBottom.jsp" %>
    </c:when>
    
    <c:when test="${loginInfo.category == 'manager'}">
        <%@ include file="../manager/managerBarBottom.jsp" %>
    </c:when>
     
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file="../teacher/teacherBottom.jsp" %>
    </c:when>
    
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file="../student/studentBottom.jsp" %>
    </c:when>
</c:choose>

<script src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.0.0/js/bootstrap.min.js"></script>
<script>

	// ajax 
    // 디테일 모달 
    // 메세지 상세정보 num으로 가져오기
    function goDetailMsg(num){
		
    	$("#replyModal").modal('hide');
    	
	   	$.ajax({
	   		 url : "detail.messenger",
	   		 type : "post",
	   		 data : ({msg_num : num}),
	   		 headers: {
	             'Accept': 'application/json', 
	             'Content-Type': 'application/x-www-form-urlencoded' 
	         },
	   		 success : function(data) {
	   			
	   			let modalContent = '<div style="display:flex; justify-content:space-between; align-items: center;">' +
						            '<h3 class="modal-title"><b>' + data.title + '</b></h3>' +
						            '<p style="font-size: 15px; margin:0 0 0 20px;">읽은 시간 : ' + data.read_time + '</p>' +
						            '</div>' +
						            '<p style="margin:16px 0 0 !important;">받는사람</p>' +
						            '<p><img src="resources/user.png" style="width:24px; margin-right:10px;">' + data.recv_name + '</p>' +
						            '<p style="height: 150px;">' + data.content + '</p>' +
						            '<p><b>첨부파일</b></p>';
	
				// 첨부 파일 목록을 forEach 구문을 사용하여 추가
				if (data.uploadList && data.uploadList.length > 0) {
					modalContent += '<ul>';
					$.each(data.uploadList, function(index, upload) {
					modalContent += '<li>' +
					                '<a href="<%=request.getContextPath() %>/resources/libraryFiles/' + upload + '" download="' + upload + '">' +
					                '<img src="resources/images/download.jpg" width="20" height="20">' +
					                '<span>' + upload + '</span>' +
					                '</a>' +
					                '</li>';
					});
					modalContent += '</ul>';
					
				} else {
					
					modalContent += '<p>첨부 파일 없음</p>';
					
				}
				
				// 모달 창에 내용 설정 및 열기
				$('#detailModal .modal-body').html(modalContent);
				$('#detailModal .modal-footer').html(
	                    '<button type="button" class="btn" onclick="modalClose()">닫기</button>'
				);
				
				$("#detailModal").modal('show');
	   			 
	   		 },
	   		 error: function(xhr, status, error) {
	   	        console.log("AJAX Error: " + status + ", " + error);
	   	        console.log(xhr.responseText);
	   	        // 오류 처리 로직 추가
	   	     }
	   	})// ajax 
	}// goDetailMsg end
    
	
    // 받는 사람 선택 팝업 노출 
    function secondModal(){
    	$('#secondModal').show();
    }
	
	// 받는 사람 유효성검사 
	function listChk(){
		if($('input[name=rowcheck]:checked').length == 0){
			alert("받는 사람을 선택하세요.");
			return false;
		}
	}
	
    // 받는 사람 전체 선택
	function allCheck(obj){
		var rcheck = document.getElementsByName('rowcheck');
		var check = obj.checked;
		
		if(check) {
			for(var i=0; i< rcheck.length; i++) {
				rcheck[i].checked = true;
			}
		} else {
			for(var i=0; i< rcheck.length; i++) {
				rcheck[i].checked = false;
			}
		}
	}
	
	// 받는 사람 
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
		$('#secondModal').hide();
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
  			url : 'selectedList.messenger',
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
  	
    // 상세보기 팝업 닫혔을 시 페이지 리로드 
  	function modalClose() {
  		$("#detailModal").modal('hide');
  		location.reload();
  	}
  	
 	// 팝업 닫기 버튼 클릭 시 데이터 초기화
  	document.getElementById('closePopupButton').addEventListener('click', function() {
  	    document.getElementById('msg_title').value = ''; 
  	    document.getElementById('msg_content').value = ''; 
  	    
  	  	$('input[name="allcheck"], input[name="rowcheck"]').prop('checked', false);
  	 	updateSelectedItems(true)
  	  	
  	});

	// 파일 업로드
	function checkFileInput(){
		var fileInput = document.getElementsByName("msg_upload")[0];
		var uploadField = document.getElementsByName("upload")[0];
		
		if(fileInput.files.length > 0) {
			uploadField.value = "파일 존재";
		} else {
			uploadField.value = "";
		}
	}
	
	// delete all check
	function delAllCheck(obj){
		var delcheck = document.getElementsByName('delcheck');
		var check = obj.checked;
		
		if(check){
			for(i=0; i<delcheck.length; i++){
				delcheck[i].checked = true;
			}
		} else {
			for(i=0; i<delcheck.length; i++){
				delcheck[i].checked = false;
			}
		}
	}// delAllCheck()
	
	// delete selected check
	function delSelectedCheck(){
		var delcheck = document.getElementsByName('delcheck');
		var flag = false;
		
		for(var i=0; i<delcheck.length; i++){
			if(delcheck[i].checked){
				flag = true;
				confirm("삭제하시겠습니까?");
			}
		}
		if(flag == false){
			alert("삭제할 항목을 1개 이상 선택하세요.");
			return;
		}
		document.msgForm.submit();
	}//delSelectedCheck()
	
	
	// 메시지 작성 시 글자 수 제한
	document.getElementById('msg_title').addEventListener('input', function(){
		if(this.value.length > 33){
			this.value = this.value.slice(0, 33);
		}
	});
	
	document.getElementById('msg_content').addEventListener('input', function(){
		if(this.value.length > 166){
			this.value = this.value.slice(0, 166);
		}
	});

	
</script>
