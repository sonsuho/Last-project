<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    div#alarmDropdown {
        width: 400px;
        max-height: 700px;
        overflow: auto;
    }
    
    div.alarmBody {
        width: 100%;
        margin: 10px auto;
        padding: 5px 15px;
    }
    
    div.alarmTitle {
        display: flex;
        align-items: center;
        margin: 0px auto 10px auto;
    }
    
    div.alarmlRow {
        border: 1px solid #f9fafa;
        min-height: 40px;
        padding-top: 5px;
        padding-bottom: 5px;
    }
    
    div.alarmlRow:hover {
        cursor: pointer;
        background-color: #f9fafa;
    }
    
    div.alarmRowInside {
        width: 97%;
        min-height: 30px;
        margin: 5px auto;
        display: flex;
        align-items: center;
    }
    
    div.alarmcontent1 {
        width: 280px;
        margin: auto;
    }
    
    span.spanBlock {
        display: block;
        font-size: 11pt;
    }
    
    div.redCircle {
        width: 13px;
        height: 13px;
        border-radius: 100%;
        background: red;
        border: 2px solid white;
        position: relative;
        bottom: 33px;
        left: 28px;
    }
    
    div.alarmProf {
        width: 40px;
        height: 40px;
        border-radius: 40%;
        background-color: white;
        color: white;
        text-align: center;
        padding-top: 4px;
        border: 1px solid #ccced0;
        font-weight: bold;
        font-size: 19px;
        margin: auto 4px;
    }
    
    button#allReadAlarm {
        width: 70px;
        height: 27px;
        border: none;
        text-align: center;
        border-radius: 0.5rem;
        margin-right: 7px;
        font-weight: bold;
        font-size: 10pt;
        background-color: #e3f0fd;
        color: #578ec7;
    }
    
    button#allReadAlarm:hover {
        filter: brightness(90%);
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function formatDate(dateString) {
        var date = new Date(dateString);
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var hours = date.getHours();
        var minutes = date.getMinutes();
        
        var formattedDate = year + "-" + (month < 10 ? '0' + month : month) + "-" + (day < 10 ? '0' + day : day) + " " +
                            (hours < 10 ? '0' + hours : hours) + ":" + (minutes < 10 ? '0' + minutes : minutes);
        
        return formattedDate;
    }

    function openAlarm(){
        getAlarm();
        getPastAlarm();
        $('#alarmDropdown').toggleClass('active');
    }
    
    function getAlarm(){
        $.ajax({
            url : "<%=request.getContextPath()%>/getAlarmList.alarm",
            dataType: "JSON",
            success: function(json){ 
                let html = "";
                if(json.length > 0){
                    $.each(json, function(index, item){
                        html += '<div class="alarmlRow" onclick="javascript:readAlarm(\'' + item.pk_alarmno + '\'); location.href=\'<%=request.getContextPath()%>' + item.url + item.url2 + '\'; ">' +
                                    '<div class="alarmRowInside">' +
                                        '<div class="alarmProf">' + item.alarm_type + '<div class="redCircle"></div></div>' +
                                        '<div class="alarmcontent1 ml-3">' +
                                            '<span class="spanBlock" style="font-weight: bold;">' + item.alarm_content + '</span>' +
                                            '<span class="spanBlock" style="color: gray; font-size: 10pt;">' + formatDate(item.writedate) + ' </span>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>';
                    });
                } else {
                    html += '<span class="ml-2">새로운 소식이 없습니다.</span>';
                }
                $('div#newAlarmResult').html(html);
            },
            error: function(request, status, error){
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
    
    function getPastAlarm(){
        $.ajax({
            url : "<%=request.getContextPath()%>/getPastAlarmList.alarm",
            dataType: "JSON",
            success: function(json){ 
                let html = "";
                if(json.length > 0){
                    $.each(json, function(index, item){
                        html += '<div class="alarmlRow" onclick="javascript:location.href=\'<%=request.getContextPath()%>' + item.url + item.url2 + '\'; ">' +
                                    '<div class="alarmRowInside">' +
                                        '<div class="alarmProf">' + item.alarm_type + '</div>' +
                                        '<div class="alarmcontent1 ml-3">' +
                                            '<span class="spanBlock" style="font-weight: bold;">' + item.alarm_content + '</span>' +
                                            '<span class="spanBlock" style="color: gray; font-size: 10pt;">' + formatDate(item.writedate) + ' </span>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>';
                    });
                } else {
                    html += '<span class="ml-2">지난 소식이 없습니다.</span>';
                }
                $('div#pastAlarmResult').html(html);
            },
            error: function(request, status, error){
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
    
    function readAlarm(alarmno){
        $.ajax({
            url : "<%=request.getContextPath()%>/readAlarm.alarm",
            data: {"alarmno": alarmno},
            type: 'POST',
            success: function(){},
            error: function(request, status, error){
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
    
    function readAllAlarm(){
        $.ajax({
            url : "<%=request.getContextPath()%>/readAllAlarm.alarm",
            success: function(){ 
                getAlarm();
                getPastAlarm();
            },
            error: function(request, status, error){
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
</script>

<!-- 게시판 알림 -->
<li class="nav-item dropdown">
    <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false" onclick="openAlarm()">
        <i class="mdi mdi-bell-outline"></i>
        <span class="count-symbol bg-danger"></span>
    </a>
    <div class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
        <h6 class="p-3 mb-0">알림창</h6>
        <div class="dropdown-divider"></div>
        <div id="alarmDropdown" class="alarmBody">
            <!-- 새로운 소식 시작 -->
            <div class="alarmTitle">
                <span style="font-size: 14pt; font-weight: bold; margin-left: 7px; flex-grow: 1;">새로운 소식</span>
                <button id="allReadAlarm" onclick="readAllAlarm()">모두 읽음</button>
            </div>
            <div id="newAlarmResult"></div>
            <!-- 새로운 소식 끝 -->
            
            <!-- 지난 소식 시작 -->
            <div class="alarmTitle mt-5">
                <span style="font-size: 14pt; font-weight: bold; margin-left: 7px; flex-grow: 1;">지난 소식</span>
            </div>
            <div id="pastAlarmResult"></div>
        </div>
    </div>
</li>
