<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>

<%@page import="java.io.File"%>

<%
	//Base64로 인코딩된 서명 데이터에서 실제 이미지 데이터를 추출
	String sign = StringUtils.split(request.getParameter("sign"), ",")[1];
	
	//현재 시스템 시간을 사용하여 고유한 파일 이름 생성
	String fileName = "sign"+System.currentTimeMillis()+".png";
	
	// 파일이 저장될 경로를 얻음 (웹 애플리케이션의 실제 경로)
    String filePath = getServletContext().getRealPath("/resources/sign/") + File.separator + fileName;
    
	// Base64로 인코딩된 데이터를 디코딩하여 파일로 저장
	FileUtils.writeByteArrayToFile(new File(filePath), Base64.decodeBase64(sign));
	
	
//FileUtils.writeByteArrayToFile(new File("c:\\temp/"+fileName), Base64.decodeBase64(sign));
%>

{
	"filename" : "<%= fileName %>"
} 