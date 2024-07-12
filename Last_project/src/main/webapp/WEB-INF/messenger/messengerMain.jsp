<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!-- messengerMain.jsp<br> -->

<style>
	.sub-next-title { color: #9a9a9a; margin-left: 10px; cursor: pointer;}
	.sub-next-title:hover {color: #b66dff; transition: 0.2s;}
	
	input[type="readonly"] { border: none;}
	.bg {background: #EAE8FF; padding: 10px; box-sizing: border-box; border-radius: 10px;}
	a {text-decoration: none !important; color: #9a9a9a !important;}
	
	<!-- pop up -->
	.pop-msg-title { font-size: 1.4rem; font-weight: bold;}
	.pl20 {padding-left: 20px; box-sizing: border-box;}
	.btn-reply { width: 100px; color: #198ae3 !important; font-weight: bold !important; padding: 10px 0 !important;}
</style>
<script>




</script>

<%@ include file="../student/studentTop.jsp" %>
<!-- ------------------------------------------------------------------------------------- -->
        <!-- 페이지 메인 부분 : partial -->
        <div class="main-panel" style="margin-left:260px; width:calc(100%-260px);">
          <div class="content-wrapper">
          
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
	                     		<input type="hidden" name="whatColumn" value="send_name">
		                        <input type="text" name="keyword" class="form-control" placeholder="이름을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
                    			
		                        <button type="submit" class="btn btn-sm btn-success py-3" type="button" style="width: 70px;">검색</button>
	                        </form>
				        </div>
				        
	                </div>
	                
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th>보낸사람</th>
                          <th>제목</th>
                          <th>내용</th>
                          <th>받은 날짜</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="rlist" items="${rlist }">
						  <tr onclick="goDetailMsg('${rlist.msg_num}')">
							<td>${rlist.send_name }</td>
							<td>${rlist.title }</td>
							<td>${rlist.content }</td>
							<td>${rlist.send_time }</td>
						  </tr>
					    </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div><!-- card end -->
              </div>
              <div class="col-lg-12 grid-margin">
				  ${pageInfo.pagingHtml }
			  </div>
		    
            </div><!-- row end -->
		    
		    
		    <!--  메세지 보내기  
		    <!---- 첫번째 모달 팝업 ----->
		    <!-- Vertically centered modal -->
 			<div class="modal fade" id="firstModal" tabindex="-1">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content"  style="background:#fff">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel"><b>메시지 보내기</b></h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <form>
			          <div class="mb-3">
			            <label class="col-form-label">제목</label>
			            <input class="form-control" id="msg_title" name="title" required/>
			          </div>
			          <div class="mb-3">
			            <label class="col-form-label">받는 사람</label>
			            <div class="input-group-append">
                  			<button class="btn btn-sm btn-inverse-success" type="button" onclick="secondModal()"> 받는 사람 선택</button>
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
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" style="width:100%;" class="btn btn-gradient-primary" onclick="sendMsg()"><i class="fa fa-send"></i> &nbsp;&nbsp;메시지 보내기</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- 메시지 보내기 -->
 			<!-- 두번째 모달 팝업 -->
 			<div class="modal fade" id="secondModal" tabindex="-1">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content"  style="background:#fff">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel"><b>메시지 보내기</b></h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      
			      </div>
			      
			      <div class="modal-footer">
			        <button type="button" style="width:100%;" class="btn btn-gradient-primary" onclick="sendMsg()"><i class="fa fa-send"></i> &nbsp;&nbsp;메시지 보내기</button>
			      </div>
			    </div>
			  </div>
			</div>
						
			
		<!-- 디테일 모달 -->
	    <div class="modal fade" id="detailModal">
	        <div class="modal-dialog modal-dialog-centered">
	        	
	            <div class="modal-content" style="background:#fff;">
	                <div class="modal-body" style="padding: 40px 30px;">
	                <!-- ajax 데이터 노출 -->
	                
	                </div>
	                <div class="modal-footer">
	                	<button type="button" class="btn btn-reply" onclick="">답장하기</button>
	                    <button type="button" class="btn" data-bs-dismiss="modal">취소</button>
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

    // 메세지 상세정보 num으로 가져오기
    function goDetailMsg(num){
   	$.ajax({
   		 url : "detail.messenger",
   		 type : "post",
   		 data : ({msg_num : num}),
   		 headers: {
             'Accept': 'application/json', // 서버가 JSON 응답을 반환하도록 설정
             'Content-Type': 'application/x-www-form-urlencoded' // 데이터 전송 형식 설정
         },
   		 success : function(data) {
   			
   			$('#detailModal .modal-body').html(
   				'<div style="display:flex; justify-content:space-between; align-items: center;"><h3 class="modal-title"><b>'
   				+ data.title +
   				'</b></h3><p style="font-size: 15px; margin:0 0 0 20px;">'
   				+ data.send_time + '</p></div>' +
   				
   				'<p style="margin:16px 0 0 !important;">보낸사람</p>' + 
                '<p><img src="resources/user.png" style="width:24px; margin-right:10px;">'
                + data.send_name + '</p><p>' +
                
                '<p style="height: 150px;">' + data.content + '</p>' +
                
                '<p><b>첨부파일</p></b>'
                
            );
   			// 디테일 모달 창 열기
   			$("#detailModal").modal('show');
   			 
   		 },
         error: function(error) {
             console.log(error);
         }
   	})
   }
    
    
    $(document).ready(function() {
    	
    	
    	$('#openFirstModal').on('click', function(){
    		$('#firstModal').modal('show');
    	})
    	
    }); 
    
    function secondModal(){
    	$('#secondModal').modal('show');
    }
    
        
    </script>