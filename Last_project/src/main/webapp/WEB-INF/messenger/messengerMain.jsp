<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!-- messengerMain.jsp<br> -->

<style>
	.sub-next-title { color: #9a9a9a; margin-left: 10px; cursor: pointer;}
	.sub-next-title:hover {color: #b66dff; transition: 0.2s;}
	
	input[type="readonly"] { border: none;}
	.bg {background: #EAE8FF; padding: 10px; box-sizing: border-box; border-radius: 10px;}
	a {text-decoration: none !important; color: inherit !important;}
	
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
</style>


<c:choose>
    <c:when test="${loginInfo.category == 'admin'}">
        <%@ include file="../admin/adminBarTop.jsp" %>
    </c:when>
    
    <c:when test="${loginInfo.category == 'manager'}">
        <%@ include file="../manager/managerBarTop.jsp" %>
    </c:when>
<%--     
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file="../teacher/teacherTop.jsp" %>
    </c:when>
     --%>
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file="../student/studentTop.jsp" %>
    </c:when>
</c:choose>
          
		<!-- header -->
	    <div class="page-header">
	      <h3 class="page-title" style="font-weight:700;">
	      	받은 메시지함 <span class="sub-next-title"><a href="slist.messenger">보낸 메시지함</a></span>
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
                     	<form action="rlist.messenger" style="display:flex;">
                     		<input type="hidden" name="whatColumn" value="all">
	                        <input type="text" name="keyword" class="form-control" placeholder="이름 또는 제목을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
                   			
	                        <button type="submit" class="btn btn-sm btn-success py-3" type="button" style="width: 70px;">검색</button>
                        </form>
			        </div>
                  </div><!-- row -->


				  <form name="msgForm" action="deleteRecv.messenger" action="post">        
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
	                         <th width="110px;">보낸사람</th>
	                         <th>제목</th>
	                         <th>내용</th>
	                         <th width="220px;">받은 날짜</th>
	                       </tr>
	                     </thead>
	                     <tbody>
	                       <c:choose>
	                     	 <c:when test="${fn:length(rlist) == 0 }">
	                     	 	<tr>
	                     	 		<th colspan="4" style="text-align:center;">검색된 내용이 없습니다.</th>
	                     	 	</tr>
	                     	 </c:when>
	                     	 <c:otherwise>
					          <c:forEach var="rlist" items="${rlist}">
					              <tr onclick="goDetailMsg('${rlist.msg_num}')">
					                <c:choose>
					                  <c:when test="${rlist.read_chk == 1}">
					                    <td style="background:#f6f6f6 !important;" onclick="event.stopPropagation();">
					                      <label class="form-check-label">
					                        <input type="checkbox" class="form-check-input item" name="delcheck" value="${rlist.msg_num}">
					                      </label>
					                    </td>
					                    <td style="background:#f6f6f6 !important;">${rlist.send_name}</td>
					                    <td style="background:#f6f6f6 !important;">${rlist.title}</td>
					                    <td style="background:#f6f6f6 !important;">${rlist.content}</td>
					                    <td style="background:#f6f6f6 !important;">${rlist.send_time}</td>
					                  </c:when>
					                  <c:otherwise>
					                    <td onclick="event.stopPropagation();">
					                      <label class="form-check-label">
					                        <input type="checkbox" class="form-check-input item" name="delcheck" value="${rlist.msg_num}">
					                      </label>
					                    </td>
					                    <td>${rlist.send_name}</td>
					                    <td>${rlist.title}</td>
					                    <td>${rlist.content}</td>
					                    <td>${rlist.send_time}</td>
					                  </c:otherwise>
					                </c:choose>
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
	    
 	    
	    <!-- 답장하기 모달  -->
		<div class="modal fade" id="replyModal">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content"  style="background:#fff">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"><b>답장하기</b></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="send.messenger" method="post" enctype="multipart/form-data">
		        
		          <div class="mb-3">
		          	<div class="msg_hidden"></div>
		          	<div class="msg_title" style="display:flex;"></div>
		          </div>
		          
		          <div class="mb-3" style="position:relative;">
		            <label class="col-form-label">받는 사람</label>
		            <div class="recv_name">
               			
               		</div>
		          </div>
		          
		          <div class="mb-3">
		            <textarea class="form-control" id="msg_content" name="content" cols="20" rows="10" placeholder="메시지 내용을 입력하세요." required></textarea>
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
		          
			      <button type="submit" style="width:100%;" class="btn btn-gradient-primary"><i class="fa fa-send"></i> &nbsp;&nbsp;메시지 보내기</button>
			     
		        </form>
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
<%--     
    <c:when test="${loginInfo.category == 'teacher'}">
        <%@ include file="../teacher/teacherTop.jsp" %>
    </c:when>
     --%>
    <c:when test="${loginInfo.category == 'student'}">
        <%@ include file="../student/studentBottom.jsp" %>
    </c:when>
</c:choose>




 
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
						            '<p style="font-size: 15px; margin:0 0 0 20px;">' + data.send_time + '</p>' +
						            '</div>' +
						            '<p style="margin:16px 0 0 !important;">보낸사람</p>' +
						            '<p><img src="resources/user.png" style="width:24px; margin-right:10px;">' + data.send_name + '</p>' +
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
						'<button type="button" class="btn btn-reply" onclick="msgReply(' + data.msg_num + ')">답장하기</button>'+
	                    '<button type="button" class="btn" onclick="modalClose()">취소</button>'
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
  	
  	
  	
  	// 답장 하기 
  	function msgReply(msg_num){
  		
  		$("#detailModal").modal('hide');
  		
  		$.ajax({
  			url : "replyForm.messenger",
  			type : "post",
  			data : ({ msg_num : msg_num }),
  			headers : {
  				'Accept' : 'application/json',
  				'Content-Type': 'application/x-www-form-urlencoded' 
  			},
  			success : function(data) {

  				// 제목 앞에 "Re: "가 몇 번 붙어있는지 계산
  			    var reCount = (data.title.match(/^Re: /g) || []).length;

  			    // Re: 횟수를 기반으로 제목 설정
  			    var newTitle;
  			    if (reCount === 0) {
  			      newTitle = "Re: " + data.title;
  			    } else if (reCount === 1) {
  			      newTitle = "Re: Re: " + data.title.substring(4);
  			    } else {
  			      newTitle = "Re: " + data.title;
  			    }

  				
  				// 히든으로 필요한 값 넘기기
  				$("#replyModal .modal-body .msg_hidden").html(
  						'<input type="hidden" name="ogmsg_num" value="' + data.msg_num + '"/>' +
  						'<input type="hidden" name="title" value="' + newTitle + '"/>' +
  						'<input type="hidden" name="rowcheck" value="' + data.mem_num + '"/>'
  				);
  				
  				// 기존 메시지 타이틀 
  				$("#replyModal .modal-body .msg_title").html(
  						'<h3><b>' + newTitle + '</b></h3>' +
  						'<button onclick="goDetailMsg(' + data.msg_num + ')">원글보기</button>'
  				);
  				$("#replyModal").modal('hide');
  				
  				// 받는사람 
  				$("#replyModal .modal-body .recv_name").html(
  						'<div><span><img src="resources/user.png" width="24px;"></span>' + data.send_name + '</div>'
  				);
  				
  				$("#replyModal").modal('show');
  			},
  			error : function(data) {
  				console.error('Error:', data);
  			}
  		})//ajax
  		
  	}// msgReply()
  	
  	
	
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