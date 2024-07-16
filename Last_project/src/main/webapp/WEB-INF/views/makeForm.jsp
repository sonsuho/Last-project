<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentTop.jsp"%>

<!-- header -->
<div class="page-header">
    <h3 class="page-title">
        <span class="page-title-icon bg-gradient-primary text-white me-2">
            <i class="mdi mdi-home"></i>
        </span> Study Group 만들기
    </h3>
    <nav aria-label="breadcrumb">
        <ul class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">
                <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
            </li>
        </ul>
    </nav>
</div>

<div align="center">
    <form action="make.chat" method="post">
        <table>
            <tr>
                <th>채팅방 이름을 입력하세요</th>
            </tr>
            <tr>
                <td><input type="text" name="chat_name"></td>
            </tr>
            <tr>
                <th><input type="submit" value="만들기" onclick="return chatTest()"></th>
            </tr>
        </table>
    </form>
</div>

<%@ include file="studentBottom.jsp"%>
