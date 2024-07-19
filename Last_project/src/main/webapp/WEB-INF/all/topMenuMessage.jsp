<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<script src="resources/js/jquery.js"></script>
<!-- ////////////////////////////////////// -->
<!-- 메시지 탑메뉴 가장 최근 메시지 3개 뿌려주기 ajax -->

<script>
$(document).ready(function() {
    function unreadMsg() {
        $.ajax({
            url: 'topMenu.messenger',
            type: 'GET',
            headers: {
                'Accept': 'application/json'
            },
            success: function(data) {
                // 성공적으로 메시지를 받아왔을 때 처리
                console.log('Received unread messages:', data);

                // 메시지를 화면에 표시하는 예시
                var messageList = $('#topMenuMessageItem');
                messageList.empty(); // 기존 리스트 초기화

                // 새로운 메시지 여부 확인
                var hasUnreadMessage = false;

                $.each(data, function(index, message) {
                    // 메시지 항목 생성
                    var listItem = $('<li>');
                    var anchor = $('<a>').addClass('dropdown-item preview-item').attr('href', 'rlist.messenger');
                    var previewThumbnail = $('<div>').addClass('preview-thumbnail');
                    var profilePic = $('<img>').attr('src', message.profile_image).attr('alt', 'image').addClass('profile-pic');
                    var previewItemContent = $('<div>').addClass('preview-item-content d-flex align-items-start flex-column justify-content-center');
                    var previewSubject = $('<h6>').addClass('preview-subject ellipsis mb-1 font-weight-normal').html('<b>' + message.send_name + '</b>님이 메시지를 보냈습니다.');
                    var textGray = $('<p>').addClass('text-gray mb-0').text(message.send_time);

                    // 읽음 상태에 따라 배경색 설정
                    if (message.read_chk == 1) {
                        anchor.css('background', '#f6f6f6');
                    } else {
                        hasUnreadMessage = true; // 새로운 메시지가 있음
                    }

                    // 요소 조립
                    previewThumbnail.append(profilePic);
                    previewItemContent.append(previewSubject, textGray);
                    anchor.append(previewThumbnail, previewItemContent);
                    listItem.append(anchor);
                    messageList.append(listItem);
                });

                // 새로운 메시지 여부에 따라 bg-danger 클래스 추가/제거
                if (hasUnreadMessage) {
                    $('.msg-count-symbol').addClass('bg-danger');
                } else {
                    $('.msg-count-symbol').removeClass('bg-danger');
                }

                // 메시지 리스트 표시
                //$('#topMenuMessageList').show();
            },
            error: function(xhr, status, error) {
                console.error('Error fetching unread messages:', error);
            }
        });
    };

    // 페이지 로드 시 즉시 unreadMsg 함수 호출
    unreadMsg();

});
</script>