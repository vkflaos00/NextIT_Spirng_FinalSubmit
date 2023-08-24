<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHAT</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<style>
    .container {
        max-width: 600px;
        margin: 50px auto;
    }
    .chat-box {
        height: 300px;
        overflow-y: auto;
        border: 1px solid #ddd;
        padding: 10px;
    }
</style>
</head>
<body>
	<div class="container">
	    <h1 class="mb-4">WebSocket 채팅</h1>
	
	    <div class="form-group">
	        <input type="text" id="user" class="form-control" placeholder="유저명" value="${login.name }">
	    </div>
	    <div class="form-group">
	        <button type="button" id="btnConnect" class="btn btn-primary">연결</button>
	        <button type="button" id="btnDisconnect" class="btn btn-danger" disabled>종료</button>
	    </div>
	    <div class="chat-box" id="chatBox">
	        <!-- 채팅 메시지가 여기에 추가됩니다. -->
	    </div>
	    <div class="form-group mt-3">
	        <input type="text" id="msg" class="form-control" placeholder="대화 내용을 입력하세요." disabled>
	    </div>
	</div>
<script>
$(document).ready(function() {
    let ws;
    let user = '';

    $('#btnConnect').click(function() {
        user = $('#user').val().trim();
        if (user !== '') {
            // WebSocket 연결
            // ws = new WebSocket(createWebSocketUrl());
            ws = new WebSocket('ws://localhost:8080/conv/chatserver');
            console.log(ws);

            // 연결 이벤트 처리
            ws.onopen = function() {
                $('#btnConnect, #user').attr('disabled', true);
                $('#btnDisconnect, #msg').attr('disabled', false).focus();
                printMessage('', user + '님이 입장하셨습니다.');
            };

            // 메시지 수신 이벤트 처리
            ws.onmessage = function(event) {
                printMessage(event.data);
            };

            // 연결 종료 이벤트 처리
            ws.onclose = function() {
                printMessage('', user + '님이 퇴장하셨습니다.');
                $('#btnConnect, #user').attr('disabled', false);
                $('#btnDisconnect, #msg').attr('disabled', true);
            };
        }
    });

    $('#msg').keydown(function(event) {
        if (event.keyCode === 13) {
            if ($('#msg').val().trim() !== '') {
                ws.send(user + ': ' + $('#msg').val());
                $('#msg').val('');
            }
        }
    });

    $('#btnDisconnect').click(function() {
        ws.close();
    });

    /* function createWebSocketUrl() {
        let protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        let host = window.location.host;
        let path = '/chatserver';
        return protocol + '//' + host + path;
    } */


    function printMessage(message) {
        $('#chatBox').append($('<div>').text(message));
        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    }
    
 	// 상대방의 입장 메시지 출력
    function printEnterMessage(user) {
        $('#chatBox').append($('<div>').text(user + '님이 입장하셨습니다.'));
        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    }
});
</script>

<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/easing/easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/owlcarousel/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/isotope/isotope.pkgd.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/lightbox/js/lightbox.min.js"></script>
	<!-- Contact Javascript File -->
	<script
		src="${pageContext.request.contextPath }/mail/jqBootstrapValidation.min.js"></script>
	<script src="${pageContext.request.contextPath }/mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>