<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>실시간 알림</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        #notifications {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 5px;
        }
        .notification {
            padding: 10px;
            margin-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
    <script>
        $(document).ready(function() {
            // 초기 알림 목록 로딩
            loadNotifications();

            // 10초마다 알림 목록 업데이트
            setInterval(function() {
                loadNotifications();
            }, 10000); // 10초 마다 업데이트 (10000 밀리초 = 10초)
        });

        function loadNotifications() {
            $.ajax({
                url: '/notifications/fetch',
                type: 'GET',
                dataType: 'json',
                success: function(notifications) {
                    // 알림 목록을 처리하여 UI에 표시
                    var notificationsContainer = $('#notifications');
                    notificationsContainer.empty();
                    if (notifications.length === 0) {
                        notificationsContainer.append('<div class="notification">새로운 알림이 없습니다.</div>');
                    } else {
                        notifications.forEach(function(notification) {
                            notificationsContainer.append('<div class="notification">' + notification.message + '</div>');
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching notifications: ' + error);
                    $('#notifications').append('<div class="notification error">알림을 불러오는 중 오류가 발생했습니다.</div>');
                }
            });
        }
    </script>
</head>
<body>
    <div id="notifications">
        <!-- 알림이 여기에 동적으로 추가됩니다 -->
    </div>
</body>
</html>
