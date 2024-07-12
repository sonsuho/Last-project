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
</style>

<%@ include file="../student/studentTop.jsp" %>
          
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
				          <div class="form-group">
		                     <div class="form-check">
		                       <label class="form-check-label">
		                       <input type="checkbox" class="form-check-input"> 안 읽은 메시지만 보기 </label>
		                     </div>
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
	    
                    
                    <form name="msgForm" action="deleteSend.messenger" action="post">        
	                  <table class="table table-hover">
	                     <thead>
	                       <tr>
	                         <th colspan="6">
	                         	<button type="button" class="btn btn-gradient-light" onclick="delSelectedCheck()">삭제</button>
	                         </th>
	                       </tr>
	                       <tr>
	                       	 <th width="50px;">
	                              <label class="form-check-label">
	                              	<input type="checkbox" class="form-check-input item" value="" onclick="delAllCheck(this)">
	                              </label>
	                       	 </th>
	                         <th width="110px;">받는사람</th>
	                         <th>제목</th>
	                         <th>내용</th>
	                         <th width="220px;">보낸 날짜</th>
	                       </tr>
	                     </thead>
	                     <tbody>
	                       <c:choose>
	                     	 <c:when test="${fn:length(slist) == 0 }">
	                     	 	<tr>
	                     	 		<th colspan="5" style="text-align:center;">검색된 내용이 없습니다.</th>
	                     	 	</tr>
	                     	 </c:when>
	                     	 <c:otherwise>
					          <c:forEach var="slist" items="${slist}">
					              <tr onclick="goDetailMsg('${slist.msg_num}')">
					                <td onclick="event.stopPropagation();">
					                      <label class="form-check-label">
					                        <input type="checkbox" class="form-check-input item" name="delcheck" value="${slist.msg_num}">
					                      </label>
					                    </td>
									<td>${slist.recv_name }</td>
									<td>${slist.title }</td>
									<td>${slist.content }</td>
									<td>${slist.send_time }</td>
								  </tr>
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
               			<button class="btn btn-sm btn-inverse-success" type="button" onclick="secondModal()"> 받는 사람 선택</button>
               		</div>
               		
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
						<div class="wrap flex-wrap">
							<div style="padding-left: 10px;">
								<b>받는 사람 목록</b>
							</div>
							<div id="selectedItems">
								<!--ajax 선택된 사람 리스트 노출 -->
								
							</div>
							<button onclick="return selectedPeople()">추가하기</button>
						</div>
						<p id="chk_txt" style="color: red; font-size: 12px;"></p>
					</div>
               		
		          </div>
		          <div class="mb-3">
		            <label class="col-form-label">내용</label>
		            <textarea class="form-control" id="msg_content" name="content" cols="20" rows="10" required></textarea>
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

		    
<%@ include file="../student/studentBottom.jsp" %>

<script src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		} else {
			return true;
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
		
		//받는사람 모달 팝업 닫기 
		$('#secondModal').hide();
	
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
                     $('#selectedItems').append('<div><span><img src="resources/user.png" width="24px;"></span>' + item.name + '</div>' );
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
			}
		}
		if(flag == false){
			alert("삭제할 항목을 1개 이상 선택하세요.");
			return;
		}
		document.msgForm.submit();
	}//delSelectedCheck()

	
</script>
