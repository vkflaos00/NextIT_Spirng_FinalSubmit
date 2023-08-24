<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/chat.css" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>

<title>채팅방</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />
<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet" />
<script type="text/javascript">
    let itemName = "${product.itemName}";
    document.title = "채팅방 - " + itemName; // 웹브라우저 탭 이름에도 표시
    $(document).ready(function() {
        $(".header h3").text("채팅방 (" + itemName + ")");
    });
</script>
<style type="text/css">
	div.header {
		position: sticky;
		top: 0;
		background-color : blue;
	}
</style>
</head>
<body>
	<div class="chat_wrap">
		<div class="header">
			<h3>채팅방(${login.name } - {{product.itemName}})</h3>
			<!-- 현재 접속 인원 표시 -->
 			<div>현재 접속 인원: <span id="userCount">0</span>명
 			</div>
		</div>
		<div class="card border mt-2 mb-2 float-center">
			<div class="card-header text-black px-2 py-1">
				<small class="float-left font-weight-bold">${product.storeType }</small>
				<small class="float-right font-weight-bold">${product.itemCategory}</small>
				<small class="float-right text-black mr-3"><i
					class="fa fa-sync-alt"></i>
					${fn:substring(product.updateDate,0,10)}</small>
			</div>
			<div class="card-body px-2 py-2">
				<div class="prod_img_div float-center text-center mr-2">
					<img onerror="this.style.display='none';"
						src="${product.imagePath }" class="prod_img"
						style="width: 100px; height: 100px;">
				</div>
				<div class="float-right">
					<strong>${product.itemName}</strong> <br> <i
						class="fa fa-coins text-warning pr-1"></i>
						<fmt:formatNumber value="${product.itemPrice}" pattern="#,###" />
						원
					<c:choose>
						<c:when test="${product.storeEvent eq '1+1'}">
							<span class="text-muted small">(<fmt:formatNumber
									value="${product.itemPrice / 2}" pattern="#,###" />원)
							</span>
						</c:when>
						<c:when test="${product.storeEvent eq '2+1'}">
							<span class="text-muted small">(<fmt:formatNumber
									value="${(product.itemPrice * 2) / 3}" pattern="#,###" />원)
							</span>
						</c:when>
						<c:when test="${product.storeEvent eq '3+1'}">
							<span class="text-muted small">(<fmt:formatNumber
									value="${(product.itemPrice * 3) / 4}" pattern="#,###" />원)
							</span>
						</c:when>
						<c:otherwise>
							<span class="text-muted small">(<fmt:formatNumber
									value="${(product.itemPrice * 4) / 5}" pattern="#,###" />원)
							</span>
						</c:otherwise>
					</c:choose>
					</span> <br> <span class="badge bg-cu text-black">${product.storeEvent }</span>
				</div>
			</div>
		</div>
		<div id="chat"></div>
		<script type="text/x-handlebars-template" id="temp">
		    <div class="{{printLeftRight sender}}">
		        <div class="sender">{{sender}}</div>
		        <div class="message">{{message}}</div>
		        <div class="date">{{date}}</div>
		    </div>
</script>
	<!-- 메시지 입력시 오른쪽 왼쪽으로 기입되는 방식 지정 -->
	<script type="text/javascript">
		let uid = "${login.id}";
		Handlebars.registerHelper("printLeftRight", function(sender) {
			if ( uid != sender) {
				return "left";
			} else {
				return "right";
			}
		});
	</script>
		<div class="input-div">
			<textarea id="txtMessage" rows="10" cols="30" placeholder="메시지를 입력한 후에 엔터키를 누르세요."></textarea>
		</div>
	</div>
	<script type="text/javascript">
	// 웹소켓 생성
	let sock = new WebSocket("ws://192.168.1.40:8080/conv/echo");  // 웹소켓 URL 사용
	
	// 서버로부터 접속 인원 수 받기
	sock.onmessage = function(event) {
	    let message = event.data;
	    if (message.startsWith("userCount:")) {
	        let userCount = message.split(":")[1];
	        $("#userCount").text(userCount);
	    } else {
	        // 일반 채팅 메시지 처리
	        onMessage(event);
	    }
	};

	$("#txtMessage").on("keypress", function (e) {
	    if (e.keyCode == 13 && !e.shiftKey) {
	        e.preventDefault();
	        let message = $("#txtMessage").val();
	        if (message == "") {
	            alert("메시지를 입력하세요.");
	            $("#txtMessage").focus();
	            return;
	        }
	        // 서버로 메시지 보내기
	        sock.send(uid + "|" + message);
	        $("#txtMessage").val("");
	    }
	});

	// 서버로부터 메시지 받기
	function onMessage(msg) {
		
	    let items = msg.data.split("|");
	    let sender = items[0];
	    let message = items[1];
	    let date = items[2];
	    let data = {
	        "message": message,
	        "sender": sender,
	        "date": date
	    };
	    let temp = Handlebars.compile($("#temp").html());
	    let renderedMessage = temp(data);
	    $("#chat").append(renderedMessage);
	    window.scrollTo(0, $("#chat").prop("scrollHeight"));
	}

	sock.onopen = function (event) {
		// 서버와 연결되었을 때 실행되는 코드
		let enterMessage = uid + "님 입장하셨습니다.";
		sock.send(enterMessage);
	}
	
	let userId = "${login.id}";
	let roomId = "${roomId}";
	
	window.onbeforeunload = function() {
	    // 사용자가 채팅방을 나갈 때 실행되는 코드
	    let exitMessage = uid + "님 퇴장하셨습니다.";
	    sock.send(exitMessage);

	    // 서버에 비동기적으로 데이터 전송
	    let data = new FormData();
	    data.append('id', userId);  // 사용자 ID
	    data.append('roomId', roomId); // 채팅방 ID
	    navigator.sendBeacon('${pageContext.request.contextPath }/chat/chatClose', data);
	};
	</script>
</body>
</html>