<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${loginInfo.category == 'manager'}">
   <%@include file="managerBarTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
   <%@include file="../student/studentTop.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
   <%@include file="../teacher/teacherTop.jsp"%>
</c:if>

<style type="text/css">
table {
   width: 650px;
}
</style>

<script type="text/javascript">
       
       function allCheck(obj){
          
          var rcheck = document.getElementsByName("rowcheck");
          
          var check = obj.checked;
          
          if(check){
             for(var i = 0; i < rcheck.length; i++){
                rcheck[i].checked = true;
             }
          }else{
             for(var i = 0; i < rcheck.length; i++){
                rcheck[i].checked = false;
             }
          }
          
       }
       
       function selectDelete(){
          
          var flag = false;
          
          var rcheck = document.getElementsByName("rowcheck");
          
          for(var i = 0; i < rcheck.length; i++){
             
             if(rcheck[i].checked == true){
                flag = true;
                break;
             }
          }
          
          if(!flag){
             alert('삭제할 항목을 선택하세요.');
            return false;
          }
          
          var result = confirm("삭제 하시겠습니까?");
          
          if(result == true){         
             document.myform.submit();
          } else{
             alert('취소했습니다');
             return false;
          }
       }
       
       // 뒤로가기
       function back(){
          location.href="javascript:history.back();";
       }
    
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
               <div class="col-lag-12">
                  <h1 style="text-align: center;">NOTICE</h1>
               </div>
            </div>


            <div class="row">
               <div class="col-lg-12">
                  <h1>${notice.title}</h1>
                  <div
                     style="color: #999; margin: 20px 0; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #000; font-size: 15px;">
                     <div
                        style="display: flex; justify-content: flex-start; align-items: center;">
                        <p>
                           <b>${notice.writer}</b>
                        </p>
                        <p style="padding: 0 10px;">|</p>
                        <p>${notice.day }</p>
                        <p style="padding: 0 10px;">|</p>
                        <c:if test="${notice.class_name eq 'All'}">
                           <p>전체</p>
                        </c:if>
                        <c:if test="${notice.class_name ne 'All'}">
                           <p><p>${notice.class_name}반</p>


                        </c:if>
                         
                     </div>
                     <div
                        style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 16px;">
                        <c:if
                           test="${notice.lec_num == loginInfo.lec_num && loginInfo.category == 'manager'}">
                           <div style="margin-right: 10px;">
                              <a href="noticeUpdate.manager?n_num=${notice.n_num}"
                                 class="btn btn-gradient-light btn-sm"><img
                                 src="resources/images/update.png"
                                 style="width: 24px; height: 24px;">수정</a>
                           </div>
                           <div>
                              <a href="noticeDelete.manager?n_num=${notice.n_num}"
                                 class="btn btn-gradient-light btn-sm"><img
                                 src="resources/images/delete.png"
                                 style="width: 24px; height: 24px;">삭제</a>
                           </div>
                        </c:if>
                     </div>
                  </div>

                  <div style="padding: 30px 0 50px; font-size: 16px;">
                     ${notice.content }</div>
                  <br>
                  <br>
                  <br>
               </div>

            </div>
         </div>
      </div>
   </div>
</div>
<c:if test="${loginInfo.category == 'manager'}">
   <%@include file="managerBarBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'student'}">
   <%@include file="../student/studentBottom.jsp"%>
</c:if>

<c:if test="${loginInfo.category == 'teacher'}">
   <%@include file="../teacher/teacherBottom.jsp"%>
</c:if>