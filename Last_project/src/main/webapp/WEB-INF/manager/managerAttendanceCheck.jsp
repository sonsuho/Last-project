<%@page import="member.model.AttendBean"%>
<%@page import="member.model.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
/* 출석 및 퇴실 div */
#button {
	float: center;
}
</style>
<script type="text/javascript">
    function getTime() {
        var d = new Date();
        var hur = d.getHours().toString().padStart(2,'0');
        var min = d.getMinutes().toString().padStart(2,'0');
        var sec = d.getSeconds().toString().padStart(2,'0');
        var timeBoard = document.getElementById("Now_Time");
        var time = hur + ":" + min + ":" + sec;
        timeBoard.innerHTML = time;
        setTimeout(getTime, 1000);
    }

    function getInformation_in() {
        if(confirm("출근 하시겠습니까?")){
            fetch('https://api64.ipify.org?format=json')
            .then(response => response.json())
            .then(data => {
                document.getElementById("ipAddress_in").value = data.ip;
                getLocation_in();
            })
            .catch(error => {
                console.error('Error fetching IP address:', error);
            });
        } else {
            alert("출근이 정상처리되지 않았습니다.");
        }
    }

    function getLocation_in() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition_in, showError);
        } else {
            alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
        }
    }

    function showPosition_in(position) {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        document.getElementById("latitude_in").value = latitude;
        document.getElementById("longitude_in").value = longitude;
        document.getElementById("checkInForm").submit();
    }

    function getInformation_out() {
        if(confirm("정말 퇴근하겠습니까?")){
            fetch('https://api64.ipify.org?format=json')
            .then(response => response.json())
            .then(data => {
                document.getElementById("ipAddress_out").value = data.ip;
                getLocation_out();
            })
            .catch(error => {
                console.error('Error fetching IP address:', error);
            });
        } else {
            alert("퇴근이 정상처리되지 않았습니다.");
        }
    }

    function getLocation_out() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition_out, showError);
        } else {
            alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
        }
    }

    function showPosition_out(position) {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        document.getElementById("latitude_out").value = latitude;
        document.getElementById("longitude_out").value = longitude;
        document.getElementById("checkOutForm").submit();
    }

    function showError(error) {
        switch(error.code) {
            case error.PERMISSION_DENIED:
                alert("사용자가 Geolocation 요청을 거부했습니다.");
                break;
            case error.POSITION_UNAVAILABLE:
                alert("위치 정보를 사용할 수 없습니다.");
                break;
            case error.TIMEOUT:
                alert("요청 시간이 초과되었습니다.");
                break;
            case error.UNKNOWN_ERROR:
                alert("알 수 없는 오류가 발생했습니다.");
                break;
        }
    }
</script>

<%
    String att_sdate = (String)session.getAttribute("att_sdate");
    if(att_sdate == null){
        att_sdate = "미등록";
    }
    String att_fdate = (String)session.getAttribute("att_fdate");
    if(att_fdate == null){
        att_fdate = "미등록";
    }
%>

<div align="center">
	<body onload="getTime()">
	<h2 id="Now_Time"></h2>

	출근시간 :
	<%=att_sdate %><br> 
	퇴근시간 :
	<%=att_fdate %><br>

<%
	String check_flag = (String)session.getAttribute("check_flag");		//MemberBean.getMem_num()

//	MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
    
//	System.out.println("attendanceCheck test : " + mb);
    
    if(check_flag == null) {
    	check_flag = ""; // check_flag가 null인 경우 빈 문자열로 설정
    }

    if(check_flag.equals("")) {    //아직 출석 안함
%>

		<!-- 출근하기 Button -->
		<form name="checkInForm" id="checkInForm" action="start.manager?mem_num=${loginInfo.mem_num}&mem_ip=${loginInfo.mem_ip}&mem_latitude=${loginInfo.mem_latitude}&mem_longitude=${loginInfo.mem_longitude}" method="post">
		
			<input type="hidden" name="ipAddress" id="ipAddress_in">
			<input type="hidden" name="latitude" id="latitude_in"> 
			<input type="hidden" name="longitude" id="longitude_in">
			<button type="button" onclick="getInformation_in()"class="btn btn-gradient-primary btn-rounded btn-fw">
				출근하기
			</button>
		</form>
		
<%
	} else if(check_flag.equals("success")) {    //출석 성공
%>
		<!-- 퇴근하기 Button -->
		
		<form name="checkOutForm" id="checkOutForm" action="fin.manager?mem_num=${loginInfo.mem_num}&mem_ip=${loginInfo.mem_ip}&mem_latitude=${loginInfo.mem_latitude}&mem_longitude=${loginInfo.mem_longitude}" method="post">
			<input type="hidden" name="ipAddress" id="ipAddress_out">
			<input type="hidden" name="latitude" id="latitude_out"> 
			<input type="hidden" name="longitude" id="longitude_out">
			<button type="button" onclick="getInformation_out()" class="btn btn-gradient-dark btn-rounded btn-fw">
				퇴근하기
			</button>
		</form>
<%        
    }
%>
	</body>
</div>