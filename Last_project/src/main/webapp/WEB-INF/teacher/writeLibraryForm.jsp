<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "teacherTop.jsp"%>
	
	<style type="text/css">
		
		.err{
			font-style: 15px;
			color: red;
		}
		
	</style>
	
	<script type="text/javascript">
	    function checkFileInput() {
	        var fileInput = document.getElementsByName('multiFile')[0];
	        var uploadField = document.getElementsByName('upload')[0];
	        
	        if (fileInput.files.length > 0) {
	            uploadField.value = '파일 존재';
	        } else {
	            uploadField.value = '';
	        }
	    }
	    
	    function libCheck() {
			
	    	var title = document.getElementsByName('title')[0].value.trim();
	    	
	    	if (title === "") {
	            alert("제목을 입력하세요.");
	            document.getElementsByName('title')[0].focus();
	            return false;
	        }
	        return true;
		}
	    
	 	// 뒤로가기
    	function back(){
    		location.href="javascript:history.back();";
    	}
	 	
    	// 제목 글자 수 제한
    	document.getElementById('libTitle').addEventListener('input', function(){
    		if(this.value.length > 16){
    			this.value = this.value.slice(0, 16);
    		}
    	});
    	
    	// 내용 글자 수 제한
    	document.getElementById('libContent').addEventListener('input', function(){
    		if(this.value.length > 66){
    			this.value = this.value.slice(0, 66);
    		}
    	});
	    
	</script>
	
	<!-- header -->
    <div class="page-header">
      <div class="input-group-append">
        <button class="btn btn-sm" type="button" onclick="back()"><i class="fa fa-chevron-left"></i> &nbsp;&nbsp; 뒤로가기</button>
      </div>
    </div>
	
	<div class="row">
       <div class="col-lg-12 grid-margin stretch-card">
          <div class="card">
             <div class="card-body">
    
    			<div class="row">
    				<div class="col-lg-12">
    					
    					<form:form commandName="library" action="writeLibrary.teacher" method="post" enctype="multipart/form-data">
    					
    						<div style="display:flex; justify-content:space-between; align-items: center; border-bottom:1px solid #000; padding: 16px 0;">
						    	<h1>
						    		<input type="text" name="title" id="libTitle" value="${library.title}" placeholder="제목을 입력하세요." style="border:none;">
						    	</h1>
					    		<div>
		    						<button class="btn btn-sm btn-gradient-primary py-3" type="submit" onclick="return libCheck()" style="padding: 12px !important;" ><i class="fa fa-check"></i> &nbsp;&nbsp; 글쓰기</button>
		    					</div>
	    					</div>
	    					
					    	<div style="padding: 30px 0 50px; font-size: 16px;">
					    		<textarea rows="10" cols="22" name="content" id="libContent" style="width: 100%; border:none;" placeholder="내용을 입력하세요.">${library.content}</textarea>
					    	</div>
					    	<div>
					    		<p style="margin-bottom: 10px;">
					    			<b>첨부파일</b>
					    		</p>
					    		<div>
									<input type="file" name="multiFile" multiple="multiple" onchange="checkFileInput()"> <br> 
									<input type="hidden" name="upload" value="" readonly="readonly">
									<form:errors path="upload" cssClass="err"/>
					    		</div>
					    	</div>
				    	
				    	</form:form>
    				</div>
    			</div>
    			
    		 </div>
    		 
    	  </div><!-- card end -->
       </div><!-- gol-lg-12 end -->
    </div>


<%-- 수호씨 코드	
	<div align="center">
		
		<h1>자료실 글 쓰기</h1> <br>
		
		<form:form commandName="library" action="writeLibrary.teacher" method="post" enctype="multipart/form-data">
		
			<table border="1">
				
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" value="${library.title}"> <br>
						<form:errors path="title" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td><textarea rows="5" cols="22" name="content">${library.content}</textarea> </td>
				</tr>
				
				<tr>
					<th>파일</th>
					<td>
						<input type="file" name="multiFile" multiple="multiple" onchange="checkFileInput()"> <br> 
						<input type="hidden" name="upload" value="" readonly="readonly">
						<form:errors path="upload" cssClass="err"/>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><input type="submit" value="전송" onclick="return libCheck()"></td>
				</tr>
				
			</table>
		
		</form:form>
		
	</div> --%>
	
<%@ include file = "teacherBottom.jsp"%>
	