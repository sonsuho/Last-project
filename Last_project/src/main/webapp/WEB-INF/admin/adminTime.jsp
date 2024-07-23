<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
function getTime() {
    var d = new Date();
    var hur = d.getHours().toString().padStart(2,'0');
    var min = d.getMinutes().toString().padStart(2,'0');
    var sec = d.getSeconds().toString().padStart(2,'0');
    var timeBoard = document.getElementById("Now_Time");
    var time = hur + ":" + min + ":" + sec;
    timeBoard.innerHTML = time;
    setTimeout(getTime, 1000);
    
    var year = d.getFullYear();
    var month = (d.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1 필요
    var date = d.getDate().toString().padStart(2, '0');
    var days = ['일', '월', '화', '수', '목', '금', '토'];
    var day = days[d.getDay()];
    var dateBoard = document.getElementById("Now_Date");
    var fullDate = year + "-" + month + "-" + date + " (" + day + ")";
    dateBoard.innerHTML = fullDate;
}
</script>
    
<body onload="getTime()">
	<div align="center">
		<span id="Now_Date" style="color: #949494; position: relative; right: 20px; font-family: NotoSans;"></span>
		<h1 id="Now_Time" style="font-family: NotoSans; font-size: 40px"></h1>
	</div>
</body>