<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file = "studentTop.jsp"%>

	<!-- header -->
  <div class="page-header">
    <h3 class="page-title">
      <span class="page-title-icon bg-gradient-primary text-white me-2">
        <i class="mdi mdi-home"></i>
      </span> StudentMain
    </h3>
    <nav aria-label="breadcrumb">
      <ul class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">
          <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
        </li>
      </ul>
    </nav>
  </div>
  
  <div>
    <a href="request.student">요청 페이지</a>
		<a href="rlist.messenger">메신저 페이지</a>
  </div>

<%@ include file = "studentBottom.jsp"%>
