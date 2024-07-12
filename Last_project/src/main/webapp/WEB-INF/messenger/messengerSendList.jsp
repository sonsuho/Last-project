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
<!-- ------------------------------------------------------------------------------------- -->
          
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
				      	  <div class="form-group">
		                     <div class="input-group">
		                        <input type="text" class="form-control" placeholder="이름을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
		                        <div class="input-group-append">
		                          <button class="btn btn-sm btn-gradient-primary py-3" type="button">검색</button>
		                        </div>
		                      </div>
		                  </div>
				        </div> 
	                </div>
	                
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th>보낸사람(나)</th>
					  	  <th>받는사람</th>
						  <th>제목</th>
						  <th>내용</th>
						  <th>보낸 날짜</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="slist" items="${slist }">
						  <tr onclick="goDetailMsg()">
							<td>${slist.mem_num }</td>
							<td>${slist.recv_num }</td>
							<td>${slist.title }</td>
							<td>${slist.content }</td>
							<td>${slist.send_time }</td>
						  </tr>
					    </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div><!-- card end -->
              </div>
		    
            </div><!-- row end -->
		    
<%@ include file="../student/studentBottom.jsp" %>
